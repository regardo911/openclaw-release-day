# gotchas

things that actually bit while building this, with what they cost.

---

## the trip-wire reports "under ceiling" when it has no data at all

if the meter fails, jq gets
an empty stream, `COST` comes back empty, and awk reads an empty string as zero. zero is under
every ceiling you will ever set. reproduced under bash and zsh:

```
COST='3.10'  -> FIRED: over ceiling: 3.10
COST='1.00'  -> silent
COST=''      -> silent            <- this one
COST='null'  -> FIRED: over ceiling: null
```

`tripwire.sh` adds one line, `[ -n "$COST" ] ||`, and nothing else. both sides are real: the book's
rule is one command, one comparison, one exit, and a guard is a second branch. but a gate that
cannot fire is the exact trap the book spends twelve chapters describing. one line, no extra
comparison, in it goes. `null` is left alone on purpose: a loud wrong answer is a working gate.
tests cover all four.

## the settings sweep certifies a path you typed wrong

the printed sweep greps `valid but unset`.
a path that doesn't exist prints `Unknown config path: …`, which doesn't match, so it passes.
caught it because the test asserting otherwise failed first time:

```
FAIL sweep catches a path that does not exist — exit 0, wanted 1
```

matters because `settings-paths.txt` is a file you edit, and chapter 12 says you'll add keys to it. so
a typo isn't hypothetical, and a misspelled security setting sits in your config looking
authoritative and doing nothing. the chapter names that hazard in prose and then doesn't check for
it. `prove-authored.sh` reads the message once and branches on both.

## ci was about to grade itself green over a failing test run

wrote the step as
`./tests/run-tests.sh | tee out.txt`. github's default shell is `bash -e`, no pipefail, so the exit
code is tee's, and tee always succeeds.

```
$ bash -e -c 'false | tee /tmp/t';                 echo $?   -> 0
$ bash -e -c 'set -o pipefail; false | tee /tmp/t'; echo $?   -> 1
```

a red run would have shipped a green badge. exactly this repo's subject, written into this repo.
one line of `set -o pipefail`. the assertion-count check next to it covers the neighbouring lie: a
glob matching nothing exits 0, and a green badge over zero tests says nothing.

## `$SNAP` is assigned in prose and never by a command

chapter 4 says "call it `$SNAP` for the
rest of this", then uses `"$SNAP"` twice. unset, `backup sqlite verify ""` fails loudly with
`Missing required <snapshot> value.`, a dead end rather than a false verdict.
`rehearsal-round-trip.sh` takes it out of the manifest `create --json` already returns, read with
`jq -r .snapshotPath`, the same way the preflight gate reads `.status`.

while in there: `create` and `list` take `--repository`. `verify` and `restore` reject it and take
a positional path. two halves of one command group, two conventions.

## both chapter 8 loops end in `exit 1` inside a `for`

correct as a script. pasted into a live
terminal it closes your shell, and the moment you'd paste it is mid-upgrade. that's why
`record-before.sh` and `prove-authored.sh` are files with shebangs. nothing here asks you to paste
a loop.

## `memory session-backfill` is a dry run by default

it prints `Dry run; use --apply to stage candidates.`
the book never claims otherwise, but read quickly, run it, get no error, and you'll believe you
staged candidates when you staged none. same shape one command over: `openclaw memory forget` takes
no positional argument, and `memory forget <entry>` answers `Too many arguments for this command.`

## `--github-issue`: unresolved, left that way

it exists on `doctor`, scoped to
`--session-sqlite recover`. whether it does anything under any other mode is not something this
repo establishes, and nothing here depends on the answer. if you know, that's a welcome fix.

## the scanner that matched itself

first run of the "no real home paths in the tree" assertion
failed, pointing at the line of `run-tests.sh` holding the pattern. thirty seconds, and funny
enough to keep: the check now excludes itself, with a comment saying why.

## shellcheck passes locally and fails in CI

the two-argument guards in `rehearsal-round-trip.sh` and `rollback-gate.sh` were written
`[ -n "$1" ] && [ -n "$2" ] || { usage; exit 2; }`. shellcheck 0.11 says nothing about that.
the version on ubuntu-latest raises SC2015 on it and the run goes red.

the logic was never wrong, which is the annoying part: both arguments really are required, so the
`||` branch firing when the second is empty is the behaviour you want. rewritten as a plain
`if [ -z "$1" ] || [ -z "$2" ]`, which reads better anyway. if you send a patch and it passes on
your machine, that is not the same as passing here.
