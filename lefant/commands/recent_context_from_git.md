# Recent Context from Git Command

Find recently modified documentation to establish context for continuing ongoing or recently completed work.

Extra user prompt: $ARGUMENTS

## Usage
```
/recent_context_from_git [count]
```

## What it does

Spawn a subagent to:
1. Query git history for recently modified documentation files
2. Read the most relevant files
3. Return a concise summary of recent work context

## Subagent Prompt

```
Find recent documentation context from git history.

Run this command to find recently modified docs:

git log --name-only --no-commit-id --pretty=format: \
  -- 'thoughts/shared/research/*.md' \
     'thoughts/shared/plans/*.md' \
     'thoughts/shared/devlog/*.md' \
     'docs/specs/*.md' \
     'docs/decisions/*.md' \
     'docs/changelog/*.md' \
  | grep -v '^$' | head -20 | sort -u

Then:
1. Read the most recent devlogs and plans (prioritize these)
2. Skim related specs, decisions, research as needed

Return a summary in this format:

## In Progress
- [filename]: [status and brief description]

## Recently Completed
- [filename]: [what was done]

## Key Context
- [any important specs, decisions, or research that inform current work]

## Suggested Next Steps
- [based on devlog status and plans]
```

## File Priority

When reading files, prioritize:
1. **Devlogs** (`thoughts/shared/devlog/`) - most recent implementation outcomes
2. **Plans** (`thoughts/shared/plans/`) - what was intended
3. **Research** (`thoughts/shared/research/`) - background context
4. **Specs** (`docs/specs/`) - requirements being implemented
5. **Decisions** (`docs/decisions/`) - architectural context
6. **Changelog** (`docs/changelog/`) - what was completed
