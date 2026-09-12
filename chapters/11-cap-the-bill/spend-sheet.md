<!-- spend-sheet.md (Chapter 11). Four rows, updated monthly, kept next to the margin sheet. -->

# spend-sheet.md

| Row | Source | Yours |
|---|---|---|
| Cost per day, typical and worst | `openclaw gateway usage-cost --days 30 --all-agents --json` | |
| Cost per agent | `openclaw gateway usage-cost --days 30 --agent <id> --json` | |
| Cost per run of the paid job | that agent's cost divided by run count | |
| **The ceiling I chose, and why** | yours | |

**Month:**

That last row matters more than it looks. In three months you'll see the number and wonder
whether you still mean it, exactly like the pinned settings.

Choose the ceiling above your worst normal day and well below anything that would upset you.
Roughly double your typical day is a reasonable start, and it will be wrong. Adjust after the
first false alarm, which is data rather than a failure. Then `./tripwire.sh <ceiling>`, daily.

---

## The provider cap

The only hard stop in the system, and it lives in the provider's console rather than in OpenClaw.
One setting, clicked once, today.

| | Yours |
|---|---|
| Provider cap set to | |
| Date set | |

Every subscription you already pay for and every key you hand this agent is a spending channel it
can start without you watching. Cap the ones that can be capped and write down the ones that
cannot, because those are the ones where your only defence is the trip-wire.

| Key or subscription | Capped | At what |
|---|---|---|
| | | |

---

## The degrade

What happens when the trip-wire fires. Pick one deliberately: the scheduled job pauses until you
look at it, or the agent keeps answering you but stops taking new automated work, or the channel
gets a message and nothing else changes.

It must **not** be a fallback model. Those fire on failure rather than on cost and will not
trigger here at all.

| | Yours |
|---|---|
| My degrade | |
| Forced it to fire on (date) | |
| Did the degrade actually happen | _unknown, you must observe this_ |

Lower the ceiling below yesterday's actual figure, let the scheduled check run, confirm the thing
you chose happened, then put the ceiling back.

---

## The multipliers to pin

Run `openclaw config get` on each and count how many come back unset. Every one is a multiplier
you are currently inheriting, and the fix for each is one line.

| Path | Yours |
|---|---|
| `nodeHost.workerRuns.capacity`. *"default: the number of available CPU cores … an integer from 1 through 1024"*. Start at 2 and raise it when you can point at a job that is queuing | |
| `agents.defaults.subagents.maxSpawnDepth`. The chapter 8 pin, arriving here with a bill attached | |
| `tools.swarm.enabled`. Fan-out multiplied by nesting depth is not additive | |

Top-level concurrency is CPU-derived too, bounded between eight and sixteen, and you cannot fully
pin it. Which leaves one lever: **the size of the box.**
