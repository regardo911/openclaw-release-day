<!-- install-inventory.md (Chapter 3). Know what you have before you change it. -->

# install-inventory.md

Every row pasted from a command's output. Nothing typed from memory: a row you remembered is a row
chapter 5 will check against and fail.

`../../collect-inventory.sh` fills 1, 2, 3, 5, 6 and 9 from your own install. The rest are yours.

Private once filled. It names your paths, your channels and your agents.

## 1. Identity

_`openclaw --version`, and the whole of `openclaw update status --json`. If the package manager
reads `unknown`, write `unknown`. That is a useful row and it changes your upgrade path._

## 2. Runtime

_`node -v`, and beside it whether that is at or above the floor for your target. `node-floor.sh`
answers it._

## 3. Paths

_`openclaw config file`, the state directory, and the size of the config file. Size is your
chapter 2 config-surface row._

## 4. Authored settings

_The top-level keys you have actually set. Then look for `plugins.entries.codex` in your own file:
2026.9.4 removed 128 paths and 105 of them were that block, so anything there is dead
configuration with nothing telling you so._

## 5. Agents and automations

_`openclaw agents list` and `openclaw cron list`, both pasted. The automation list is the one you
will be most grateful for, because it is the thing that goes missing quietly._

## 6. Plugins and skills

_`openclaw plugins list` and `openclaw skills check`. Mark which plugins are pinned to an exact
version and which will float to whatever ships next._

## 7. Channels

_Which channels are wired up, which agent owns each, and which one you would notice first if it
went quiet._

## 8. Separate update surfaces

_The CLI, the macOS app on its own channel, and on Linux a `.deb` or an AppImage that update
differently again. Which exist here, and what version each reports. Two OpenClaws on one box
disagreeing about one database is a schema argument between two programs that each think they are
correct._

## 9. A healthy baseline

_A clean `openclaw gateway probe`, labelled **healthy**. You are writing this row for a version of
yourself who is not having a good morning._

---

**Done when:** close your terminal, then answer from this file alone: what version am I on, which
directory is it installed in, which Node is under it, how many automations do I have, and which
pieces update on a channel of their own. If you have to open a shell for any of the five, that row
is missing.
