# Chapter 12: The standing routine

Every artifact you now hold is useful, and every one is waiting for you to remember it.

## What assembles

`stage-table.md`, `schedule.md`, and a maintainer agent held at a deliberate version skew.

## The rule that makes a second agent worth having

Fill in two cells in `stage-table.md` first: your primary's version and schema number, and your
maintainer's. That pair is what you check before every release-day run, and the rule that
makes a second agent worth having is a bound nobody states:

**Skew within a schema generation, not across one.**

Two agents on the same release share that release's bugs, so an identical maintainer is a copy of
the problem rather than redundancy. Skew too far and the maintainer cannot open the primary's state
at all, because an older build refuses a database written by a newer schema. So on the day you
need it, the thing you built to help you is refused at the door.

Which inverts the release-day intuition. If the target crosses a schema boundary, the **maintainer
moves first**, so the thing supervising the migration is not the thing that will be refused
afterwards.

## Done when

The cold-start test passes. Pick the current release, run the entire release-day routine end
to end from the top without reading the book and without improvising (inventory, snapshot, verify,
preflight, score, rehearse), stopping before the real upgrade. Every point where you had to stop
and think is a gap. **Fix the artifact, not your memory.**

## When you fall off it

`re-entry.md` is the one to read when you've fallen off this, and you will.
A busy month, a release you skipped, a trip-wire you silenced because it was noisy. Re-entry costs
an evening rather than a weekend, because every file here kept being true while you were not
looking at it.

Two things need updating as releases ship, and that is the whole maintenance cost of this pipeline:
a new key in `settings-paths.txt` when a release adds a security-relevant setting, and a new target
version in the top row of `go-no-go.md`. One line each.
