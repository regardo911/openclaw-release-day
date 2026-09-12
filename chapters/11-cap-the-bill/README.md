# Chapter 11: Cap the bill

The revenue side only moves when you do something. The cost side can move on its own, overnight,
in one direction, because a default changed.

Educational material, not financial advice. See [DISCLAIMER.md](../../DISCLAIMER.md).

## What you build

`spend-sheet.md`, a provider-capped key, and a scheduled trip-wire you have watched fire.

## The one command

```bash
./tripwire.sh <ceiling>
```

```
under ceiling: 1.00
```

or `over ceiling: 3.10` and exit 1.

The ceiling is an argument because it is yours: above your worst normal day, well below anything
that would upset you. The book's own `2.50` is a demonstration and says so.

## Set the provider cap first

**There is no spend cap inside OpenClaw.** Searching all 6,518 configuration paths at 2026.9.4:
`budget` returns zero, `quota` returns zero, and `spend` returns one path about suspending idle
cloud workers, which is unrelated.

The fallback model list is not one either. Its description is identical across releases: *"Used
when the primary model fails."* Failure, not cost. If you have been carrying a vague sense that
your fallback configuration is also a financial safety net, now is a better moment to find out
than later.

So the hard stop lives in the provider's console, on the key you gave the agent. This trip-wire is
the second layer: it fires earlier and it degrades the way **you** chose, rather than stopping your
agent dead at a moment you didn't pick.

## What success looks like

You lowered the ceiling below yesterday's actual figure, let the scheduled check run, and watched
the thing you chose actually happen. Then you put the ceiling back.

A trip-wire you have never seen fire is a trip-wire you are guessing about.

## One line this gate has that the printed one does not

If the meter does not answer, `COST` comes back empty, an empty string reads as zero, and zero is
under every ceiling. So the six-line version reports a quiet all-clear at the exact moment it has
no idea what you spent.

This one adds a single guard: no figure is a failure, not a pass. The comparison is untouched:
one command, one comparison, one exit. [GOTCHAS.md](../../GOTCHAS.md) has the reproduction.

## On your install

The multiplier people miss is `nodeHost.workerRuns.capacity`, whose default is the number of CPU
cores, which means **your token spend depends on your hardware.** Move the same install to a
bigger box, change nothing else, and its capacity for concurrent work goes up. Sensible
engineering default, surprising billing default.

Pinning it also makes your rehearsal predict production, which an unpinned capacity does not.
