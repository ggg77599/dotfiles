# Code Review Checklist

Detailed reference for each review layer. Load as needed during analysis.

## Commit Messages

- Descriptive: clear what the commit does (not "fix bug", "update code")
- Atomic: one logical change per commit
- Ticket reference: includes ID if project requires it (e.g., V1E-1234, #123)
- Message matches actual code changes
- Red flags: "fix", "update", "changes", "wip", commits mixing unrelated changes

## Five-Layer Analysis

### Layer 1: Data Structures

"Bad programmers worry about the code. Good programmers worry about data structures."

- What is the core data? How are they related?
- Where does data flow? Who owns it? Who modifies it?
- Is there unnecessary data copying or conversion?
- Are intermediate wrapper types adding zero value?

### Layer 2: Special Cases

"Good code has no special cases"

- Find all if/else branches
- Which are real business logic? Which are patches for bad design?
- Can redesigning data structures eliminate these branches?
- Refactoring potential score (1-10)

### Layer 3: Complexity

"If you need more than 3 levels of indentation, you're screwed anyway."

- What is the essence of this feature? (One sentence)
- Deepest indentation level across changed files
- Longest function (lines)
- Can complexity be halved? Then halved again?

### Layer 4: Destructiveness

"Never break userspace" — backward compatibility is iron law

- List all existing functionality that might be affected
- Which dependencies will be broken?
- Is the change backward compatible?
- Impact scope assessment

### Layer 5: Practicality

"Theory loses. Every single time."

- Does this problem really exist in production?
- How many users encounter this?
- Does solution complexity match problem severity?
- Is this over-engineered?

## Performance

**Database:**
- Queries only fetch necessary fields — no `SELECT *`
- Queries use primary keys/indexes where possible
- No N+1 query problems
- Multi-table operations use transactions

**Code efficiency:**
- No unnecessary data copying or conversion
- No inefficient loops or algorithms
- Caching strategy reviewed if applicable

## Consistency

- Related APIs use the same logic patterns
- Common operations use shared functions or DB queries
- Similar endpoints have similar structure and error handling

## Function Design

- Names accurately reflect purpose
- Single Responsibility Principle — each function does one thing
- Meaningful naming for variables and functions

## Code Smells

- **God Object/Class**: single class with hundreds of lines, multiple responsibilities
- **Long Parameter List**: >3-4 params (consider parameter object)
- **Feature Envy**: method uses more features from another class than its own
- **Primitive Obsession**: primitives instead of small objects
- **Duplicated Code**: same/similar blocks in multiple places
- **Magic Numbers/Strings**: hardcoded values without named constants
- **Shotgun Surgery**: single change requires modifications across many classes
- **Data Clumps**: same group of variables appearing together repeatedly

## Resource Management & Concurrency

**Resource leaks:**
- File handles: properly closed (defer/finally/using)?
- DB connections: returned to pool or closed?
- HTTP connections: properly closed after use?
- Memory: large buffers that grow unbounded?
- Cleanup in error paths?

```bash
# Scan for opens without closes
grep -E "(Open|Connect|Acquire|New.*Connection)" changed_files
```

**Concurrency:**
- Race conditions: shared state accessed without synchronization?
- Deadlocks: multiple locks acquired in different orders?
- Thread safety: shared resources protected?
- Resource contention across goroutines/threads?

## Coding Standards

Read in order: `docs/guides/coding-practices.md` → `CONTRIBUTING.md` → `docs/CODING_STANDARDS.md` → `.github/CONTRIBUTING.md` → language/framework best practices

**Checklist:**
- Architecture: layered, responsibility separation, dependency direction
- Naming conventions: files, folders, packages, API paths
- Type safety: avoid `any`/unsafe casts, type guards where needed
- Error handling: comprehensive strategy, errors include context, structured logging
- Security: input validation, SQL injection, XSS, CSRF, no hardcoded credentials
- Library upgrades: check interface changes, obsolete methods, breaking changes

## Dead Code

- Dead code that's no longer reachable
- Unused variables (created but never read)
- Unused imports/includes
- Unused function parameters

## Test Coverage

1. All changed code paths have test cases
2. Edge cases tested: boundary conditions, error cases, null/empty inputs
3. Happy path AND unhappy path covered
4. Ask user to run unit tests for changed code and share results

## Log Messages

**Good:**
```go
log.Info("Processing request", "userID", userID, "requestID", reqID)
```

**Bad:**
```go
log.Error("error occurred")              // no context
log.Info("Processing user " + userID)   // string concat
log.Debug("Password: " + password)      // sensitive data
```

Always log with contextual variables. Never log sensitive data.

## Comments

- Comments explain "why", not "what" (code shows what)
- Comments are up-to-date with actual behavior
- No commented-out code (git remembers)
- No comments that duplicate what code clearly does
- TODO/FIXME/HACK must have ticket references and owner

```bash
# Check for TODO/FIXME/HACK in new code
git diff $(git merge-base origin/HEAD @) | grep -E "^\+.*\b(TODO|FIXME|HACK)\b"
```

## SOPS Encrypted Files

If SOPS-encrypted files are modified:
- Ask user to provide STS token for decryption
- Verify actual values being changed, not just the encrypted diff
