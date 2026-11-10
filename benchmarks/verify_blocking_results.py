#!/usr/bin/env python3
"""Recompute the published blocking results without running any benchmarks."""

import argparse
from collections import Counter, defaultdict
import csv
import hashlib
import math
from pathlib import Path
import re
from statistics import median, quantiles

from run_blocked_experiment import EVENTS, SIDES, SIZES
from run_register_experiment import CANDIDATES, OPTIONAL_EVENTS


ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "experiments/blocked_ikj/ryzen7730u"
REGISTER = DATA / "register_fastmath"
VERSIONS = (
    "strict_ikj", "fast_ikj", "strict_cache_blocked", "fast_cache_blocked",
    "strict_register_blocked", "fast_register_blocked",
)
GAINS = (
    "cache_strict", "cache_fast", "register_strict", "register_fast",
    "fast_ikj", "fast_cache", "fast_register", "interaction",
)


def require(condition, message):
    if not condition:
        raise ValueError(message)


def read_csv(folder, name):
    with (folder / name).open(newline="") as stream:
        return list(csv.DictReader(stream))


def compare_number(actual, expected, context, absolute=1e-12):
    require(math.isclose(float(actual), expected, rel_tol=1e-12, abs_tol=absolute),
            f"{context}: recorded {actual}, expected {expected}")


def md_row(*cells):
    return "| " + " | ".join(map(str, cells)) + " |"


def timing(folder, key_fields, rounds):
    samples = defaultdict(dict)
    for row in read_csv(folder, "timing_samples.csv"):
        key = tuple(row[field] for field in key_fields)
        trial = (int(row["pass"]), int(row["round"]))
        require(trial not in samples[key], f"duplicate timing sample: {key}, {trial}")
        compare_number(row["ns_per_call"], float(row["elapsed_ns"]) / int(row["calls"]), key,
                       absolute=1e-5)
        samples[key][trial] = float(row["ns_per_call"])

    summary = {}
    for row in read_csv(folder, "timing_summary.csv"):
        key = tuple(row[field] for field in key_fields)
        require(key not in summary, f"duplicate summary row: {key}")
        trials = samples[key]
        expected_trials = {(p, r) for p in (1, 2) for r in range(1, rounds + 1)}
        require(trials.keys() == expected_trials and int(row["samples"]) == len(trials), key)
        n = int(key[0])
        baseline_key = (key[0], "strict_ikj", "0", "none") if rounds == 9 else (key[0], "0")
        baseline = samples[baseline_key]
        ns = median(trials.values())
        deciles = quantiles(trials.values(), n=10, method="inclusive")
        metrics = {
            "median_ms": ns / 1e6,
            "p10_ms": deciles[0] / 1e6,
            "p90_ms": deciles[8] / 1e6,
            "gflops": 2 * n**3 / ns,
        }
        speedup = median(baseline.values()) / ns
        if rounds == 21:
            metrics["speedup"] = speedup
            metrics["faster_rounds"] = sum(v < baseline[t] for t, v in trials.items())
            for field in ("median_ms", "p10_ms", "p90_ms"):
                metrics[field] = round(metrics[field], 9)
            for field in ("gflops", "speedup"):
                metrics[field] = round(metrics[field], 6)
        else:
            metrics["speedup_vs_strict_ikj"] = speedup
        for field, value in metrics.items():
            compare_number(row[field], value, (key, field))
        summary[key] = metrics
    require(samples.keys() == summary.keys(), f"timing grid mismatch: {folder}")
    return samples, summary


def pmu_rows(folder, key_fields, events, digits):
    counts = defaultdict(dict)
    raw = read_csv(folder, "pmu_samples.csv")
    for row in raw:
        key = tuple(row[field] for field in key_fields)
        sample = counts[key, int(row["trial"])]
        event = row["event"]
        require(event not in sample and float(row["running_percent"]) == 100.0,
                f"duplicate or multiplexed PMU event: {key}, {event}")
        sample[event] = int(row["count"]) / int(row["calls"])

    # Verify that no event count was changed during the log-to-CSV export.
    log = Counter()
    for line in (folder / "perf_log.txt").read_text().splitlines():
        fields = line.split(",")
        if len(fields) >= 5 and fields[2] in events and fields[0].isdigit():
            log[fields[2], int(fields[0]), float(fields[4])] += 1
    # Optional event probes are logged once before the recorded trials.
    for sample, count in Counter(
        (row["event"], int(row["count"]), float(row["running_percent"])) for row in raw
    ).items():
        require(log[sample] >= count, f"PMU CSV count missing from process log: {sample}")

    rendered = []
    keys = sorted({key for key, _ in counts}, key=lambda k: (
        int(k[0]), int(k[1]) if len(k) == 2 else k[1], k[2:]
    ))
    for key in keys:
        trials = [counts[key, trial] for trial in (1, 2, 3)]
        require(all(t.keys() == set(events) for t in trials), key)
        columns = [f"{median(t[event] for t in trials) / 1e6:.3f}" for event in events]
        columns.insert(2, f"{median(t[EVENTS[1]] / t[EVENTS[0]] for t in trials):.{digits}f}")
        display = [key[0], "ikj" if key[1] == "0" else key[1]] if len(key) == 2 else [
            key[0], f"`{key[1]}`", key[2]
        ]
        rendered.append(md_row(*display, *columns))
    return rendered


