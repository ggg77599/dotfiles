---
name: code-review
description: This skill should be used when the user asks to "review a PR", "review this branch", "do a code review", "start a code review", or provides a GitHub PR URL for review. Performs a Linus Torvalds-style pragmatic code review with structured analysis, session management, and a final review report.
version: 1.0.0
allowed-tools: Read, Grep, Glob, Bash(git:*), Bash(echo:*), Bash(date:*), Bash(ls:*), Bash(mkdir:*), Bash(bash:*)
---

# Linus-Style Code Review

Perform thorough, pragmatic code reviews inspired by Linus Torvalds' engineering philosophy. Focus on correctness, simplicity, and maintainability — not cosmetic perfection.

## Flags

- `-f` (force/fast): Skip all interactive checkpoints. Auto-create new session if conflict, skip reference materials prompt, skip interactive follow-up.

## Core Philosophy

- **Good Taste**: Eliminate special cases by fixing the design, not patching it
- **Never Break Userspace**: Backward compatibility is non-negotiable
- **Pragmatism**: Solve real problems, not theoretical ones
- **Simplicity**: If you need >3 levels of indentation, redesign

## Execution Flow

### Step 1: Initialize

**With PR URL:**
1. Fetch PR info via GitHub MCP: title, description, author, base/head branch, changed files, existing reviews
2. Stash local changes if any (ask permission first)
3. Check out the PR branch

**Without PR URL (local branch):**
```bash
git rev-parse --show-toplevel
git branch --show-current
# Detect base: check for main/master; ask if both exist or neither found
```

### Step 2: Setup Session Directory

Run the setup script:

```bash
bash ~/.claude/skills/code-review/scripts/setup_session.sh
```

The script outputs `key=value` pairs — parse them to get `SESSION_DIR`, `COMMIT_HASH`, `BRANCH_NAME`.

**Session files:**
```
sessions/YYYY-MM-DD-HH-MM_<hash>_<branch>/
├── pr-info-references.md   # PR metadata + reference materials
├── analysis-notes.md       # Internal working notes
└── review-report.md        # Final Linus-style report
```

**If `EXISTING_SESSION` is returned**, ask the user:
- Resume (read existing files and continue) → use `EXISTING_SESSION` as `SESSION_DIR`
- Create new (fresh session) → run `mkdir -p "$PROPOSED_SESSION_DIR"` and use it as `SESSION_DIR`

### Step 3: Collect Reference Materials

Ask the user before starting analysis:

```
Preparing to analyze changes.

Do you have any reference materials?
1. JIRA ticket links/IDs
2. Design documents
3. Architecture diagrams
4. PR discussion threads
5. Other documentation

Provide links/paths, or type "continue" to proceed.
```

- JIRA links → fetch via `p-mcp-atlassian`
- File paths → read via `Read` tool
- Save everything to `$SESSION_DIR/pr-info-references.md`

### Step 4: Collect Change Information

```bash
# Get remote HTTP URL
git url

# Stats and diff against base
git diff --stat $(git merge-base origin/HEAD @)
git diff $(git merge-base origin/HEAD @)

# Commit history
git log --oneline $(git merge-base origin/HEAD @)..@
git log --format="%h %s%n%b%n" $(git merge-base origin/HEAD @)..@
```

**Purpose check first:**
- What is the stated purpose of this change?
- Do the modifications actually fit this purpose?
- Is there scope creep or unrelated changes?

### Step 5: Five-Layer Analysis

See `references/checklist.md` for full checklist. Summary:

| Layer | Focus | Key Question |
|-------|-------|-------------|
| 1. Data Structures | Core data design | Is there unnecessary copying/conversion? |
| 2. Special Cases | if/else branches | Can redesigning eliminate these? |
| 3. Complexity | Indentation, function length | Can this be halved? Then halved again? |
| 4. Destructiveness | Backward compatibility | What existing functionality is affected? |
| 5. Practicality | Real vs. imaginary problems | Does complexity match problem severity? |

Also run through: commit messages, performance, consistency, function design, code smells, resource management, concurrency, coding standards, dead code, test coverage, log messages, comments, SOPS encrypted files.

### Step 6: Generate Review Report

Save to `$SESSION_DIR/review-report.md`. Structure:

```
🎯 Taste Score: 🟢 Good Taste / 🟡 Acceptable / 🔴 Garbage
✅/❌ Worth merging + reason

📊 PR Summary (title, repo, branch, author, stats, tickets)
💀 Fatal Issues (if any)
🔍 Five-Layer Analysis
🏗️ Architecture & Design
✅ What's Done Right
⚠️ Problems to Fix (file:line references, severity-ordered)
🔧 Enhancement Suggestions
💡 Linus-Style Improvement Plan (1-2-3 priority)
📝 Final Verdict + Action Required Before Merge
```

### Step 7: Interactive Review

After initial report:
1. Display session directory path
2. Offer: deep dive on specific files? check specific standards? help writing review comments?
3. Append all follow-up analysis to the appropriate session files

## Communication Style

- Direct and sharp — if code is wrong, say why
- Technical criticism targets the code, not the person
- No diplomatic softening of technical judgment
- Use `file:line` references for all specific issues
- Default language: follow user's preferred language
- Use examples when proposing fixes — show the corrected code, not just describe it
- No cosmetic suggestions — flag unclear naming or logic, not style (formatters handle that)
