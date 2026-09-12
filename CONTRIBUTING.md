# Contributing

## Welcome

**A gate that takes the wrong branch.** The important one. Every script here exists to fire at the
right moment, and a gate that cannot fire is worse than no gate because you still trust it. If you
can make one pass something it should have caught, open an issue with the output.

**A command that has changed.** OpenClaw ships fast: a flag that moved, a message whose wording
changed, a subcommand that went away. The recorded strings in `tests/fake-openclaw/` need to move
with it.

**A `GOTCHAS.md` entry that bit you**, with the command output or failing test that proves it.

Broken links, typos, shell portability problems.

## Out of scope

**New artifacts**, and **new rows or checks inside a gate.** This repo mirrors the book's fourteen,
in the book's names and order, so a reader who followed along recognises it. A fifteenth would
leave people hunting for a chapter that doesn't exist.

**Filled-in templates.** Yours hold your paths, your channels and your spend, and they belong in
the private repository the book has you build.

**A programming language.** No Python, Node, Go, package manifest or build system, matching the
book: every artifact is a runbook, a configuration you authored, a table you scored, or a gate of
fewer than ten lines.

## Before you open a pull request

```bash
shellcheck collect-inventory.sh chapters/*/*.sh tests/run-tests.sh tests/fake-openclaw/*/openclaw
./tests/run-tests.sh
```

Both run with no network, no key and no OpenClaw installed.

If you add or change a gate, add the assertion that proves its branch. A new state goes in
`tests/fake-openclaw/<state>/openclaw` as a tiny script printing exactly what the product emits:
exact string, exact stream, exact exit code, because two of the three traps in this book are about
the stream and the exit code rather than the text.
