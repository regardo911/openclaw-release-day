<!-- re-entry.md (Chapter 12). For when you fall off it, and you will. -->

# Re-entry

A busy month, a release you skipped, a trip-wire you silenced because it was noisy and never
un-silenced. Four months later you are several releases behind, unsure what you are running,
vaguely dreading it.

Six steps. Short on purpose.

**1. Do not upgrade anything.** Not yet. Getting current in one jump is the worst available move,
because you'll cross several releases with no idea which one moved what.

**2. Find out where you are.** `./collect-inventory.sh`. Ten minutes, entirely read-only, and it
converts dread into facts.

**3. Read your own memory store.** This is where the compounding pays out hardest. You have notes
on the last three upgrades, written by you, including which defaults moved and what broke. Nobody
else has that document and past-you wrote it for exactly this moment.

**4. Check the schema boundary before choosing a target.** `preflight-gate.sh` a copy against the
release you are considering, with that release's binary. If there is a one-way door between here
and there, cross it as two deliberate upgrades rather than one long jump.

**5. Score `go-no-go.md`.** Your score will be worse than last time, because "releases behind" has
gone up. That is the table doing its job: telling you to rehearse, with a number instead of a
feeling.

**6. Then the ordinary procedure.** Rehearse, upgrade, verify, and write the memory entry,
including a line about the gap itself.

---

| | Yours |
|---|---|
| Date I fell off | |
| Date I came back | |
| Releases behind on re-entry | |
| What the gap cost | |

---

Every gate here branches on something the release prints rather than on a number this repo
printed: the preflight gate reads the status out of the release you are actually installing, the
sweep greps a message the product emits about your own configuration, the trip-wire reads a cost
figure out of your own install, and the probe reads your gateway's own answer.

That is why the routine outlives the numbers in it.
