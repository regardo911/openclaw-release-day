#!/bin/sh
# collect-inventory.sh — Chapter 3. Runs chapter 3's own read-only commands against YOUR install
# and writes their output, verbatim, into the nine sections of install-inventory.md.
#
# usage: ./collect-inventory.sh [output-file]     default: install-inventory.filled.md
#
# reads. Never writes to ~/.openclaw, never stops the gateway, never runs an update.
# It parses nothing, scores nothing and judges nothing. It runs commands under headings and
# copies what they said. Sections 4, 7 and 8 have no single command, so they stay blank for you.
#
# the result is private. It names your paths and your install. Put it in a private repository.

OUT="${1:-install-inventory.filled.md}"

command -v openclaw >/dev/null 2>&1 || {
  echo "openclaw is not on your PATH, so there is nothing here to read." >&2
  echo "This reads your own install; it does not simulate one." >&2
  exit 1
}

run() { printf '\n```\n$ %s\n' "$*"; "$@" 2>&1; printf '```\n'; }

{
  echo "# install-inventory.md"
  echo
  echo "Every row below was pasted from a command's output. Nothing is typed from memory."
  echo "A row you remembered is a row chapter 5 will check against and fail."
  echo
  echo "## 1. Identity"
  run openclaw --version
  run openclaw update status --json
  echo
  echo "Read the install root off that JSON. If the package manager says \`unknown\`, write"
  echo "\`unknown\` down. That is a useful row, and it changes your upgrade path in chapter 5."
  echo
  echo "## 2. Runtime"
  run node -v
  echo
  echo "Write next to it whether that is at or above the floor for your target release."
  echo "\`chapters/03-install-inventory/node-floor.sh\` answers it."
  echo
  echo "## 3. Paths"
  run openclaw config file
  echo
  echo "State database: under the state directory, named \`openclaw.sqlite\`."
  echo "Add the size of the config file. Size is your chapter 2 config-surface row."
  echo
  echo "## 4. Authored settings"
  echo
  echo "_Open the config file from section 3 and list the top-level keys you have actually set._"
  echo "_Then look for \`plugins.entries.codex\`. 2026.9.4 removed 105 paths under it. If it is"
  echo "there, that is dead configuration sitting in your install with nothing telling you so._"
  echo
  echo "## 5. Agents and automations"
  run openclaw agents list
  run openclaw cron list
  echo
  echo "## 6. Plugins and skills"
  run openclaw plugins list
  run openclaw skills check
  echo
  echo "Mark which plugins are pinned to an exact version and which will float to whatever"
  echo "ships next. Floating plugins are a variable in every upgrade you will ever run."
  echo
  echo "## 7. Channels"
  echo
  echo "_Which chat channels are wired up, which agent owns each one, and which one you would_"
  echo "_notice first if it went quiet. Channel bindings are among the most reliable things to_"
  echo "_break in an upgrade, and this is the section people rebuild from memory at the worst time._"
  echo
  echo "## 8. Separate update surfaces"
  echo
  echo "_The CLI is not the only thing that updates. The macOS app runs its own channel. On Linux_"
  echo "_the desktop app ships as a .deb or an AppImage, and those update differently again._"
  echo "_Write down which of them exist on this machine and what version each reports._"
  echo
  echo "## 9. A healthy baseline"
  run openclaw gateway probe
  echo
  echo "That one is labelled **healthy**. You are writing this row for a version of yourself who"
  echo "is not having a good morning, and in chapter 6 you will compare against it rather than"
  echo "reading a number on its own."
} > "$OUT"

echo "wrote $OUT"
echo "sections 4, 7 and 8 are yours to fill. Then commit it somewhere private."
