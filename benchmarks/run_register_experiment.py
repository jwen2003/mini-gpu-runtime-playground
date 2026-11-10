#!/usr/bin/env python3
"""Capture matched register blocking and fast-math trials on Linux."""

import argparse
from collections import defaultdict
import csv
import json
import os
from pathlib import Path
import shlex
import shutil
from statistics import median, quantiles
import subprocess
import time

from run_blocked_experiment import EVENTS, SIZES, capture, metadata, portable_text, write_csv


CANDIDATES = ("2x8", "4x8", "4x16")
OPTIONAL_EVENTS = (
    "ls_dispatch.ld_dispatch:u", "ls_dispatch.store_dispatch:u", "stalled-cycles-frontend:u",
)


def record_build(build, output, cpu):
    info = metadata(build, cpu, 2)
    objects = []
    for entry in info["compile_commands"]:
        command = shlex.split(entry["command"])
        obj = command[command.index("-o") + 1]
        fast = "matmul_register_fast.dir" in obj
        if ("-ffast-math" in command) != fast:
            raise ValueError(f"unexpected fast-math policy for {obj}")
        if any(flag.startswith(("-march=", "-mfma", "-mavx")) for flag in command):
            raise ValueError(f"expected the phase-one ISA configuration for {obj}")
        name = Path(entry["file"]).stem
        if name in {"ikj", "blocked_ikj", "register_blocked_ikj"}:
            policy = "fast" if fast else "strict"
            objects.append((obj, f"{policy}_{name}.asm"))
    commands = (build / "compile_commands.json").read_text()
    (output / "compile_commands.json").write_text(portable_text(commands, build))
    (output / "environment.json").write_text(portable_text(json.dumps(info, indent=2) + "\n", build))
    for obj, file in objects:
        assembly = capture("objdump", "-d", "-C", "--no-show-raw-insn", str(build / obj))
        (output / file).write_text(portable_text(assembly + "\n", build))


def measure(prefix, output):
    raw = []
    for n in SIZES:
        for trial in (1, 2):
            start = time.monotonic()
            result = capture(*prefix, "sweep", str(n), str(20261110 + trial))
            raw.extend({"pass": trial, **row} for row in csv.DictReader(result.splitlines()))
            print(f"N={n}, pass={trial}, seconds={time.monotonic() - start:.2f}", flush=True)
    write_csv(output / "timing_samples.csv", raw)

    groups = defaultdict(list)
    for row in raw:
        key = tuple(row[k] for k in ("n", "version", "outer", "micro"))
        groups[key].append(float(row["ns_per_call"]))

    summary = []
    for (n, version, outer, micro), samples in sorted(groups.items(), key=lambda p: (
        int(p[0][0]), p[0][1], int(p[0][2]), p[0][3]
    )):
        ns = median(samples)
        deciles = quantiles(samples, n=10, method="inclusive")
        baseline = median(groups[n, "strict_ikj", "0", "none"])
        summary.append({
            "n": n, "version": version, "outer": outer, "micro": micro,
            "samples": len(samples), "median_ms": ns / 1e6, "p10_ms": deciles[0] / 1e6,
            "p90_ms": deciles[8] / 1e6, "gflops": 2 * int(n)**3 / ns,
            "speedup_vs_strict_ikj": baseline / ns,
        })
    write_csv(output / "timing_summary.csv", summary)
    return summary


def ratios(summary, output):
    data = {(int(r["n"]), r["version"], r["outer"], r["micro"]): r["median_ms"]
            for r in summary}
    rows = []
    for n in SIZES:
        si = data[n, "strict_ikj", "0", "none"]
        fi = data[n, "fast_ikj", "0", "none"]
        for outer in ("128", "64"):
            sc = data[n, "strict_cache_blocked", outer, "none"]
            fc = data[n, "fast_cache_blocked", outer, "none"]
            for micro in (*CANDIDATES, "8x16"):
                sr = data[n, "strict_register_blocked", outer, micro]
                fr = data[n, "fast_register_blocked", outer, micro]
                rows.append({
                    "n": n, "outer": outer, "micro": micro,
                    "cache_strict": si / sc, "cache_fast": fi / fc,
                    "register_strict": sc / sr, "register_fast": fc / fr,
                    "fast_ikj": si / fi, "fast_cache": sc / fc, "fast_register": sr / fr,
                    "interaction": (sr / fr) / (sc / fc),
                })
    write_csv(output / "relative_gains.csv", rows)


def collect_pmu(prefix, output, summary):
    rows = []
    with (output / "perf_log.txt").open("w") as log:
        if not shutil.which("perf"):
            log.write("perf unavailable\n")
            return

        def run(events, command):
            args = [*prefix[:3], "perf", "stat", "--no-big-num", "-x", ",",
                    "-e", ",".join(events), "--", *command]
            result = subprocess.run(args, text=True, capture_output=True)
            if log.tell():
                log.write("\n")
            log.write(portable_text(
                f"$ {shlex.join(args)}\nexit={result.returncode}\n"
                f"{(result.stdout + result.stderr).rstrip(chr(10))}\n", Path(prefix[3]).parent
            ))
            return [line.split(",") for line in result.stderr.splitlines()]

        supported = []
        for event in OPTIONAL_EVENTS:
            probe = run((event,), ["sleep", "0.02"])
            if any(len(row) >= 5 and row[2] == event and row[0].isdigit() for row in probe):
                supported.append(event)

        for n in (128, 512, 1024):
            cases = [r for r in summary if int(r["n"]) == n and r["outer"] == "128"]
            selected = [r for r in cases if r["micro"] in {"none", "8x16"}]
            for policy in ("strict", "fast"):
                selected.append(min(
                    (r for r in cases if r["version"] == f"{policy}_register_blocked"
                     and r["micro"] in CANDIDATES), key=lambda r: r["median_ms"]
                ))
            calls = max(5, round(300 / max(r["median_ms"] for r in selected)))
            for trial in range(1, 4):
                for row in selected:
                    cmd = [prefix[3], "counter", str(n), str(calls),
                           row["version"], row["outer"], row["micro"]]
                    for events in (EVENTS, tuple(supported)):
                        if not events:
                            continue
                        for fields in run(events, cmd):
                            if len(fields) >= 5 and fields[2] in events:
                                rows.append({
                                    "n": n, "version": row["version"], "outer": row["outer"],
                                    "micro": row["micro"], "trial": trial, "calls": calls,
                                    "event": fields[2], "count": fields[0],
                                    "running_percent": fields[4],
                                })
    if rows:
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
    prefix = ["taskset", "-c", str(args.cpu), str(build / "register_experiment")]
    record_build(build, args.output, args.cpu)
    (args.output / "numerics.csv").write_text(capture(*prefix, "numerics") + "\n")
    summary = measure(prefix, args.output)
    ratios(summary, args.output)
    collect_pmu(prefix, args.output, summary)


if __name__ == "__main__":
    main()
