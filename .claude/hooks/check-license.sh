#!/usr/bin/env bash
# PreToolUse hook — blocks any file write when license_status != ACTIVE
# Triggered by: Edit, Write, NotebookEdit
# Receives JSON on stdin: { "tool_name": "...", "tool_input": { "file_path": "..." } }

set -euo pipefail

INPUT=$(cat)

# Resolve repo root so this works from any worktree
REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null) || {
  echo "ERROR [check-license]: cannot resolve repo root — write blocked" >&2
  exit 1
}

LICENSE_FILE="$REPO_ROOT/.claude/license_status"

if [ ! -f "$LICENSE_FILE" ]; then
  echo "ERROR [check-license]: $LICENSE_FILE not found — all file writes are blocked." >&2
  echo "Create the file with content: ACTIVE" >&2
  exit 1
fi

STATUS=$(tr -d '[:space:]' < "$LICENSE_FILE")

if [ "$STATUS" != "ACTIVE" ]; then
  FILE_PATH=$(echo "$INPUT" | python3 -c \
    "import sys,json; d=json.load(sys.stdin); print(d.get('tool_input',{}).get('file_path','<unknown>'))" \
    2>/dev/null || echo "<unknown>")
  echo "ERROR [check-license]: license_status=$STATUS — write to '$FILE_PATH' is blocked." >&2
  echo "To unblock: set $LICENSE_FILE to ACTIVE" >&2
  exit 1
fi

exit 0
