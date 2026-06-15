# tools/

## Purpose

Utility binaries bundled into the container image for manual in-container diagnostics. Not part of the runtime service stack.

## Ownership

Project-wide; no subdirectory boundaries.

## Local Contracts

- `speedtest` — Ookla Speedtest CLI binary (v1.0.0, linux); used to measure VPN tunnel throughput from inside the container
- `speedtest.md` — man-page style reference for the `speedtest` binary

## Work Guidance

- Binaries here are copied into the image via `COPY ./tools ./tools` in the Dockerfile; they must be compatible with the `ubuntu:20.04` base image
- To replace `speedtest`, update both the binary and `speedtest.md` together and note the new version

## Verification

Inside the container: `./tools/speedtest` should complete a speed test and exit 0.
