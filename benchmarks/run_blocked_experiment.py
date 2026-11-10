#!/usr/bin/env python3
"""Run the strict blocked ikj sweep and collect process-level PMU samples."""

import argparse
import csv
import json
import os
from pathlib import Path
import shutil
import statistics
import subprocess
import time


SIDES = (0, 8, 16, 32, 64, 128)
SIZES = (128, 255, 256, 257, 511, 512, 513, 1024)
EVENTS = (
    "cycles:u", "instructions:u", "L1-dcache-loads:u", "L1-dcache-load-misses:u",
    "cache-references:u", "cache-misses:u",
)


def write_csv(path, rows):
    with path.open("w", newline="") as stream:
        writer = csv.DictWriter(stream, fieldnames=list(rows[0]), lineterminator="\n")
        writer.writeheader()
        writer.writerows(rows)


def capture(*command):
    return subprocess.check_output(command, text=True).strip()


def portable_text(text, build):
    """Keep full commands while removing paths unique to the recording host."""
    root = Path.cwd()
    build = build.resolve()
    if not build.is_relative_to(root):
        text = text.replace(str(build), "<BUILD>")
    return text.replace(str(root), "<REPO>")


def metadata(build, cpu, passes):
    commands = json.loads((build / "compile_commands.json").read_text())
    return {
        "utc_start": time.strftime("%Y-%m-%dT%H:%M:%SZ", time.gmtime()),
        "base_commit": capture("git", "rev-parse", "HEAD"),
        "cpu_affinity": cpu,
        "passes": passes,
        "compiler": capture(commands[0]["command"].split()[0], "--version"),
        "kernel": capture("uname", "-srvmo"),
        "os_release": Path("/etc/os-release").read_text(),
        "cpu": capture("lscpu"),
        "cache": capture("lscpu", "--caches"),
        "compile_commands": commands,
        "perf_version": capture("perf", "--version") if shutil.which("perf") else None,
        "perf_event_paranoid": Path("/proc/sys/kernel/perf_event_paranoid").read_text().strip(),
    }


def run_sweeps(build, output, cpu, passes):
    raw = []
    runtimes = {}
    for n in SIZES:
        runtimes[n] = []
        for pass_index in range(1, passes + 1):
            start = time.monotonic()
            result = capture(
                "taskset", "-c", str(cpu), str(build / "cpu_benchmark"),
                "blocked-sweep", str(n), str(n), str(n),
            )
            runtimes[n].append(round(time.monotonic() - start, 3))
            raw.extend({"pass": pass_index, **row}
                       for row in csv.DictReader(result.splitlines()))
            print(f"N={n}, pass={pass_index}, seconds={runtimes[n][-1]}", flush=True)
    write_csv(output / "timing_samples.csv", raw)

    groups = {}
    for row in raw:
        key = int(row["n"]), int(row["bm"])
        trial = int(row["pass"]), int(row["round"])
        groups.setdefault(key, {})[trial] = float(row["ns_per_call"])

    summary = []
    for n in SIZES:
        baseline = groups[n, 0]
        baseline_median = statistics.median(baseline.values())
        for side in SIDES:
            trials = groups[n, side]
            values = list(trials.values())
            median = statistics.median(values)
            deciles = statistics.quantiles(values, n=10, method="inclusive")
            summary.append({
                "n": n, "bm": side, "bn": side, "bk": side,
                "samples": len(trials), "median_ms": round(median / 1e6, 9),
                "p10_ms": round(deciles[0] / 1e6, 9),
                "p90_ms": round(deciles[8] / 1e6, 9),
                "gflops": round(2 * n**3 / median, 6),
                "speedup": round(baseline_median / median, 6),
                "faster_rounds": sum(value < baseline[trial] for trial, value in trials.items()),
            })
    write_csv(output / "timing_summary.csv", summary)
    return summary, runtimes


def run_pmu(build, output, cpu, summary):
    if not shutil.which("perf"):
        (output / "perf_log.txt").write_text("perf is unavailable\n")
        return []

    # Choose the first measured size with a >5% median improvement and at
    # least 90% faster paired rounds, or the closest observed point.
    best = {
        n: max((row for row in summary if row["n"] == n and row["bm"]),
               key=lambda row: row["speedup"])
        for n in SIZES
    }
    crossover = next(
        (n for n in SIZES if best[n]["speedup"] > 1.05
         and best[n]["faster_rounds"] / best[n]["samples"] >= 0.9),
        max(SIZES[1:-1], key=lambda n: best[n]["speedup"]),
    )
    cases = list(dict.fromkeys((SIZES[0], crossover, SIZES[-1])))
    if len(cases) < 3:
        cases.insert(1, 512)
    raw = []
    with (output / "perf_log.txt").open("w") as log:
        for n in cases:
            sides = {0, 8, 128, best[n]["bm"]}
            if n > 256:
                # Probe a larger tile separately from the cubic timing sweep.
                sides.add(256)
            sides = sorted(sides)
            slowest = max(row["median_ms"] for row in summary
                          if row["n"] == n and row["bm"] in sides)
            count = max(5, round(300 / slowest))
            for trial in range(1, 4):
                for side in sides:
                    command = [
                        "taskset", "-c", str(cpu), "perf", "stat", "--no-big-num",
                        "-x", ",", "-e", ",".join(EVENTS), "--",
                        str(build / "cpu_benchmark"), "blocked-counter",
                        str(n), str(n), str(n), str(count),
                    ]
                    if side:
                        command += [str(side)] * 3
                    result = subprocess.run(command, text=True, capture_output=True)
                    if log.tell():
                        log.write("\n")
                    log.write(portable_text(
                        f"$ {' '.join(command)}\nexit={result.returncode}\n"
                        f"{(result.stdout + result.stderr).rstrip(chr(10))}\n", build
                    ))
                    for line in result.stderr.splitlines():
                        fields = line.split(",")
                        if len(fields) >= 5 and fields[2] in EVENTS:
                            raw.append({
                                "n": n, "block": side, "trial": trial, "calls": count,
                                "event": fields[2], "count": fields[0],
                                "running_percent": fields[4],
                            })
    if raw:
        write_csv(output / "pmu_samples.csv", raw)
    return cases


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("build", type=Path)
    parser.add_argument("output", type=Path)
    parser.add_argument("--cpu", type=int, default=min(os.sched_getaffinity(0)))
    parser.add_argument("--passes", type=int, default=2)
    args = parser.parse_args()
    if args.passes < 1:
        parser.error("--passes must be positive")
    args.output.mkdir(parents=True, exist_ok=False)
    build = args.build.resolve()
    info = metadata(build, args.cpu, args.passes)
    with (args.output / "numerics.csv").open("w") as report:
        subprocess.run([build / "blocked_numerics_test"], stdout=report, check=True)
    summary, info["sweep_wall_seconds"] = run_sweeps(
        build, args.output, args.cpu, args.passes
    )
    info["pmu_sizes"] = run_pmu(build, args.output, args.cpu, summary)
    (args.output / "environment.json").write_text(portable_text(json.dumps(info, indent=2) + "\n", build))


if __name__ == "__main__":
    main()
