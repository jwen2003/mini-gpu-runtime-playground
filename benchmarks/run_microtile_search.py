#!/usr/bin/env python3
"""Measure strict SSE microtiles and save paired timing and counter results."""

import argparse
from collections import defaultdict
import csv
import json
import os
from pathlib import Path
import re
import shlex
from statistics import median, quantiles
import subprocess

from run_blocked_experiment import EVENTS, SIZES, capture, metadata, portable_text, write_csv
from run_register_experiment import OPTIONAL_EVENTS


SHAPES = [(n, n, n) for n in SIZES] + [(511, 1024, 512), (1024, 511, 512), (513, 1025, 257)]
TILES = ("4x8", "3x16", "4x12", "6x8", "4x16")
BASELINES = ("ikj", "4x8", "4x16")


def record_build(build, output, cpu):
    info = metadata(build, cpu, 2)
    commands = info["compile_commands"]
    forbidden = ("-Ofast", "-ffast-math", "-fassociative-math", "-march=", "-mavx", "-mfma")
    for entry in commands:
        flags = shlex.split(entry["command"])
        if any(flag.startswith(forbidden) for flag in flags):
            raise ValueError("microtile search requires the strict baseline SSE flags")
    (output / "environment.json").write_text(portable_text(json.dumps(info, indent=2) + "\n", build))
    (output / "compile_commands.json").write_text(
        portable_text((build / "compile_commands.json").read_text(), build)
    )

    entry = next(r for r in commands if Path(r["file"]).name == "register_blocked_ikj.cpp")
    command = shlex.split(entry["command"])
    obj = Path(entry["directory"]) / command[command.index("-o") + 1]
    asm = capture("objdump", "-d", "-C", "--no-show-raw-insn", str(obj))
    disassembly = output / "disassembly"
    disassembly.mkdir()
    for body in asm.split("\n\n"):
        match = re.match(r"^[0-9a-f]+ <.*::microkernel<(\d+)ul, (\d+)ul>", body)
        if match:
            name = "x".join(match.groups())
            (disassembly / f"{name}.asm").write_text(body + "\n")
    if not all((disassembly / f"{tile}.asm").exists() for tile in TILES):
        raise ValueError("missing a full-tile disassembly")


def variant_key(row):
    return {"strict_ikj": "ikj", "strict_cache_blocked": "cache"}.get(row["version"], row["micro"])


def summarize(raw, output):
    samples = defaultdict(dict)
    for row in raw:
        shape = tuple(int(row[d]) for d in ("m", "n", "k"))
        key = shape, variant_key(row)
        trial = int(row["pass"]), int(row["round"])
        if trial in samples[key]:
            raise ValueError(f"duplicate timing sample: {key}, {trial}")
        samples[key][trial] = float(row["ns_per_call"])

    summary = []
    ratios = []
    medians = {}
    for shape in SHAPES:
        m, n, k = shape
        expected = ("ikj", "cache", *TILES)
        if shape == (1024, 1024, 1024):
            expected += ("8x16",)
        for name in expected:
            trial_values = samples[shape, name]
            if trial_values.keys() != {(p, r) for p in (1, 2) for r in range(1, 10)}:
                raise ValueError(f"incomplete timing samples: {shape}, {name}")
            ns = median(trial_values.values())
            deciles = quantiles(trial_values.values(), n=10, method="inclusive")
            medians[shape, name] = ns / 1e6
            summary.append({
                "m": m, "n": n, "k": k, "variant": name,
                "outer": 0 if name == "ikj" else 128, "samples": len(trial_values),
                "median_ms": ns / 1e6, "p10_ms": deciles[0] / 1e6,
                "p90_ms": deciles[8] / 1e6, "gflops": 2 * m * n * k / ns,
            })
            for baseline in BASELINES:
                ref = samples[shape, baseline]
                paired = {t: ref[t] / value for t, value in trial_values.items()}
                ratios.append({
                    "m": m, "n": n, "k": k, "variant": name, "baseline": baseline,
                    "speedup": median(ref.values()) / ns,
                    "wins": sum(v > 1 for v in paired.values()),
                    "ties": sum(v == 1 for v in paired.values()),
                    "samples": len(paired),
                    "win_rate": sum(v > 1 for v in paired.values()) / len(paired),
                    "pass1_paired_median_speedup": median(v for (p, _), v in paired.items() if p == 1),
                    "pass2_paired_median_speedup": median(v for (p, _), v in paired.items() if p == 2),
                })
    write_csv(output / "timing_summary.csv", summary)
    write_csv(output / "relative_gains.csv", ratios)
    return medians


def collect_pmu(prefix, output, medians):
    rows = []
    with (output / "perf_log.txt").open("w") as log:
        def run(events, command):
            args = [*prefix[:3], "perf", "stat", "--no-big-num", "-x", ",",
                    "-e", ",".join(events), "--", *command]
            result = subprocess.run(args, text=True, capture_output=True, check=True)
            if log.tell():
                log.write("\n")
            text = (result.stdout + result.stderr).rstrip("\n")
            log.write(portable_text(f"$ {shlex.join(args)}\n{text}\n", Path(prefix[3]).parent))
            return [line.split(",") for line in result.stderr.splitlines()]

        for n in (512, 1024):
            calls = max(5, round(300 / max(medians[(n, n, n), tile] for tile in TILES)))
            for trial in range(1, 4):
                # Rotate the tile order without changing the measurement for any tile.
                order = TILES[trial - 1:] + TILES[:trial - 1]
                for tile in order:
                    cmd = [prefix[3], "counter", str(n), str(calls),
                           "strict_register_blocked", "128", tile]
                    for events in (EVENTS, OPTIONAL_EVENTS):
                        result = {fields[2]: fields for fields in run(events, cmd)
                                  if len(fields) >= 5 and fields[2] in events}
                        for event in events:
                            fields = result.get(event)
                            rows.append({
                                "n": n, "tile": tile, "trial": trial, "calls": calls,
                                "event": event, "count": fields[0] if fields else "missing",
                                "running_percent": fields[4] if fields else "",
                            })
            print(f"PMU N={n} completed", flush=True)
    write_csv(output / "pmu_samples.csv", rows)


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("build", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--cpu", type=int, default=min(os.sched_getaffinity(0)))
    args = parser.parse_args()
    args.output.mkdir(parents=True, exist_ok=True)
    if any(args.output.iterdir()):
        parser.error("output directory must be empty")
    build = args.build.resolve()
    prefix = ["taskset", "-c", str(args.cpu), str(build / "microtile_search")]
    record_build(build, args.output, args.cpu)
    (args.output / "numerics.csv").write_text(capture(*prefix, "numerics") + "\n")
    raw = []
    for shape in SHAPES:
        for trial in (1, 2):
            data = capture(*prefix, "sweep", *map(str, shape), str(20261110 + trial))
            raw.extend({"pass": trial, **row} for row in csv.DictReader(data.splitlines()))
            print(f"{shape}, pass={trial} completed", flush=True)
    write_csv(args.output / "timing_samples.csv", raw)
    medians = summarize(raw, args.output)
    collect_pmu(prefix, args.output, medians)


if __name__ == "__main__":
    main()
