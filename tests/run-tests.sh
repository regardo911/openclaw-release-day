#!/bin/sh
# tests/run-tests.sh — proves every gate in this repo takes the right branch.
# Runs on a bare machine: no network, no key, no account, no OpenClaw. It needs sh and jq.
#
# usage: ./tests/run-tests.sh

HERE=$(cd "$(dirname "$0")" && pwd)
ROOT=$(dirname "$HERE")
PASS=0
FAIL=0

ok()   { PASS=$((PASS + 1)); echo "ok   $1"; }
nope() { FAIL=$((FAIL + 1)); echo "FAIL $1"; }

# run <fake-state|-> <command...>
run() {
  state="$1"
  shift
  if [ "$state" = "-" ]; then
    OUT=$("$@" 2>&1)
  else
    OUT=$(PATH="$HERE/fake-openclaw/$state:$PATH" "$@" 2>&1)
  fi
  RC=$?
}

rc()  { if [ "$RC" -eq "$2" ]; then ok "$1"; else nope "$1 — exit $RC, wanted $2"; fi; }
says() { case "$OUT" in *"$2"*) ok "$1" ;; *) nope "$1 — said: $OUT" ;; esac; }

PREFLIGHT="$ROOT/chapters/04-rehearse-on-a-copy/preflight-gate.sh"
ROLLBACK="$ROOT/chapters/06-recovery-runbook/rollback-gate.sh"
PROVE="$ROOT/chapters/08-pin-the-defaults/prove-authored.sh"
RECORD="$ROOT/chapters/08-pin-the-defaults/record-before.sh"
TRIPWIRE="$ROOT/chapters/11-cap-the-bill/tripwire.sh"
NODEFLOOR="$ROOT/chapters/03-install-inventory/node-floor.sh"
OOM="$ROOT/chapters/09-the-always-on-box/oom-check.sh"

echo "-- preflight gate: the status decides, not the exit code"
run preflight-exact "$PREFLIGHT" /any/copy.sqlite
rc   "preflight passes on exact" 0
says "preflight says exact" "exact"

# the fake exits 0 on migration-required, exactly as the product does.
# a gate reading \$? would green-light the one-way door here.
run preflight-migration-required "$PREFLIGHT" /any/copy.sqlite
rc   "preflight FAILS on migration-required even though the command exited 0" 1
says "preflight names the status it stopped on" "migration-required"

run preflight-unreadable "$PREFLIGHT" /any/not-a-db
rc   "preflight fails closed on a file it cannot read" 1

run - "$PREFLIGHT"
rc   "preflight refuses with no database argument" 2
says "preflight prints a usage line" "usage:"

echo "-- rollback gate: the older binary is the argument that matters"
run preflight-exact "$ROLLBACK" /any/copy.sqlite openclaw
rc   "rollback allowed when the older release says exact" 0

run preflight-migration-required "$ROLLBACK" /any/copy.sqlite openclaw
rc   "rollback blocked when the older release cannot open the data" 1
says "rollback says so in words" "do not roll back"

run - "$ROLLBACK" /any/copy.sqlite
rc   "rollback refuses without the older binary" 2

echo "-- settings sweep: the message decides, and it arrives on stderr"
PATHSFILE="$HERE/tmp-paths.txt"
printf '# a comment\n\ntools.sessions.visibility\ntools.swarm.enabled\n' > "$PATHSFILE"

run config-authored "$PROVE" "$PATHSFILE"
rc   "sweep passes when every path is authored" 0
says "sweep counts from the file rather than saying five" "2 authored"

# config get prints this on stderr and exits 1. Without 2>&1 the pipe is empty,
# the grep never matches, and the sweep reports success over nothing.
run config-unset "$PROVE" "$PATHSFILE"
rc   "sweep catches an inherited default printed on stderr" 1
says "sweep names the path that is still a default" "still a default: tools.sessions.visibility"

run config-unknown "$PROVE" "$PATHSFILE"
rc   "sweep catches a path that does not exist" 1

printf '# nothing but a comment\n' > "$HERE/tmp-empty.txt"
run config-authored "$PROVE" "$HERE/tmp-empty.txt"
rc   "sweep refuses to report success over an empty list" 1

run - "$RECORD" /no/such/paths.txt
rc   "record-before refuses when the paths file is missing" 2

rm -f "$PATHSFILE" "$HERE/tmp-empty.txt"

echo "-- trip-wire: a figure it did not get is not a figure under the ceiling"
run usage-cost-over "$TRIPWIRE" 2.50
rc   "trip-wire fires over the ceiling" 1
says "trip-wire prints the cost it fired on" "over ceiling: 3.10"

run usage-cost-under "$TRIPWIRE" 2.50
rc   "trip-wire stays quiet under the ceiling" 0

# without the guard this exits 0: an empty cost reads as zero and sails under any ceiling.
run usage-cost-empty "$TRIPWIRE" 2.50
rc   "trip-wire fails when the meter did not answer" 1
says "trip-wire says the meter did not answer" "meter did not answer"

run usage-cost-null "$TRIPWIRE" 2.50
rc   "trip-wire fires rather than passing when the cost field is null" 1

run - "$TRIPWIRE"
rc   "trip-wire refuses without a ceiling" 2

echo "-- node floor: two lines, and it refuses to guess about the rest"
run - "$NODEFLOOR" v24.16.0
rc   "node 24.16.0 is at the floor" 0
run - "$NODEFLOOR" v24.15.9
rc   "node 24.15.9 is below the floor" 1
run - "$NODEFLOOR" v26.1.0
rc   "node 26.1.0 is at the floor" 0
run - "$NODEFLOOR" v26.0.9
rc   "node 26.0.9 is below the floor" 1
run - "$NODEFLOOR" v25.4.0
rc   "node 25 is named unsupported" 1
run - "$NODEFLOOR" banana
rc   "node floor fails closed on something it cannot read" 1

echo "-- oom check"
run - "$OOM"
rc   "oom-check refuses without a container name" 2
says "oom-check prints a usage line" "usage:"

echo "-- nothing here ships filled in"
if grep -rn '\$[0-9]*\.[0-9]' "$ROOT/chapters" >/dev/null 2>&1; then
  nope "a money figure is sitting in a template"
else
  ok "no money figure in any template"
fi

# this file is excluded because it is the one that carries the pattern it hunts for.
if grep -rn -e '/Users/' -e '/home/[a-z]' "$ROOT" --exclude-dir=.git --exclude=run-tests.sh >/dev/null 2>&1; then
  nope "a real home path is in the tree"
else
  ok "no real home path anywhere in the tree"
fi

if find "$ROOT" -name .git -prune -o \
     \( -name MEMORY.md -o -name compose.yml -o -name openclaw.json \
        -o -name SKILL.md -o -name '.openclaw' -o -name '*.filled.md' \) -print \
     | grep -q .; then
  nope "a file the reader's own install would collide with is in the tree"
else
  ok "no MEMORY.md, compose.yml, openclaw.json, .openclaw or SKILL.md in the tree"
fi

echo
echo "$((PASS + FAIL)) assertions, $FAIL failed"
[ "$FAIL" -eq 0 ] || exit 1
