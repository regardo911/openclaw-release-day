#!/bin/sh
# tripwire.sh — Chapter 11. Fires before the provider's hard cap does, and degrades the way you chose.
# Educational material. Not financial advice. See DISCLAIMER.md.
#
# usage: ./tripwire.sh <ceiling>
#
# the ceiling is yours. Derive it from your own 30-day baseline: above your worst normal day,
# well below anything that would upset you. The book's own 2.50 is a demonstration and says so.
#
# one command, one comparison, one exit. Keep it that small. The moment it grows a parser or a
# retry loop it is a program you will stop maintaining, and an unmaintained trip-wire is worse
# than none because you will still believe it is watching.

[ -n "$1" ] || { echo "usage: tripwire.sh <ceiling>" >&2; exit 2; }
CEILING="$1"

COST=$(openclaw gateway usage-cost --days 1 --all-agents --json | jq -r '.daily[-1].totalCost')

# an empty COST reads as zero and sails under any ceiling. That silent pass is the one thing
# a trip-wire must never do, so no figure is a failure rather than a quiet all-clear.
[ -n "$COST" ] || { echo "no cost figure came back. The meter did not answer."; exit 1; }

awk -v c="$COST" -v ceil="$CEILING" 'BEGIN{exit !(c>ceil)}' && {
  echo "over ceiling: $COST"
  exit 1
}
echo "under ceiling: $COST"
