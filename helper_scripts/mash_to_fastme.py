#!/usr/bin/env python3

import sys

infile = sys.argv[1]
outfile = sys.argv[2]

with open(infile) as f:
    lines = [x.strip() for x in f if x.strip()]

n = int(lines[0])

names = []
matrix = [[0.0 for _ in range(n)] for _ in range(n)]

for i, line in enumerate(lines[1:]):
    parts = line.split()
    name = parts[0]
    names.append(name)

    distances = parts[1:]

    for j, d in enumerate(distances):
        matrix[i][j] = float(d)
        matrix[j][i] = float(d)

# Write PHYLIP distance matrix
with open(outfile, "w") as out:
    out.write(f"{n}\n")

    for i in range(n):
        # PHYLIP names are traditionally max 10 chars
        label = names[i][:10]
        out.write(f"{label:<10}")

        for j in range(n):
            out.write(f" {matrix[i][j]:.8f}")

        out.write("\n")