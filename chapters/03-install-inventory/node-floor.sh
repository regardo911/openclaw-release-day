#!/bin/sh
# node-floor.sh — Chapter 3. Node first, then OpenClaw.
# The reason is SQLite TEXT truncation, which is silent damage, not a failed install.
# This is the one check in this repo that needs nothing but node.
#
# usage: ./node-floor.sh [version]      no argument = whatever `node -v` says

V="${1:-$(node -v 2>&1)}"
V="${V#v}"
MAJ="${V%%.*}"
REST="${V#*.}"
MIN="${REST%%.*}"

case "$MAJ" in
  ''|*[!0-9]*)
    echo "no version to read. node said: $V"; exit 1 ;;
  24)
    [ "$MIN" -ge 16 ] && { echo "at the floor: $V"; exit 0; }
    echo "below the floor: $V. The 24 line starts at 24.16.0."; exit 1 ;;
  26)
    [ "$MIN" -ge 1 ] && { echo "at the floor: $V"; exit 0; }
    echo "below the floor: $V. The 26 line starts at 26.1.0."; exit 1 ;;
  22|23|25)
    echo "unsupported line: $V. The install page names 22, 23 and 25 unsupported."; exit 1 ;;
  *)
    # the book's floor covers two lines. anything else, it refuses to guess and so does this.
    # failing closed is the point: a gate that passes what it cannot read is the trap.
    echo "unknown, you must observe this: $V is outside the 24 and 26 lines the floor names."
    echo "check the install page on the day you upgrade, not a video."; exit 1 ;;
esac
