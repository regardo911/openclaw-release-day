# Chapter 7: Preserve, and then compound

Two problems, two files. The first makes the work survive. The second makes each cycle cost less
than the last.

**What you build:** `automations.md`, carrying the why next to the what. And a memory entry per
cycle, from `memory-entry.template.md`.

**Fill in first:** for one automation, all three lines. What it does, why it exists, and **what
"working" looks like.**

Line 3 is doing all the work. Records survive an upgrade and reasoning doesn't, because the
reasoning only ever existed in the conversation where you set the thing up. That is why a perfect
backup would not have saved the people who lost this: you cannot restore something that was never
stored.

**Success, one:** you deleted a live automation from the disposable copy, restored it from your
repository, and it ran and did what line 3 says. If you could restore the artifact but could not
tell whether it was working, line 3 is not specific enough yet.

**Success, two:** two timings for the same failure on different cycles, and the second is smaller.
If it is not, the useful question is which of the five fields was missing when you went looking.
Both ship blank; nobody can supply them but you.

**On your install:** this directory holds `memory-entry.template.md` and deliberately not a
`MEMORY.md`. `openclaw memory promote --apply` appends to a file by that name, so a clone sitting
anywhere your agent can reach would get the product appending to it.

One feature to know is running, because most people with it enabled have no idea:
`skills.workshop.autonomous.mode` defaults to `auto`, and something has been editing your skills on
a schedule since you installed this. Put them in the repository and a background edit becomes a
diff you can read.

Memory does not get weird at random either. It gets pruned on a schedule with numbers you never
set: `session.maintenance.pruneAfter` at `30d`, `maxEntries` at 5000, `maxDiskBytes` at `10gb`.
Note the two verbs in the first. Durable conversations are **archived**, which is reversible, and
disposable automation entries are **removed**, which is not.
