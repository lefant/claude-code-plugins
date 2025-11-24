# CHANGELOG Fragments Skill

Use this skill when creating or working with CHANGELOG fragments. CHANGELOG fragments are ongoing documentation of changes, stored in the `CHANGELOG/` directory.

## Fragment Structure

Fragments follow this naming convention:
- **Format**: `YYYY-MM-DD_brief-description.md`
- **Examples**: `2025-11-19_branch-management-research.md`, `2025-11-05_sync-database-tracking.md`

## Fragment Template

```markdown
---
date: YYYY-MM-DD
author: Your Name (optional)
type: feature|fix|chore|docs|refactor|test|perf
related_issues: []
related_prs: []
related_devlog: thoughts/shared/devlog/YYYY-MM-DD_implementation.md (optional)
---

Brief summary of the change (1-3 sentences). Focus on what changed and why it matters.

## Details (optional)

More detailed explanation if needed:
- Bullet points for key changes
- Important technical decisions
- Breaking changes or migration notes
```

## Minimal Format

For simple changes, a minimal format is acceptable:

```markdown
---
date: 2025-11-19
type: fix
---

Fixed bug in test configuration where environment variables were not properly validated.
```

## Fragment Types

- **feature**: New features or enhancements
- **fix**: Bug fixes
- **chore**: Maintenance tasks, dependency updates
- **docs**: Documentation changes
- **refactor**: Code refactoring without behavior changes
- **test**: Test additions or improvements
- **perf**: Performance improvements

## When to Create a Fragment

Create a CHANGELOG fragment for:
- ✅ Any implementation documented in a devlog (--shared only)
- ✅ Completing a planned feature or fix
- ✅ Making a breaking change
- ✅ Significant refactoring or architecture changes
- ✅ Important bug fixes
- ✅ Documentation improvements that affect users

Skip fragments for:
- ❌ Work-in-progress commits
- ❌ Typo fixes in comments
- ❌ Small documentation tweaks
- ❌ Personal experiments (--local devlogs)

## Benefits of This Approach

1. **No merge conflicts**: Each change creates its own file
2. **Ongoing documentation**: Fragments stay as historical record
3. **Easy to review**: Each PR shows its changelog fragment
4. **Linked to devlogs**: Connect user-facing changes to technical details
5. **Searchable history**: Grep through fragments to find when something changed

## Examples Location

See `CHANGELOG/examples/` for example fragments demonstrating various formats and types.

## Integration with Devlog Command

When using `/devlog` for shared implementations:
1. Create the devlog entry in `thoughts/shared/devlog/`
2. Create a corresponding CHANGELOG fragment in `CHANGELOG/`
3. Link the fragment to the devlog via `related_devlog` frontmatter field
4. Use the same date and slug in both filenames for consistency
