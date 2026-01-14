# Atomically Land (the plane) Command

Update plan tasks, issues and make sure everything is committed in git.

Extra user prompt: $ARGUMENTS

## Usage
```
/atomically_land [implementation-description]
```

## Steps

### 1. Commit implementation
- Make sure all implementation and test code is committed in git

### 2. Update tracking
- If there is a plan, make sure all tasks are up to date
- If there are related beads issues, make sure they are up to date

### 3. Review specs (optional)
- Check if specs were referenced in plans or discussed in the session
- If a spec exists in `docs/specs/`, verify implementation aligns with requirements
- If implementation diverged from spec, update the spec (living document)
- See: `/skill feature-specs`

### 4. Capture architectural decisions (optional)
- Review session for architectural decisions that emerged during implementation
- Technology choices, significant tradeoffs, or design patterns worth documenting
- If decision is significant, create ADR: `/adr_create [title]`
- See: `/skill architecture-decision-records`

### 5. Create devlog
- Run `/lefant:devlog` to document implementation outcome

### 6. Create changelog (optional, for major work)
- If completing significant feature, fix, or refactor, create changelog fragment
- Run `/changelog_create [description]`
- Reference related docs in frontmatter:
  - `related_spec`: spec from `docs/specs/`
  - `related_adr`: decision from `docs/decisions/`
  - `related_plan`: plan from `thoughts/shared/plans/`
  - `related_devlog`: devlog just created
  - `related_research`: research from `thoughts/shared/research/`
  - `related_issues`: GitHub issues or beads
- See: `/skill changelog-fragments`

### 7. Commit documentation
- Commit the updated plan, .beads, devlog, and any new specs/ADRs/changelog files to git

### 8. Handover
- Check if there is work in progress or what could be good next tasks
- Generate a `/handover` prompt
