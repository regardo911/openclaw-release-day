#!/bin/sh
# record-before.sh — Chapter 8. Your before-state, captured before you change anything.
# Paste the output into your inventory under a heading naming the release you were on.
#
# usage: ./record-before.sh [paths-file]      default: settings-paths.txt beside this script
#
# the 2>&1 matters here for the same reason it matters in prove-authored.sh: the message
# you are reading for goes to standard error, so without it the pipe is empty.

PATHS="${1:-$(dirname "$0")/settings-paths.txt}"
[ -f "$PATHS" ] || { echo "no paths file at $PATHS" >&2; exit 2; }

while IFS= read -r P; do
  case "$P" in ''|\#*) continue ;; esac
  echo "== $P"
  openclaw config get "$P" 2>&1
done < "$PATHS"

# this one records, it does not judge. `config get` exits 1 on every unset path, and letting that
# fall out of the loop would make a successful recording look like a failure.
exit 0
