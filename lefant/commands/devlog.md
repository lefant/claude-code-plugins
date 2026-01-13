# Devlog Command

Document implementation outcomes after executing a plan, capturing what was built, learned, and discovered during the implementation process.

Extra user prompt: $ARGUMENTS

## Usage
```
/devlog [implementation-description] [--local] [--shared]
```

## What it does
1. **Determine target directory**: Use --local for personal implementations, --shared (default) for team implementations
2. **Generate entry**: Implementation outcome summary following template below
3. **Write to thoughts devlog**: `thoughts/shared/devlog/YYYY-MM-DD_implementation.md` or `thoughts/local/devlog/YYYY-MM-DD_implementation.md`
4. **Create CHANGELOG fragment**: Add fragment in `CHANGELOG/` directory with implementation summary
5. **Perform context compaction**: Reset conversation length

## Filename Convention

`<iso-date>_<session-slug>.md` or `<iso-date>_<session-slug>_progress.md`

- **iso-date**: `YYYY-MM-DD` (Europe/Stockholm timezone)
- **session-slug**: 3-5 lowercase-kebab words describing session focus
- **Multiple sessions same day**: append `_2`, `_3`, etc.
- **Use `_progress.md` suffix**: When plan is not yet complete (status: 🔄 PARTIAL)

Examples:
- `2025-01-15_initial-project-setup.md` (completed)
- `2025-01-16_extract-step-testing_progress.md` (work in progress)
- `2025-01-16_database-integration_2.md` (second session, completed)

## Entry Template

```markdown
# Implementation Log – {{YYYY-MM-DD}}

**Implementation**: {{what-was-implemented}}
**Original Research**: `thoughts/shared/research/{{research-doc}}.md`
**Plan Document**: `thoughts/shared/plans/{{plan-doc}}.md`
**Status**: {{✅ COMPLETED | 🔄 PARTIAL | ❌ BLOCKED}}

## Summary
One-paragraph synopsis of what was implemented, how it compared to the plan, and key outcomes achieved.

## Plan vs Reality
**What was planned:**
- [ ] Planned feature/component A
- [ ] Planned feature/component B

**What was actually implemented:**
- [x] Actual implementation A (matched plan)
- [x] Actual implementation B (deviated from plan - explain why)
- [x] Unexpected implementation C (discovered during implementation)

## Implementation Process
- [x] Setup and scaffolding steps
- [x] Core implementation phases
- [x] Integration and testing
- [x] Debugging and refinement

## Challenges & Solutions
**Challenges encountered:**
- Problem not anticipated in plan
- Technical difficulty discovered during implementation

**Solutions found:**
- How challenges were resolved
- What worked better than planned

## Implementation Learnings
- Technical insights discovered while building
- Architecture decisions that worked well/poorly
- Performance characteristics observed
- Developer experience insights

## Plan Validation
- **What the research got right**: Aspects where initial research was accurate
- **What the plan got right**: Planning decisions that proved correct
- **What we'd change**: Adjustments to research/planning approach for next time

## Next Steps
- [ ] Follow-up implementations needed
- [ ] Plan refinements for similar work
- [ ] Additional research areas identified

**Environment**: {{tech-stack-versions}}
**Duration**: {{implementation-timeframe}}
```

## Example Entry

