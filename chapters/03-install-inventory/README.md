# Chapter 3: The install inventory

Almost every upgrade that costs somebody a day is decided by a fact that was already true before
the upgrade started. This is how you find those facts while they are still cheap.

## The file

`install-inventory.md`. Nine sections. Every later chapter reads from it, and
chapter 6 reads it under pressure.

## Filling it

From the repository root:

```bash
./collect-inventory.sh
```

```
wrote install-inventory.filled.md
sections 4, 7 and 8 are yours to fill. Then commit it somewhere private.
```

With no `openclaw` on your PATH it stops and says so in one sentence. It reads your install; it
doesn't simulate one.

Then the floor check, the one thing here that runs with no OpenClaw at all:

```bash
./node-floor.sh          # at the floor: 26.5.0
                         # or: below the floor: 24.15.9. The 24 line starts at 24.16.0.
```

Node first, then OpenClaw, and the reason is SQLite TEXT truncation: strings written to your
state database get cut short. Not a crash you notice. Silent damage to the thing holding your
sessions and your memory, found later when something reads back wrong.

## Done when

Close your terminal, then answer from the file alone: version, install directory,
Node version, automation count, and which pieces update on a channel of their own. If you have to
open a shell for any of the five, that row is missing.

## Keeping it

The filled file is private the moment it exists. Private repository, not a
gist, and not the machine you are about to upgrade.

This repo ships no `openclaw.json` at any path, for the same reason the chapter exists:
`OPENCLAW_CONFIG_PATH` exists, and a misdirected config file is exactly the "which file is the
gateway actually reading" failure.
