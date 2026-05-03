#!/bin/bash
set -euo pipefail

# --- Guard & Input ---
[ "${_POLISH_GUARD:-}" = 1 ] && exit 0
INPUT=$(cat)
PROMPT=$(echo "$INPUT" | jq -r '.prompt // empty')

# --- Skip conditions ---
[ ${#PROMPT} -lt 30 ] && exit 0
[[ "$PROMPT" == /* ]] && exit 0
command -v claude &>/dev/null || exit 0

code_chars=$(echo "$PROMPT" | tr -cd '{}()[];=<>|&$' | wc -c | tr -d ' ')
[ "$code_chars" -gt $(( ${#PROMPT} / 4 )) ] && exit 0

# --- Polish ---
POLISHED=$(
  export _POLISH_GUARD=1
  claude -p --model haiku 2>/dev/null <<PROMPT
Polish the following text. Fix grammar, spelling, punctuation, and naturalness.
Keep the original meaning, tone, and intent. Preserve technical terms, code refs, and paths.
If already clear, return unchanged. Return ONLY the polished text.

$PROMPT
PROMPT
) || exit 0

[ -z "$POLISHED" ] && exit 0
[ "$POLISHED" = "$PROMPT" ] && exit 0

# --- Output ---
jq -n --arg p "$POLISHED" '{
  "additionalContext": "[English Polish Hook]\nPolished:\n\n\($p)\n\nShow polished version if it meaningfully differs. Process the ORIGINAL message as the request."
}'
