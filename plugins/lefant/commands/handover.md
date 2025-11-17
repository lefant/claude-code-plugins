---
description: Document progress and generate handover prompt for next session
---

# Handover Command

Document current implementation progress and generate a copy-paste handover prompt to resume work in the next session.

Extra user prompt: $ARGUMENTS

## Usage
```
/handover [top-priority-instructions]
```

Arguments should specify the top priority for the next session (e.g., "make sure test coverage is good and all tests are passing").

## What it does
1. **Reflect task status in plan**: Update checkmarks in the current plan file to reflect actual progress
2. **Record progress devlog**: Create a `_progress.md` devlog with what has been accomplished in `thoughts/shared/devlog/`
3. **Document test status**: Detail working and failing tests
4. **Generate handover prompt**: Output a copy-paste ready prompt to resume work after /clear, including the top priority from arguments

## Handover Prompt Format

The command generates a prompt ready for copy-paste that includes:
- `/implement_plan` command at the TOP (triggers slash command when pasted)
- Current plan reference
- Test status summary
- Top priority items

**Key requirement**: The `/implement_plan` command MUST be at the top of the output so when the entire block is pasted into a new session, the slash command triggers immediately.

## Process

### Step 0: Identify Current Plan
If no plan is explicitly referenced in the conversation:
- Check for the most recently modified file in `thoughts/shared/plans/`
- Use `ls -lt thoughts/shared/plans/` to see files sorted by modification time (newest first)
- Alternatively, check git history: `git log --oneline --all -- thoughts/shared/plans/ | head -5`
- The current plan is typically the most recently updated `.md` file in that directory

### Step 1: Update Plan File
- Read the current plan from `thoughts/shared/plans/`
- Reflect actual task completion status using checkmarks [x]
- Mark in-progress items clearly
- Note any blockers or deviations

### Step 2: Record Progress Devlog
Create progress devlog in `thoughts/shared/devlog/` with **_progress.md suffix** to indicate work in progress:
- Filename: `thoughts/shared/devlog/YYYY-MM-DD_<session-slug>_progress.md`
- Status: 🔄 PARTIAL
- Auto-create directory if it doesn't exist
- Document sections:
  - **What has been accomplished**: Completed implementations
  - **Working tests**: Tests that are passing ✅
  - **Failing tests**: Tests that are failing ❌ (with error details)
  - **Next steps**: What needs to be done next

### Step 3: Test Status Documentation
Capture detailed test information:
```markdown
## Test Status

### Working Tests ✅
- `test/feature/test-name.test.ts`: Description of what this validates
- `test/integration/another.test.ts`: What this covers

### Failing Tests ❌
- `test/feature/broken.test.ts`:
  - Error: [error message]
  - Root cause: [brief analysis]
  - Fix needed: [what needs to be done]

### Test Coverage
- Current coverage: [percentage if available]
- Critical gaps: [areas needing tests]
```

### Step 4: Generate Handover Prompt
Output a formatted prompt block ready for copy-paste.

**IMPORTANT**: Place `/implement_plan` command at the TOP so it triggers when pasted.

```
═══════════════════════════════════════════════════════════════
HANDOVER PROMPT - Copy and paste this entire block
═══════════════════════════════════════════════════════════════

/implement_plan thoughts/shared/plans/YYYY-MM-DD_plan-name.md

Continue implementation of [FEATURE NAME]

**Plan**: `thoughts/shared/plans/YYYY-MM-DD_plan-name.md`
**Progress Log**: `thoughts/shared/devlog/YYYY-MM-DD_session_progress.md`

## Current Status
- ✅ Completed: [list completed phases/items]
- 🔄 In Progress: [current phase/item]
- ⏳ Remaining: [pending phases/items]

## Test Status
- ✅ Passing: [count] tests
- ❌ Failing: [count] tests (see progress log for details)
- 📊 Coverage: [percentage or "needs improvement"]

## Top Priority
{{$ARGUMENTS - the top priority instructions provided by the user}}

Focus areas:
1. [Specific failing test or missing coverage]
2. [Next implementation item]
3. [Any blockers to address]

═══════════════════════════════════════════════════════════════
```

## Progress Devlog Template

