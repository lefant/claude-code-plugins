# Changelog Create Command

Create a CHANGELOG fragment to document a completed change.

Extra user prompt: $ARGUMENTS

## Usage

```
/changelog_create [description]
```

## What it does

1. **Reference skill**: Load the `changelog-fragments` skill for conventions
2. **Determine description**: Use provided description or ask what changed
3. **Generate filename**: `YYYY-MM-DD_slugified-description.md` (today's date, Europe/Stockholm timezone)
4. **Create directory**: Create `./docs/changelog/` if it doesn't exist
5. **Gather references**: Ask about related ADRs, specs, devlogs, issues
6. **Draft fragment**: Fill in template based on conversation context
7. **Write file**: Save fragment to `./docs/changelog/`

## Filename Convention

`YYYY-MM-DD_brief-description.md`

- **YYYY-MM-DD**: Today's date (Europe/Stockholm timezone)
- **brief-description**: 3-5 lowercase words, dash-separated
- **Examples**:
  - `/changelog_create "OAuth token refresh"` → `2026-01-14_oauth-token-refresh.md`
  - `/changelog_create "Fix hydration error"` → `2026-01-14_fix-hydration-error.md`

## Template

Use the template from the `changelog-fragments` skill:
`lefant/skills/changelog-fragments/template.md`

## Process

1. **If description provided**: Use it directly
2. **If no description**: Ask what changed
3. **Determine type**: feature, fix, chore, docs, refactor, test, perf
4. **Gather references**: Prompt for related docs:
   - "Is there a related ADR in `docs/decisions/`?"
   - "Does this implement a spec from `docs/specs/`?"
   - "Is there a devlog entry for this work?"
   - "Any related GitHub issues or beads?"
5. **Write summary**: 1-3 sentences about what changed
6. **Add details**: Optional bullet points for complex changes
7. **Save file**: Write to `./docs/changelog/`

## Related Skill

For full conventions and guidelines, see:
```
/skill changelog-fragments
```
