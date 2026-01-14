# GitHub Get PR Comments Command

Fetch PR comments and build context for addressing reviewer feedback.

Extra user prompt: $ARGUMENTS

## Usage

```
/github_get_pr_comments [pr-url-or-number]
```

## Arguments

- **pr-url-or-number** (optional): GitHub PR URL or PR number
  - Full URL: `https://github.com/owner/repo/pull/123`
  - Number only: `123`
  - If omitted: auto-detect PR for current branch

## What it does

1. **Identify the PR**: Use provided URL/number or find PR for current branch
2. **Fetch PR comments**: Get reviews, inline comments, and general comments
3. **Gather local context**: Use `/recent_context_from_git` and check uncommitted changes
4. **Build working context**: Combine PR feedback with local work state

## Prerequisites

This command uses the `/github-access` skill (`github-access/skills/github-access/SKILL.md`) for GitHub operations. Ensure:
- `GH_TOKEN` environment variable is set
- `gh` CLI is available (preferred) or `curl` as fallback

## Process

### Step 1: Identify the PR

If no PR URL or number is provided, find the PR for the current branch:

```bash
# Get current branch name
BRANCH=$(git rev-parse --abbrev-ref HEAD)

# Find PR for this branch (requires gh CLI)
gh pr list --head "$BRANCH" --json number,url,title --limit 1
```

If on `main`/`master` or no PR found, prompt user for PR URL/number.

### Step 2: Fetch PR Details and Comments

Use the `/github-access` skill patterns:

```bash
# PR metadata
gh pr view PR_NUMBER --repo OWNER/REPO --json number,title,body,headRefName,baseRefName,state,author

# All comments and reviews
gh pr view PR_NUMBER --repo OWNER/REPO --json comments,reviews

# Inline review comments (code-specific)
gh api repos/OWNER/REPO/pulls/PR_NUMBER/comments --paginate
```

### Step 3: Gather Local Context

Run `/recent_context_from_git` to find relevant devlogs, plans, and specs that explain the implementation being reviewed.

Additionally, check for uncommitted changes in documentation locations:

```bash
# Uncommitted doc files that may contain relevant context
git status --porcelain -- \
  'thoughts/shared/research/*.md' \
  'thoughts/shared/plans/*.md' \
  'thoughts/shared/devlog/*.md' \
  'docs/specs/*.md' \
  'docs/decisions/*.md'

# Show diff of uncommitted doc changes
git diff -- 'thoughts/shared/**/*.md' 'docs/**/*.md'
```

These uncommitted files often contain work-in-progress context about ongoing changes.

### Step 4: Build Working Context

Present a unified view combining:

1. **PR Summary**: Title, description, branch info
2. **Review Feedback**: Organized by priority/type
3. **Local Context**: Related devlogs, plans, specs
4. **Uncommitted Work**: WIP documentation explaining current state

## Output Format

```
## PR #{number}: {title}
**Branch**: {head} → {base}
**Author**: {author}
**State**: {state}

---

### Review Summary

**Approved by**: @reviewer1, @reviewer2
**Changes requested by**: @reviewer3

---

### Comments to Address

#### Blocking / Required
- **{file}:{line}** (@{user}): {comment}

#### Suggestions
- **{file}:{line}** (@{user}): {comment}

#### Questions
- **{file}:{line}** (@{user}): {question}

---

### Local Context

**Related docs** (from /recent_context_from_git):
- `thoughts/shared/devlog/2026-01-14_feature_progress.md` - WIP implementation notes
- `thoughts/shared/plans/2026-01-12_feature-plan.md` - Original plan

**Uncommitted changes**:
- `thoughts/shared/devlog/2026-01-14_feature_progress.md` (modified) - Current session notes
```

## Example Usage

```
# Auto-detect PR for current branch
/github_get_pr_comments

# Specific PR by number
/github_get_pr_comments 42

# Specific PR by URL
/github_get_pr_comments https://github.com/owner/repo/pull/42
```

## Best Practices

1. **Run on feature branch** - auto-detection works best from the PR's branch
2. **Check uncommitted docs** - WIP devlogs often explain unfinished work
3. **Use with `/review_pr`** - this command builds context, `/review_pr` creates action plan
4. **Reference local context when responding** - explain implementation decisions using devlogs
