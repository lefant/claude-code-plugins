# CHANGELOG Fragments Skill

Use this skill when creating or working with CHANGELOG fragments. CHANGELOG fragments are ongoing documentation of changes, stored in the `CHANGELOG/` directory.

## Purpose

Using changelog fragments prevents merge conflicts in CHANGELOG.md when multiple feature branches are developed in parallel. Each change creates its own fragment file, which stays as permanent documentation rather than being archived.

## Fragment Naming Convention

Fragments are named using date-based patterns:

- **Standard format**: `YYYY-MM-DD_brief-description.md`
- **Examples**:
  - `2025-11-19_branch-management-research.md`
  - `2025-11-05_sync-database-tracking.md`
  - `2025-11-03_test-env-migration.md`

This naming convention:
- Makes fragments chronologically sortable
- Aligns with devlog naming convention
- Makes it easy to find when something changed

## Fragment Format

Fragments follow this structure:

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

## Using Fragments

Fragments are ongoing documentation and stay in the `CHANGELOG/` directory permanently. They provide:
- Chronological history of changes
- Searchable documentation (`grep` through fragments)
- Links to detailed devlogs
- Context for why changes were made

To find when something changed:
```bash
grep -r "search term" CHANGELOG/
```

To see all changes of a specific type:
```bash
grep "^type: feature" CHANGELOG/*.md
```

To list recent changes chronologically:
```bash
ls -1 CHANGELOG/2025-*.md | tail -10
```

## Benefits of This Approach

1. **No merge conflicts**: Each change creates its own file
2. **Ongoing documentation**: Fragments stay as historical record
3. **Easy to review**: Each PR shows its changelog fragment
4. **Linked to devlogs**: Connect user-facing changes to technical details
5. **Searchable history**: Grep through fragments to find when something changed
6. **Chronological organization**: Date-based naming makes timeline clear

## Template and Examples

**Template location**: `lefant-claude-code-plugins/lefant/skills/changelog/template.md`

**Example fragments**: See `lefant-claude-code-plugins/lefant/skills/changelog/examples/` for:
- `feature-example.md` - Feature implementation with database tracking
- `fix-example.md` - Bug fix with environment variable mismatch
- `chore-example.md` - Simple maintenance task

## Integration with Devlog Command

When using `/devlog` for shared implementations:

1. **Create devlog entry**: `thoughts/shared/devlog/YYYY-MM-DD_implementation.md`
2. **Create CHANGELOG fragment**: `CHANGELOG/YYYY-MM-DD_implementation.md`
3. **Use same date and slug**: Maintains consistency
4. **Link them**: Add `related_devlog` field in fragment frontmatter
5. **Keep summaries aligned**: Fragment = user-facing summary, devlog = technical details

**Example workflow:**
```bash
# After implementing a feature and creating devlog
# thoughts/shared/devlog/2025-11-20_oauth-token-refresh.md

# Create corresponding fragment
# CHANGELOG/2025-11-20_oauth-token-refresh.md
---
date: 2025-11-20
type: feature
related_devlog: thoughts/shared/devlog/2025-11-20_oauth-token-refresh.md
---

Implemented automatic OAuth token refresh for expired Notion connections. Users no longer need to manually reconnect when tokens expire.
```

## Fragment Creation Checklist

When creating a fragment:
- [ ] Use correct date format: `YYYY-MM-DD`
- [ ] Choose descriptive slug (3-5 words)
- [ ] Select appropriate type (feature/fix/chore/docs/refactor/test/perf)
- [ ] Write 1-3 sentence summary
- [ ] Link to devlog if available (`related_devlog` field)
- [ ] Add details section if change needs explanation
- [ ] Link related issues/PRs if applicable
- [ ] Save to `CHANGELOG/` directory
- [ ] Commit with the implementation