def verify_cache_numerics():
    rows = read_csv(DATA, "numerics.csv")
    ordinary = [r for r in rows if r["case"] == "random"]
    cancellation = [r for r in rows if r["case"] == "cancellation"]
    require(len(ordinary) == 70 and len(cancellation) == 7, "cache numerical grid")
    require(all(r["bitwise_ikj"] == r["elements"] for r in rows), "cache bitwise comparison")
    require(sum(int(r["elements"]) for r in rows) == 1637146, "cache compared elements")
    require(sum(int(r["bitwise_reference"]) for r in ordinary) == 192612, "cache oracle matches")
    require(all(r["tolerance_failures"] == "0" and r["classification_mismatches"] == "0"
                and r["signed_zero_mismatches"] == "0" for r in ordinary),
            "ordinary cache oracle comparison")
    require(all(r["tolerance_failures"] == "1" and float(r["max_abs_reference"]) == 2.0
                and float(r["max_rel_reference"]) == 0.5 and int(r["max_ulp_reference"]) == 8388608
                for r in cancellation), "cache cancellation comparison")


def numeric_rows():
    rows = read_csv(REGISTER, "numerics.csv")
    require(len(rows) == 484 and all(r["bitwise_ikj"] == r["elements"] for r in rows),
            "register numerical comparisons")
    for name in VERSIONS:
        group = [r for r in rows if r["version"] == name]
        ordinary = [r for r in group if r["case"].startswith("random")]
        cancellation = [r for r in group if not r["case"].startswith("random")]
        require(all(int(r["tol_fail_ref"]) == 0 for r in ordinary), name)
        vals = []
        for selected, decimals in ((ordinary, ".6g"), (cancellation, ".6g")):
            vals.extend(format(max(float(r[f]) for r in selected), decimals)
                        for f in ("abs_ref", "rel_ref"))
            vals.append(f'{max(int(r["ulp_ref"]) for r in selected):,}')
        yield md_row(f"`{name}`", 0, *vals, sum(int(r["tol_fail_ref"]) for r in cancellation))


def register_tables(samples, summary):
    perf = []
    for n in SIZES:
        cells = []
        for version in VERSIONS:
            outer = "0" if version.endswith("_ikj") else "128"
            micro = "4x16" if "register" in version else "none"
            r = summary[str(n), version, outer, micro]
            cells.append(f'{r["median_ms"]:.3f} [{r["p10_ms"]:.3f}–{r["p90_ms"]:.3f}]'
                         f' / {r["gflops"]:.2f} / {r["speedup_vs_strict_ikj"]:.3f}')
        perf.append(md_row(n, *cells))
        for policy in ("strict", "fast"):
            winner = min(CANDIDATES, key=lambda tile:
                         summary[str(n), f"{policy}_register_blocked", "128", tile]["median_ms"])
            require(winner == "4x16", f"candidate rank changed: {n}, {policy}")
        for run in (1, 2):
            def run_median(version, outer, micro):
                values = samples[str(n), version, outer, micro]
                return median(value for (p, _), value in values.items() if p == run)

            register = run_median("strict_register_blocked", "128", "4x16")
            require(register < min(run_median("strict_ikj", "0", "none"),
                                   run_median("strict_cache_blocked", "128", "none")),
                    f"strict register gain not repeated: {n}, pass {run}")

    gain_rows = []
    gain_grid = read_csv(REGISTER, "relative_gains.csv")
    require(len(gain_grid) == 64, "relative-gain grid size")
    for row in gain_grid:
        n, outer, micro = (row[k] for k in ("n", "outer", "micro"))
        si, fi, sc, fc, sr, fr = [
            summary[n, name, o, t]["median_ms"] for name, (o, t) in zip(VERSIONS, (
                ("0", "none"), ("0", "none"), (outer, "none"), (outer, "none"),
                (outer, micro), (outer, micro),
            ))
        ]
        ratios = (si / sc, fi / fc, sc / sr, fc / fr, si / fi, sc / fc, sr / fr, (sr / fr) / (sc / fc))
        for field, value in zip(GAINS, ratios):
            compare_number(row[field], value, (n, outer, micro, field))
        if outer == "128" and micro == "4x16":
            gain_rows.append(md_row(n, *(f"{v:.3f}" for v in ratios)))

    si = summary["1024", "strict_ikj", "0", "none"]["median_ms"]
    sc = summary["1024", "strict_cache_blocked", "128", "none"]["median_ms"]
    sr = summary["1024", "strict_register_blocked", "128", "4x16"]["median_ms"]
    print(f"1024 strict 4x16: {si:.3f} / {sr:.3f} = {si/sr:.3f}x vs original ikj; "
          f"{sc:.3f} / {sr:.3f} = {sc/sr:.3f}x vs cache blocking")
    return perf, gain_rows


