#!/bin/sh
# rehearsal-round-trip.sh — Chapter 4. create -> list -> verify -> restore -> preflight.
# The restore is the step people skip, and skipping it is how you find out on the worst day that
# your backups were never restorable. A snapshot you have not restored from is a hope.
#
# usage: ./rehearsal-round-trip.sh <backup-repo-dir> <restore-target> [target-openclaw-binary]
#
# writes: a snapshot into <backup-repo-dir>, and a restored database at <restore-target>.
# touches your install: no. Your gateway stays up and serving for every step of this.
#
# the third argument is the target release's binary from your throwaway prefix. Without it the
# last step asks your CURRENT release what it thinks of your data, which is always "exact".

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "usage: rehearsal-round-trip.sh <backup-repo-dir> <restore-target> [target-openclaw-binary]" >&2
  exit 2
fi
REPO="$1"
TARGET="$2"

echo "== 1. snapshot"
CREATED=$(openclaw backup sqlite create --global --repository "$REPO" --json)
echo "$CREATED"
echo "   keep userVersion and sha256 out of that manifest. They go in your inventory."

# the book calls the snapshot path $SNAP and never assigns it. This is where it comes from:
# the create command's own manifest, read the same way the preflight gate reads .status.
SNAP=$(echo "$CREATED" | jq -r .snapshotPath)
if [ -z "$SNAP" ] || [ "$SNAP" = null ]; then
  echo "no snapshot path in that manifest. Stopping."
  exit 1
fi

echo "== 2. list"
openclaw backup sqlite list --repository "$REPO"

echo "== 3. verify: $SNAP"
# positional path. verify and restore reject --repository, unlike create and list.
openclaw backup sqlite verify "$SNAP" --json

echo "== 4. restore to $TARGET"
openclaw backup sqlite restore "$SNAP" --target "$TARGET" --json

echo "== 5. ask the target release what it thinks of the restored data"
"$(dirname "$0")/preflight-gate.sh" "$TARGET" "$3"
