# Spherical-Wavelets

An implementation of **spherical wavelet transforms** using the **Shannon scale function** and the **Driscoll–Healy method**. This project applies spherical wavelets to **gravity potential data** derived from the [WHU-SWPU-GOGR2022S model](https://icgem.gfz-potsdam.de).

## Overview
Spherical wavelets provide a powerful multi-resolution framework for analyzing geophysical data on the sphere. Unlike traditional spherical harmonic approaches, wavelets preserve localized frequency and spatial information, making them ideal for studying complex variations in potential fields such as Earth’s gravity.

The implementation decomposes gravity potential data into **smooth** and **detail** components across multiple scales (1–8), enabling localized analysis of geophysical features.

---

## Features
- Shannon scale and wavelet functions on the sphere.
- Driscoll–Healy quadrature for spherical harmonic transforms.
- Decomposition of gravity potential data into multiple scales.
- Smooth and detail map generation for visual analysis.
- Example figures replicating the report results.

---

## Example Output
- Smooth and detail parts of gravity potential for scales 1–8 (see `/Outputs/Plots`).
- Multi-resolution analysis plots similar to those in the report.