def verify_report(prefix, expected):
    for lang in ("en", "zh-CN"):
        path = ROOT / f"docs/{prefix}_{lang}.md"
        rows = [line for line in path.read_text().splitlines()
                if re.match(r"^\| (\d|`(?:strict|fast)_)", line)]
        # Assembly evidence is verified from objdump separately.
        rows = [row for row in rows if not re.match(r"^\| \d×\d", row)]
        require(len(rows) == len(expected), f"table row count mismatch: {path.name}")
        for actual, computed in zip(rows, expected):
            require(actual == computed, f"{path.name}:\n{actual}\nexpected\n{computed}")


def verify_assembly():
    for policy in ("strict", "fast"):
        text = (REGISTER / f"{policy}_register_blocked_ikj.asm").read_text()
        for tile, begin, end, count in (
            ("2ul, 8ul", 0x40, 0x7e, 0), ("4ul, 8ul", 0x110, 0x18a, 0),
            ("4ul, 16ul", 0x2c0, 0x3c7, 12), ("8ul, 16ul", 0x720, 0x999, 44),
        ):
            body = text.split(f"::microkernel<{tile}>", 1)[1].split("\n\n", 1)[0]
            hot = [op for address, op in re.findall(r"^\s*([0-9a-f]+):\s*(.*)$", body, re.M)
                   if begin <= int(address, 16) <= end]
            require(bool(hot) and hot[-1].startswith(f"jne    {begin:x} "), (policy, tile, "back edge"))
            require(sum("(%rsp)" in op and "%xmm" in op for op in hot) == count,
                    (policy, tile, "stack references"))


def verify_originals(original_dir):
    for line in (DATA / "original_sha256.txt").read_text().splitlines():
        digest, file = line.split()
        published = (DATA / file).read_bytes()
        if file.endswith(".csv"):
            require(hashlib.sha256(published).hexdigest() == digest, file)
        if original_dir is not None:
            original = (original_dir / file).read_bytes()
            require(hashlib.sha256(original).hexdigest() == digest, file)
            normalized = original.replace(str(ROOT).encode(), b"<REPO>")
            if file == "perf_log.txt":
                normalized = normalized.rstrip(b"\n") + b"\n"
            require(normalized == published, file)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--original-dir", type=Path, help="optional archived phase-one originals")
    args = parser.parse_args()

    verify_originals(args.original_dir)
    verify_cache_numerics()
    _, cache = timing(DATA, ("n", "bm"), 21)
    require(len(cache) == 48, "cache timing grid size")
    require(all(r["speedup"] <= 1.05 or r["faster_rounds"] < 0.9 * 42
                for r in cache.values()), "stable phase-one gain")
    cache_rows = [md_row(n, *(
        f'{r["median_ms"]:.3f} / {r["gflops"]:.2f} / {r["speedup"]:.3f}'
        for r in (cache[str(n), str(side)] for side in SIDES)
    )) for n in SIZES]
    verify_report("blocked_ikj", cache_rows + pmu_rows(DATA, ("n", "block"), EVENTS, 2))

    samples, register = timing(REGISTER, ("n", "version", "outer", "micro"), 9)
    require(len(register) == 176, "register timing grid size")
    perf, gains = register_tables(samples, register)
    counters = pmu_rows(REGISTER, ("n", "version", "micro"), EVENTS + OPTIONAL_EVENTS, 3)
    verify_report("register_fastmath", list(numeric_rows()) + perf + gains + counters)
    verify_assembly()
    print("PASS: original hashes, timing summaries, gain ratios, PMU, numerics, spill evidence and both report pairs")


if __name__ == "__main__":
    main()
