# ADR Create Command

Create an Architecture Decision Record to capture a significant architectural decision.

Extra user prompt: $ARGUMENTS

## Usage

```
/adr_create [title]
```

## What it does

1. **Reference skill**: Load the `architecture-decision-records` skill for conventions
2. **Determine title**: Use provided title or ask user to describe the decision
3. **Generate filename**: `YYYY-MM-DD_slugified-title.md` (today's date, Europe/Stockholm timezone)
4. **Create directory**: Create `./docs/decisions/` if it doesn't exist
5. **Draft ADR**: Fill in template sections based on conversation context
6. **Interactive refinement**: Review and refine Context, Decision, Consequences with user
7. **Write file**: Save ADR to `./docs/decisions/`

## Filename Convention

`YYYY-MM-DD_short-dash-description.md`

- **YYYY-MM-DD**: Today's date (Europe/Stockholm timezone)
- **short-dash-description**: 3-5 lowercase words from title, dash-separated
- **Examples**:
  - `/adr_create "Use PostgreSQL for persistence"` → `2026-01-14_use-postgresql-for-persistence.md`
  - `/adr_create "Adopt event sourcing"` → `2026-01-14_adopt-event-sourcing.md`

## Template

Use the template from the `architecture-decision-records` skill (installed from `lefant/agent-skills`).

## Process

1. **If title provided**: Use it directly
2. **If no title**: Ask user to describe the decision in one sentence
3. **Draft sections**:
   - Pull context from recent conversation if discussing the decision
   - Ask clarifying questions if context is unclear
4. **Review with user**: Show draft, allow edits
5. **Set status**: Default to `proposed` unless user specifies `accepted`
6. **Write file**: Create the ADR in `./docs/decisions/`

## Related Skill

For full conventions and guidelines, see:
```
/skill architecture-decision-records
```
