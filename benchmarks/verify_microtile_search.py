#!/usr/bin/env python3
"""Verify the published SSE microtile experiment without collecting samples."""

from collections import Counter, defaultdict
import math
import re
from statistics import median

from verify_blocking_results import DATA, REGISTER, compare_number, md_row, read_csv, require


RESULTS = DATA / "microtile_search"
SIZES = (128, 255, 256, 257, 511, 512, 513, 1024)
RECTANGLES = ((511, 1024, 512), (1024, 511, 512), (513, 1025, 257))
SHAPES = tuple((n, n, n) for n in SIZES) + RECTANGLES
NEW_TILES = ("3x16", "4x12", "6x8")
TILES = ("4x8", *NEW_TILES, "4x16")
VARIANTS = ("ikj", "cache", *TILES, "8x16")
BASELINES = ("ikj", "4x8", "4x16")
EVENTS = (
    "cycles:u", "instructions:u", "L1-dcache-loads:u", "L1-dcache-load-misses:u",
    "cache-references:u", "cache-misses:u", "ls_dispatch.ld_dispatch:u",
    "ls_dispatch.store_dispatch:u", "stalled-cycles-frontend:u",
)


def shape(row):
    return tuple(int(row[d]) for d in "mnk")


def label(dimensions):
    return "×".join(map(str, dimensions))


def unique_rows(filename, key):
    rows = read_csv(RESULTS, filename)
    result = {key(row): row for row in rows}
    require(len(rows) == len(result), f"duplicate rows in {filename}")
    return result


def percentile(samples, fraction):
    ordered = sorted(samples)
    position = (len(ordered) - 1) * fraction
    lower = math.floor(position)
    upper = math.ceil(position)
    return ordered[lower] + (position - lower) * (ordered[upper] - ordered[lower])


def verify_timing():
    series = defaultdict(dict)
    cases = {"strict_ikj": "ikj", "strict_cache_blocked": "cache"}
    for row in read_csv(RESULTS, "timing_samples.csv"):
        version = row["version"]
        require(version in (*cases, "strict_register_blocked"), version)
        variant = cases.get(version, row["micro"])
        key = shape(row), variant
        trial = int(row["pass"]), int(row["round"])
        require(trial not in series[key], f"duplicate timing sample: {key}, {trial}")
        require(int(row["outer"]) == (0 if variant == "ikj" else 128), key)
        require(int(row["calls"]) == (7 if key[0] == (128,) * 3 else 1), key)
        ns = float(row["ns_per_call"])
        compare_number(ns, float(row["elapsed_ns"]) / int(row["calls"]), key, absolute=1e-5)
        series[key][trial] = ns

    expected = {(dims, variant) for dims in SHAPES for variant in VARIANTS
                if variant != "8x16" or dims == (1024,) * 3}
    summary = unique_rows("timing_summary.csv", lambda r: (shape(r), r["variant"]))
    ratios = unique_rows("relative_gains.csv", lambda r: (shape(r), r["variant"], r["baseline"]))
    require(series.keys() == summary.keys() == expected, "timing grid")
    require(ratios.keys() == {(*key, b) for key in expected for b in BASELINES}, "ratio grid")

    medians = {}
    timing_rows = []
    gain_rows = []
    wins = {}
    batch = {}
    for dims in SHAPES:
        cells = []
        for variant in VARIANTS:
            key = dims, variant
            if key not in expected:
                cells.append("—")
                continue
            trials = series[key]
            require(trials.keys() == {(p, r) for p in (1, 2) for r in range(1, 10)}, key)
            ns = median(trials.values())
            medians[key] = ns
            low, high = [percentile(trials.values(), q) / 1e6 for q in (0.1, 0.9)]
            flops = 2 * math.prod(dims) / ns
            for field, value in zip(("samples", "median_ms", "p10_ms", "p90_ms", "gflops"),
                                    (18, ns / 1e6, low, high, flops)):
                compare_number(summary[key][field], value, (key, field))
            cells.append(f"{ns/1e6:.3f} [{low:.3f}–{high:.3f}] / {flops:.2f}")

            gains = []
            for baseline in BASELINES:
                ref = series[dims, baseline]
                speedup = median(ref.values()) / ns
                paired = {t: ref[t] / value for t, value in trials.items()}
                count = sum(r > 1 for r in paired.values())
                key_ratio = (*key, baseline)
                wins[key_ratio] = count
                passes = tuple(median(v for (p, _), v in paired.items() if p == i) for i in (1, 2))
                batch[key_ratio] = passes
                fields = ("speedup", "wins", "ties", "samples", "win_rate",
                          "pass1_paired_median_speedup", "pass2_paired_median_speedup")
                values = (speedup, count, sum(r == 1 for r in paired.values()), 18, count / 18, *passes)
                for field, value in zip(fields, values):
                    compare_number(ratios[key_ratio][field], value, (key_ratio, field))
                gains.append(f"{speedup:.3f} / {count}")
            if variant in NEW_TILES:
                gain_rows.append(md_row(label(dims), variant, *gains))
        timing_rows.append(md_row(label(dims), *cells))

    decision_rows = []
    for tile in NEW_TILES:
        values = []
        for n in (512, 1024):
            key = (n,) * 3, tile, "4x16"
            require(wins[key] == 0 and max(batch[key]) < 1, key)
            values.extend(f"{ratio:.3f}" for ratio in batch[key])
        require(all(medians[d, tile] > medians[d, "4x16"] for d in RECTANGLES), tile)
        decision_rows.append(md_row(tile.replace("x", "×"), *values))
    require(sum(min(NEW_TILES, key=lambda tile: medians[d, tile]) == "6x8" for d in SHAPES) == 9,
            "6x8 rank among new tiles")
    n = (1024,) * 3
    require(f'{medians[n, "4x16"]/1e6:.3f}' == "75.082", "4x16 at 1024")
    require(f'{medians[n, "8x16"]/1e6:.3f}' == "74.225", "8x16 at 1024")
    require(wins[n, "8x16", "4x16"] == 12, "8x16 paired wins")
    require(f'{(medians[n, "4x16"]/medians[n, "8x16"]-1)*100:.1f}' == "1.2", "8x16 advantage")
    return timing_rows, gain_rows, decision_rows


