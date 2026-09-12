#!/bin/sh
# audit-remediations.sh — Chapter 8. Every finding with the fix the tool itself prescribes.
# Take the remediation from your own release rather than from anybody's blog, including the book's.
# Educational material. Not security advice. See DISCLAIMER.md.
#
# usage: ./audit-remediations.sh            run it live against your install
#        ./audit-remediations.sh <file>     re-read a saved --json run
#
# save a run before you fix anything and another after, so the diff is the record of what you closed.
# FIX: null on the informational summary line is correct. That finding asks you to do nothing.

if [ -n "$1" ]; then
  cat "$1"
else
  openclaw security audit --json
fi | jq -r '.findings[] | "\(.severity) \(.checkId)\n  \(.detail)\n  FIX: \(.remediation)\n"'
