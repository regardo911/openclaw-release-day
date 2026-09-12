#!/bin/sh
# prove-authored.sh — Chapter 8. Proves every path in the file is authored, not inherited.
# The 2>&1 is four characters and it is the whole gate: `config get` prints its message on
# standard error, so without the redirect the check reads nothing, matches nothing, and
# reports success on an install where you have authored nothing at all.
#
# usage: ./prove-authored.sh [paths-file]     default: settings-paths.txt beside this script
#
# two messages fail, and they need opposite fixes. "valid but unset" means you are inheriting
# a default the next release is free to move. "Unknown config path" means you typed it wrong,
# and a misspelled security setting sits in your config looking authoritative and doing nothing.
# The printed sweep in the book only looks for the first. This file is one you edit, so it
# looks for both.

PATHS="${1:-$(dirname "$0")/settings-paths.txt}"
[ -f "$PATHS" ] || { echo "no paths file at $PATHS" >&2; exit 2; }

N=0
while IFS= read -r P; do
  case "$P" in ''|\#*) continue ;; esac
  N=$((N + 1))
  MSG=$(openclaw config get "$P" 2>&1)
  case "$MSG" in
    *'valid but unset'*)    echo "still a default: $P"; exit 1 ;;
    *'Unknown config path'*) echo "no such path, check the spelling: $P"; exit 1 ;;
  esac
done < "$PATHS"

# an empty file would otherwise sail through reporting success over nothing checked,
# which is the same shape of lie as a missing 2>&1.
[ "$N" -gt 0 ] || { echo "no paths in $PATHS. Nothing was checked."; exit 1; }

echo "$N authored"
