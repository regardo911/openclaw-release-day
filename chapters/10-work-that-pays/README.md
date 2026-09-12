# Chapter 10: Work that pays

You have a box that stays up, a config that doesn't drift and a recovery procedure. That is an
operations capability. This chapter sells the output of it.

## What you build

One live, priced, scheduled job on the chapter 9 box, and `margin-sheet.md` with your own numbers
in it.

## The one command

```bash
openclaw gateway usage-cost --days 30 --agent <agent-id> --json
```

One row of the eight comes from the product and this is it. Give the paid job its own agent and
cost attribution is a flag. Share an agent and it is an estimate, and an estimate is exactly what
lets a job quietly run at a loss.

Before any of that, run the job by hand twice and time it. Plenty of people discover at that step
that the job is not what they thought it was.

## What success looks like

The agent completed the job unattended, on a schedule, for a counterparty who paid, and you can
state revenue per run and cost per run from your own sheet without opening a terminal.

The word doing the work is **unattended**. If you watched it, run it again without watching.

## No worked example here, and why

There is no filled-in sheet in this directory because there is no honest one to give. Across
several hundred sources there was no OpenClaw operator publishing a job they run unattended for a
paying customer with revenue per run and cost per run both measured. People are certainly doing
versions of this. Nobody is writing down the numbers.

An invented figure would be the one thing in this repo you could not check. So the sheet ships
blank and the method ships filled in.

## On your install

There is no `skills/` directory here and no `SKILL.md` at any depth. A clone that dropped either
into a workspace your agent can reach would be handing it instructions you did not write.

Your own skills belong in the private repository from chapter 7, where a change becomes a diff you
can read. The weekly check is at the bottom of `margin-sheet.md`, and the reason it matters is
that screening happens at install while loading happens every time.
