#!/bin/sh
# preflight-gate.sh — Chapter 4. Branch on the status, never on the exit code.
# migration-required exits 0 as happily as exact does, so `preflight && upgrade` green-lights
# the one case you built the check to catch. Exit 1 here means "I could not read that file".
#
# usage: ./preflight-gate.sh <copied-db> [openclaw-binary]
#
# the second argument is the one people leave off. The answer you want belongs to the TARGET
# release, so pass its binary out of the throwaway prefix:
#   "$TMP"/node_modules/.bin/openclaw
# with no second argument you are asking your CURRENT release, which always says exact.

[ -n "$1" ] || {
  echo "usage: preflight-gate.sh <copied-db> [openclaw-binary]" >&2
  exit 2
}
OC="${2:-openclaw}"

STATUS=$("$OC" database preflight "$1" --json | jq -r .status)
[ "$STATUS" = "exact" ] || { echo "schema move ahead: $STATUS"; exit 1; }
echo "exact: that release opens this database without rewriting it"