def verify_pmu():
    trials = defaultdict(dict)
    log = Counter()
    for line in (RESULTS / "perf_log.txt").read_text().splitlines():
        fields = line.split(",")
        if len(fields) >= 5 and fields[2] in EVENTS and fields[0].isdigit():
            log[fields[2], int(fields[0]), float(fields[4])] += 1

    for row in read_csv(RESULTS, "pmu_samples.csv"):
        key = int(row["n"]), row["tile"], int(row["trial"])
        event, count, running = row["event"], int(row["count"]), float(row["running_percent"])
        require(running == 100 and event not in trials[key], key)
        trials[key][event] = count / int(row["calls"])
        log[event, count, running] -= 1

    require(all(v == 0 for v in log.values()), "PMU log and CSV")
    require(trials.keys() == {(n, t, i) for n in (512, 1024) for t in TILES for i in (1, 2, 3)},
            "PMU grid")
    for n in (512, 1024):
        for tile in TILES:
            group = [trials[n, tile, i] for i in (1, 2, 3)]
            require(all(t.keys() == set(EVENTS) for t in group), (n, tile))
            values = [median(t[e] for t in group) / 1e6 for e in EVENTS]
            values.insert(2, median(t[EVENTS[1]] / t[EVENTS[0]] for t in group))
            yield md_row(n, tile, *(f"{v:.3f}" for v in values))


def verify_assembly():
    previous = (REGISTER / "strict_register_blocked_ikj.asm").read_text()
    for tile in ("2x8", "4x8", "4x16", "8x16"):
        require((RESULTS / f"disassembly/{tile}.asm").read_text().rstrip() in previous,
                f"old microkernel body changed: {tile}")
    for tile, spill in (("4x8", 0), ("3x16", 2), ("4x12", 1), ("6x8", 0), ("4x16", 6)):
        text = (RESULTS / f"disassembly/{tile}.asm").read_text()
        instructions = [(int(a, 16), op) for a, op in re.findall(r"^\s*([0-9a-f]+):\s*(.*)$", text, re.M)]
        begin, end = next((int(m[1], 16), a) for a, op in instructions
                          if (m := re.match(r"jne\s+([0-9a-f]+) <", op)) and int(m[1], 16) < a)
        hot = [op for a, op in instructions if begin <= a <= end]
        rows, columns = map(int, tile.split("x"))
        acc = rows * columns // 4
        for opcode, count in (("shufps", rows), ("movups", columns // 4), ("mulps", acc), ("addps", acc)):
            require(sum(op.startswith(opcode + " ") for op in hot) == count, (tile, opcode))
        stack = [op for op in hot if "(%rsp)" in op and "%xmm" in op]
        reads = sum(op.startswith("addps ") for op in stack)
        writes = sum(op.startswith("movaps ") for op in stack)
        require(reads == writes == spill and len(stack) == reads + writes, tile)
        require(not any(("%rbp)" in op and "%xmm" in op) or op.startswith(("v", "hadd")) for op in hot),
                f"unexpected stack or instruction-set use: {tile}")
        prologue = [op for a, op in instructions if a < begin]
        saved = 8 * sum(op.startswith("push ") for op in prologue)
        reserved = sum(int(m[1], 16) for op in prologue
                       if (m := re.match(r"sub\s+\$0x([0-9a-f]+),%rsp", op)))
        yield md_row(tile.replace("x", "×"), acc, rows, columns // 4, f"{acc} / {acc}",
                     f"0x{begin:x}–0x{end:x}", f"{saved} + {reserved}", f"{reads} / {writes}")


def main():
    numeric = read_csv(RESULTS, "numerics.csv")
    require(len(numeric) == 288 and sum(int(r["elements"]) for r in numeric) == 3437559,
            "numeric grid")
    require(all(r["bitwise_ikj"] == r["elements"] for r in numeric), "strict bitwise equality")
    ordinary = [r for r in numeric if r["case"].startswith("random")]
    require(len(ordinary) == 198 and all(r["tol_fail_ref"] == "0" for r in ordinary),
            "ordinary reference tolerance")
    timing, gains, decision = verify_timing()
    expected = list(verify_assembly()) + timing + gains + list(verify_pmu()) + decision
    for lang in ("en", "zh-CN"):
        path = RESULTS / f"report_{lang}.md"
        rows = [line for line in path.read_text().splitlines() if re.match(r"^\| \d", line)]
        require(rows == expected, f"table mismatch: {path.name}")
    print("PASS: 1,404 timing samples, 288 numeric comparisons, 270 PMU counts, "
          "spill evidence, unchanged old microkernels and both report tables")


if __name__ == "__main__":
    main()
