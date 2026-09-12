<!-- margin-sheet.md (Chapter 10). Eight rows, and only one of them comes from the product. -->

# margin-sheet.md

| Row | Where it comes from | Yours |
|---|---|---|
| What the job is | one sentence. Needing a clause about exceptions means it is too big for a first one | |
| Who pays for the outcome | a name, not a market | |
| What they pay, per unit delivered | your price | |
| Runs per unit delivered | count it, including retries. Three runs because two failed is three runs | |
| Revenue per run | price divided by runs | |
| Token cost per run | `openclaw gateway usage-cost --days 30 --agent <id> --json`, divided by runs | |
| Box cost per run | your monthly bill, divided by runs in the month | |
| **Margin per run, and the decision** | **keep / reprice / kill** | |

**Month:**

Decide after the first full billing period, not after one run. **Keep** if the margin is positive
and it runs without you. **Reprice** if it works and the margin is thin. You now have the two
numbers for that conversation, which is more than most people selling services ever have. **Kill**
if the margin is negative or it needs you every time: a successful outcome of this chapter, and it
cost one billing period instead of a year.

## Does the job qualify

**Can it finish end to end while you are asleep?** Not "can the agent help". The failure mode is a
job ninety percent automated and therefore zero percent unattended.

| | Yours |
|---|---|
| What arrives | |
| What leaves | |
| Decisions in between, and the rule for each | |

Any decision you cannot write as a rule fails the job today. It might pass next month once you have
written the rule down.

**Does somebody already pay for this outcome?** Already, not "would somebody pay". The first is an
observation, the second a hope. Work you already do by hand for an existing client is the best
start by a distance, and people skip it because it feels like cheating.

Pick the smallest thing that passes both. The point of the first job is proving the loop runs while
you sleep.

## Before you take money

| | Yours |
|---|---|
| Retry limit and spacing | _unlimited retries against a job that fails the same way every time is the unbounded-restart mistake_ |
| What the customer sees on a failure | _silence is the worst option and it is the default_ |
| Completion signal, and what watches for its absence | _the probe says the gateway is up. It does not say the job ran_ |
| How I deliver by hand tonight | |
| Bad-day access path, tested from a phone off my network | |

The fourth row is the one people never write down. The customer does not care that your gateway is
broken. The customer cares that they did not get the thing.

The last one matters because 2.0 regressed the chat-first operator workflow: work still arrives and
leaves on chat, but do not assume you can **administer** the box from there at an inconvenient
moment.

## What gets installed here

`openclaw skills verify <@owner/slug> --card --json` before you install, not after, then
`openclaw plugins install --pin` on everything. The risk that costs you money is availability: a
publisher ships a bad version at 2am, your gateway does not come up, and the first signal is a
customer noticing.

Install what the job needs and nothing else. Screening happens at install; loading happens every
time. So keep your skills in the chapter 7 repository and check the diff weekly, because the
background skill maintenance already has write access to that folder.

| Date | What changed in the skills folder | Did I change it | Action |
|---|---|---|---|
| | | | |
