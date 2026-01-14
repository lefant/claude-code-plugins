# Devlog Command

The purpose of the `/devlog` command is to persist the progress and/or learnings of the ongoing session as *intentional compaction* to prepare for starting a new session with a prompt like generated from the `/lefant:handover` command.

Extra user prompt: $ARGUMENTS

## Usage

```
/devlog [implementation-description] [--wip]
```

## Flags

- **--wip**: Work in progress. Adds `_progress.md` suffix and sets status to 🔄 PARTIAL

## What it does

1. **Generate filename**: `YYYY-MM-DD_session-slug.md` (or `_progress.md` with --wip)
2. **Create directory**: Create `thoughts/shared/devlog/` if it doesn't exist
3. **Draft entry**: Implementation outcome summary with metadata and learnings
4. **Write file**: Save to `thoughts/shared/devlog/`

## Filename Convention

`YYYY-MM-DD_session-slug.md` or `YYYY-MM-DD_session-slug_progress.md`

- **YYYY-MM-DD**: Today's date (Europe/Stockholm timezone)
- **session-slug**: 3-5 lowercase-kebab words describing session focus
- **Multiple sessions same day**: append `_2`, `_3`, etc.
- **--wip flag**: Adds `_progress.md` suffix

Examples:
- `2025-01-15_initial-project-setup.md` (completed)
- `2025-01-16_oauth-token-refresh_progress.md` (work in progress)
- `2025-01-16_database-integration_2.md` (second session, completed)

## Entry Template

```markdown
---
date: YYYY-MM-DD
status: ✅ COMPLETED | 🔄 PARTIAL | ❌ BLOCKED
related_spec: docs/specs/feature.md (optional)
related_adr: docs/decisions/YYYY-MM-DD_decision.md (optional)
related_plan: thoughts/shared/plans/YYYY-MM-DD_plan.md (optional)
related_research: thoughts/shared/research/YYYY-MM-DD_research.md (optional)
related_issues: [] (GitHub #123 or beads BD-042)
---

# Implementation Log – YYYY-MM-DD

**Implementation**: [what was implemented]

## Summary

One-paragraph synopsis of what was implemented, how it compared to the plan, and key outcomes achieved.

## Plan vs Reality

**What was planned:**
- [ ] Planned feature/component A
- [ ] Planned feature/component B

**What was actually implemented:**
- [x] Actual implementation A (matched plan)
- [x] Actual implementation B (deviated from plan - explain why)

## Challenges & Solutions

**Challenges encountered:**
- Problem not anticipated in plan

**Solutions found:**
- How challenges were resolved

## Learnings

- Technical insights discovered while building
- Architecture decisions that worked well/poorly

## Next Steps

- [ ] Follow-up implementations needed
- [ ] Open questions to resolve
```

## WIP Entries

When using `--wip`:
- Filename ends with `_progress.md`
- Status is `🔄 PARTIAL`
- Clearly state what is NOT done yet in Summary
- Next Steps should list remaining work

Example WIP summary:
```markdown
## Summary

Implemented token encryption and Stack Auth integration. **NOT YET DONE**: Provider adapters, compression layer, end-to-end testing.
```

## Best Practices

1. **Document while context is fresh** - don't wait until end of day
2. **Reference related artifacts** - link specs, ADRs, plans, research, issues
3. **Be honest about plan vs reality** - deviations are learnings
4. **Use --wip liberally** - partial progress is still valuable context
5. **Focus on learnings** - what would you tell yourself starting fresh?