```markdown
# Implementation Progress Log – {{YYYY-MM-DD}}

**Implementation**: {{what-is-being-implemented}}
**Plan Document**: `thoughts/shared/plans/{{plan-doc}}.md`
**Status**: 🔄 PARTIAL

## Progress Summary
Brief overview of where we are in the implementation and what has been accomplished so far.

## Completed Work
- [x] Implemented feature/component A
- [x] Added tests for A
- [x] Integrated with system B

## Current Work
- [ ] Working on feature/component C
  - Completed: [specific parts done]
  - Remaining: [specific parts pending]

## Test Status

### Working Tests ✅
List all passing tests with brief description of what they validate:
- `path/to/test.test.ts`: Validates [functionality]
- `path/to/another.test.ts`: Ensures [behavior]

### Failing Tests ❌
For each failing test, document:
- **Test**: `path/to/test.test.ts::test name`
- **Error**: [error message or description]
- **Root Cause**: [why it's failing]
- **Fix Needed**: [what needs to be done]

### Test Coverage Gaps
Areas that need test coverage:
- [ ] Missing tests for [feature/component]
- [ ] Need integration tests for [workflow]
- [ ] Edge cases to cover: [scenarios]

## Implementation Details

### What Works
Components/features that are functioning correctly:
- Feature A with [specific capabilities]
- Integration between B and C
- [etc.]

### What's Incomplete
Components/features that are partially done:
- Feature D: [what's done] / [what's pending]
- Integration E: [status and blockers]

### Known Issues
- Issue 1: [description and impact]
- Issue 2: [description and impact]

## Blockers
- [ ] Blocker 1: [description and what's needed]
- [ ] Blocker 2: [description and what's needed]

## Next Steps
Ordered list of what needs to happen next:
1. [ ] Fix failing test in [location]
2. [ ] Complete implementation of [feature]
3. [ ] Add tests for [coverage gap]
4. [ ] Verify [integration/behavior]

## Notes for Next Session
Any important context or decisions to remember:
- Technical decision about [X] because [reason]
- Pattern to follow for [Y]
- Watch out for [Z] when implementing [W]

**Environment**: {{tech-stack-versions}}
**Session Duration**: {{implementation-timeframe}}
```

## Example Handover Prompt Output

```
═══════════════════════════════════════════════════════════════
HANDOVER PROMPT - Copy and paste this entire block
═══════════════════════════════════════════════════════════════

/implement_plan thoughts/shared/plans/2025-10-27_pdf-sync-implementation.md

Continue implementation of Notion Paper Sync PDF handling

**Plan**: `thoughts/shared/plans/2025-10-27_pdf-sync-implementation.md`
**Progress Log**: `thoughts/shared/devlog/2025-10-27_pdf-sync_progress.md`

## Current Status
- ✅ Completed: Phase 1 (PDF extraction), Phase 2 (Notion integration)
- 🔄 In Progress: Phase 3 (Error handling and validation)
- ⏳ Remaining: Phase 4 (E2E testing), Phase 5 (Documentation)

## Test Status
- ✅ Passing: 12 tests
- ❌ Failing: 3 tests (validation edge cases, see progress log)
- 📊 Coverage: 73% - needs improvement in error paths

## Top Priority
Make sure the test coverage is good and all tests are passing.

Focus areas:
1. Fix 3 failing validation tests in `test/pdf/validation.test.ts`
2. Add test coverage for error paths (target: 85%+)
3. Complete Phase 3 error handling implementation

═══════════════════════════════════════════════════════════════
```

## Best Practices

1. **Put `/implement_plan` at the TOP** - ensure slash command triggers when pasted
2. **Provide clear top priority** - specify what's most important for next session in arguments
3. **Update plan file first** - accurate task status is critical for handover
4. **Be specific about test failures** - include error messages and root cause analysis
5. **Make the handover prompt copy-paste ready** - format with clear boundaries
6. **Document context for next session** - capture decisions and important details
7. **Use _progress.md suffix** - signals work in progress (🔄 PARTIAL status)
8. **Be honest about status** - don't mark things complete that aren't

## Integration with Workflow

This command bridges implementation sessions:
1. **Research** (`/research_codebase_generic`) → documents patterns
2. **Plan** (`/create_plan_generic`) → creates strategy
3. **Implement** (`/implement_plan`) → builds solution
4. **Handover** (`/handover`) → documents progress and enables resumption
5. **Continue** → resume with `/implement_plan` from handover prompt
6. **Devlog** (`/devlog`) → final completion documentation (no _progress suffix)

## When to Use

Use `/handover` when:
- Taking a break during active implementation
- Need to clear context but plan to continue
- Want to document current status before /clear
- Switching between work sessions
- Implementation is partially complete

**Note**: Use `/devlog` (not `/handover`) when the implementation is fully complete.
