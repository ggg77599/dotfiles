#!/usr/bin/env bash
# setup_session.sh - Initialize a code review session directory
# Outputs key=value pairs for Claude to consume:
#   COMMIT_HASH=<short hash>
#   BRANCH_NAME=<branch>
#   SESSION_DIR=<new or existing path>
#   EXISTING_SESSION=<path>  (only if an existing session was found)

set -e

DATETIME=$(date +"%Y-%m-%d-%H-%M")
COMMIT_HASH=$(git rev-parse --short HEAD)
BRANCH_NAME=$(git branch --show-current)
SESSION_DIR="./sessions/${DATETIME}_${COMMIT_HASH}_${BRANCH_NAME}"

echo "COMMIT_HASH=$COMMIT_HASH"
echo "BRANCH_NAME=$BRANCH_NAME"
echo "PROPOSED_SESSION_DIR=$SESSION_DIR"

# Check for existing session with same commit hash and branch
EXISTING=$(ls -d sessions/*_${COMMIT_HASH}_${BRANCH_NAME} 2>/dev/null | head -1 || true)

if [ -n "$EXISTING" ]; then
    echo "EXISTING_SESSION=$EXISTING"
else
    mkdir -p "$SESSION_DIR"
    echo "SESSION_DIR=$SESSION_DIR"
fi