```markdown
# Implementation Log – 2025-09-26

**Implementation**: Multi-provider OAuth token storage system with encryption
**Original Research**: `thoughts/shared/research/2025-09-20-oauth-patterns.md`
**Plan Document**: `thoughts/shared/plans/2025-09-24-oauth-storage-implementation.md`
**Status**: ✅ COMPLETED

## Summary
Successfully implemented the OAuth token storage system with compression and encryption as planned. The system handles multiple providers (Google, GitHub, Notion) and stores encrypted tokens in Stack Auth metadata. Implementation was 90% aligned with the plan, with some improvements discovered during development.

## Plan vs Reality
**What was planned:**
- [x] Token encryption/decryption utilities
- [x] Stack Auth metadata integration
- [x] Multi-provider token handling
- [ ] Simple base64 encoding (changed approach)

**What was actually implemented:**
- [x] Token encryption with AES-256-GCM (stronger than planned)
- [x] Compression before encryption (not in original plan)
- [x] Stack Auth metadata with 32KB validation
- [x] Provider-specific token adapters
- [x] Automatic token refresh detection

## Implementation Process
- [x] Created core encryption utilities (2 hours)
- [x] Integrated Stack Auth metadata API (1 hour)
- [x] Built provider adapters for Google, GitHub, Notion (3 hours)
- [x] Added compression layer after discovering token size issues (1 hour)
- [x] End-to-end testing with all providers (2 hours)

## Challenges & Solutions
**Challenges encountered:**
- Notion tokens were larger than expected (caused metadata overflow)
- Token refresh detection was more complex than anticipated

**Solutions found:**
- Added compression before encryption (reduced tokens by 60%)
- Implemented token hash comparison for refresh detection
- Used provider-specific adapters for different token structures

## Implementation Learnings
- Compression before encryption is crucial for large OAuth tokens
- Stack Auth metadata limits require careful size management
- Provider token structures vary significantly (JWT vs opaque tokens)
- Token refresh detection needs provider-specific logic
- End-to-end testing revealed callback URL sensitivity

## Plan Validation
- **What the research got right**: Stack Auth metadata approach, encryption needs, multi-provider complexity
- **What the plan got right**: Overall architecture, provider adapter pattern, security approach
- **What we'd change**: Should have researched token sizes earlier, plan should include compression from start

## Next Steps
- [ ] Add token expiration monitoring
- [ ] Implement automatic token refresh workflows
- [ ] Document compression ratios for different providers

**Environment**: Next.js 15.5, Stack Auth 1.2, Node.js crypto, TypeScript
**Duration**: 9 hours over 2 days
```

## Entry Focus
- **Implementation outcomes**: What was actually built vs what was planned
- **Plan execution**: How the implementation followed or deviated from the plan
- **Implementation learnings**: Technical discoveries and challenges during building
- **Plan validation**: Whether the original research and planning held up during implementation

## Directory Selection
- **Default (--shared)**: `thoughts/shared/devlog/` - for team implementations and shared learnings
- **--local**: `thoughts/local/devlog/` - for personal implementation experiments
- **Auto-create**: Creates directory structure if it doesn't exist

## CHANGELOG Fragment

After creating a devlog entry, create a CHANGELOG fragment in the `CHANGELOG/` directory.

**Use the changelog-fragments skill for complete guidance:**
```
/skill changelog-fragments
```

The skill provides:
- Fragment template and format
- Naming conventions
- When to create fragments
- Example fragments

**Quick reference:**

1. **Filename**: Use devlog date and slug (e.g., `2025-09-26_oauth-storage-implementation.md`)
2. **Format**: See skill for complete template
3. **Content**: Brief summary with link to detailed devlog entry
4. **Type**: Choose appropriate type (feature/fix/chore/docs/refactor/test/perf)

**Example CHANGELOG fragment:**
```markdown
---
date: 2025-09-26
type: feature
related_devlog: thoughts/shared/devlog/2025-09-26_oauth-storage-implementation.md
---

Implemented OAuth token storage with encryption and compression for multiple providers (Google, GitHub, Notion). Tokens are stored in Stack Auth metadata with AES-256-GCM encryption and compression for size optimization.
```

**Note**: Only create CHANGELOG fragments for --shared devlogs (team implementations). Skip for --local personal experiments.

## Workflow Context
This is the **fourth step** in the development workflow:
1. **Research** (`/research_codebase`) → documents current state and patterns
2. **Plan** (`/create_plan`) → creates implementation strategy
3. **Implement** (`/implement_plan`) → builds the solution
4. **Devlog** (`/devlog`) → captures implementation outcomes and learnings

## Best Practices

1. **Document immediately after implementation** - capture details while context is fresh
2. **Always reference source documents** - link to original research and plan documents
3. **Compare plan vs reality** - be honest about what worked and what didn't
4. **Focus on implementation learnings** - emphasize discoveries made during building
5. **Validate the process** - assess how well research and planning worked
6. **Use appropriate directory** - shared/ for team implementations, local/ for personal experiments
7. **Track implementation time** - helps improve future planning accuracy
8. **Use _progress.md suffix** - when plan is not yet complete (🔄 PARTIAL status)
