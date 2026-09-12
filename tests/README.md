# tests

## What this proves

That every gate here takes the right branch. `fake-openclaw/` holds one tiny script per recorded
output state, each printing exactly what the product emits: the exact string, on the exact stream,
with the exact exit code. The runner puts one on `PATH` and asserts the gate does the right thing.

The assertion that earns the directory:

```
ok   preflight FAILS on migration-required even though the command exited 0
```

The fake exits 0 there because the real command does. A gate reading `$?` would green-light the
one-way door.

Two more in the same family. `prove-authored.sh` is checked against a message printed on **standard
error** with exit 1. That is the assertion that fails if anybody removes the `2>&1`. And `tripwire.sh` is
checked against an empty cost figure, which the six-line version in the book reads as zero and
calls a pass.

## What it is

Gate logic, checked against recorded strings. The fakes stand in for a command's **output** so a
branch can be proved without a product installed. They're not the product and they never report a
preflight result about anything real; the answer about your data comes from your own install.

## Running it

```bash
./tests/run-tests.sh
```

No network, no key, no account, no OpenClaw. It needs `sh` and `jq`. One line per assertion, then a
total, exiting non-zero if anything failed.

```
36 assertions, 0 failed
```
