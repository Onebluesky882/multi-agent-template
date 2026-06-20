#!/usr/bin/env bash
# PreToolUse hook — runs pnpm type-check before any gate-out write is allowed
# Triggered by: Write (path-matched to gate-out/)
# Receives JSON on stdin: { "tool_name": "Write", "tool_input": { "file_path": "...", "content": "..." } }
#
# Skips silently when:
#   - file is NOT under gate-out/
#   - no package.json found at repo root (template project with no TS yet)
#   - pnpm not installed
# Blocks when:
#   - file IS under gate-out/ AND package.json exists AND type-check fails

set -euo pipefail

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | python3 -c \
  "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path',''))" \
  2>/dev/null || echo "")

# Only act on gate-out writes
case "$FILE_PATH" in
  */gate-out/*)
    ;;
  *)
    exit 0
    ;;
esac

REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || exit 0

# Skip if no TypeScript project exists
if [ ! -f "$REPO_ROOT/package.json" ]; then
  exit 0
fi

# Skip if pnpm is not available
if ! command -v pnpm &>/dev/null; then
  echo "WARNING [gate-out-typecheck]: pnpm not found — type-check skipped. Install pnpm to enforce this gate." >&2
  exit 0
fi

echo "[gate-out-typecheck] Running pnpm type-check before accepting gate-out..." >&2

cd "$REPO_ROOT"

# Capture output; show it on failure
TYPECHECK_OUT=$(pnpm type-check 2>&1) && TYPECHECK_EXIT=0 || TYPECHECK_EXIT=$?

if [ "$TYPECHECK_EXIT" -ne 0 ]; then
  echo "" >&2
  echo "BLOCKED [gate-out-typecheck]: type-check FAILED — gate-out write rejected." >&2
  echo "Fix all type errors before submitting gate-out:" >&2
  echo "" >&2
  echo "$TYPECHECK_OUT" >&2
  echo "" >&2
  echo "Run: pnpm type-check" >&2
  exit 1
fi

echo "[gate-out-typecheck] type-check PASSED — gate-out write allowed." >&2
exit 0
