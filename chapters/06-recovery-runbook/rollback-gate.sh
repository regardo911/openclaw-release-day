#!/bin/sh
# rollback-gate.sh — Chapter 6. Run this before you install an older version, or don't roll back.
# An older build refuses a database written by a newer schema. Roll back above the door and you
# convert a broken install into one that will not start, while panicking.
#
# usage: ./rollback-gate.sh <copied-db> <older-openclaw-binary>
#
# BOTH arguments are required and the second is the whole gate. You are asking the release you
# are about to install what it thinks of your data. Asking your current release proves nothing.

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: rollback-gate.sh <copied-db> <older-openclaw-binary>" >&2
  echo "the older binary is the point of the gate. Without it you are asking the wrong release." >&2
  exit 2
fi

STATUS=$("$2" database preflight "$1" --json | jq -r .status)
[ "$STATUS" = "exact" ] || { echo "do not roll back: $STATUS"; exit 1; }
echo "exact: that older release can open this database. Rolling back is a real escape."
