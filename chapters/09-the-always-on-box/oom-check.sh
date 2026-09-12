#!/bin/sh
# oom-check.sh — Chapter 9. The box died overnight and OpenClaw's logs say nothing.
# Very often the kernel killed it: one headless browser can take a gigabyte on a small VPS.
#
# usage: ./oom-check.sh <container>
# line one is container-only. line two wants a Linux kernel.

[ -n "$1" ] || {
  echo "usage: oom-check.sh <container>" >&2
  echo "name the container. There is no sensible default and guessing one would be worse." >&2
  exit 2
}

echo "== docker inspect OOMKilled"
docker inspect -f '{{.State.OOMKilled}}' "$1"
echo "   true here means stop looking at OpenClaw. It is a memory problem in an OpenClaw costume."

echo "== kernel ring buffer"
case "$(uname -s)" in
  Darwin)
    echo "skipped: dmesg -T is Linux-only. On a Mac it exits 1 with 'usage: sudo dmesg' and"
    echo "tells you nothing about memory. Do not read that as 'no out-of-memory kill'."
    ;;
  *)
    dmesg -T | grep -i -e oom -e killed
    ;;
esac
