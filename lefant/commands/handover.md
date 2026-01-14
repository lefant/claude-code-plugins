# Handover Command

The purpose of the `/handover` command is to generate a concise prompt for resuming work in a new session. It ensures a WIP devlog exists and gathers all relevant context references so the next session can quickly orient and continue.

Extra user prompt: $ARGUMENTS

## Usage

```
/handover [next-session-focus]
```

## What it does

1. **Gather context**: Run `/recent_context_from_git` in subagent to find relevant docs
2. **Ensure work-in-progress devlog**: Check for `_progress.md` devlog, create with `/devlog --wip` if missing
3. **Identify next tasks**: From beads issues, plan file, or conversation
4. **Generate prompt**: Output a concise handover prompt (max 5 sentences + references)

## Process

### Step 1: Gather Recent Context

Spawn subagent with `/lefant:recent_context_from_git` to identify:
- Recent devlogs (especially `_progress.md` files)
- Active plans
- Related specs, ADRs, research

### Step 2: Ensure Work-in-Progress Devlog Exists

Check for a current `_progress.md` devlog in `thoughts/shared/devlog/`.

If missing or stale, create one:
```
/devlog --wip
```

The devlog must include metadata referencing all relevant artifacts:
- `related_spec`: spec from `docs/specs/`
- `related_adr`: decision from `docs/decisions/`
- `related_plan`: plan from `thoughts/shared/plans/`
- `related_research`: research from `thoughts/shared/research/`
- `related_issues`: GitHub issues `#123` or beads `BD-042`

### Step 3: Identify Next Tasks

Determine what to work on next from:
1. **Beads issues**: Check `.beads/` for in-progress items
2. **Plan file**: Find current phase/step in active plan
3. **User input**: `$ARGUMENTS` specifies focus

### Step 4: Generate Handover Prompt

Output a concise prompt block:

```
═══════════════════════════════════════════════════════════════
HANDOVER PROMPT - Copy and paste to resume
═══════════════════════════════════════════════════════════════

[Max 5 sentences describing what we're working on and where to pick up]

**Context**:
- Devlog: `thoughts/shared/devlog/YYYY-MM-DD_session_progress.md`
- Plan: `thoughts/shared/plans/YYYY-MM-DD_plan.md` (Phase N)
- Spec: `docs/specs/feature.md`
- Issues: BD-042, #123

**Next**: [Specific task or phase to start with]

═══════════════════════════════════════════════════════════════
```

## Example Output

```
═══════════════════════════════════════════════════════════════
HANDOVER PROMPT - Copy and paste to resume
═══════════════════════════════════════════════════════════════

Implementing OAuth token refresh for multi-provider support. Token encryption and Stack Auth integration complete. Provider adapters partially done—Google works, GitHub and Notion pending. Three tests failing in validation suite.

**Context**:
- Devlog: `thoughts/shared/devlog/2026-01-14_oauth-refresh_progress.md`
- Plan: `thoughts/shared/plans/2026-01-12_oauth-implementation.md` (Phase 3)
- Spec: `docs/specs/oauth-token-management.md`
- ADR: `docs/decisions/2026-01-10_use-aes-256-gcm-encryption.md`
- Issues: BD-042, #89

**Next**: Complete GitHub provider adapter, then fix failing validation tests.

═══════════════════════════════════════════════════════════════
```

## Best Practices

1. **Keep it short** - 5 sentences max for the description
2. **Reference everything** - specs, ADRs, plans, devlogs, issues
3. **Be specific about next task** - exact phase, file, or issue to start with
4. **Ensure devlog exists** - never handover without persisting context
5. **Use beads/plan for tasks** - don't invent tasks, reference tracked work
