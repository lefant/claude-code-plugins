# Git Resolve Merge Conflicts Command

Help resolve git merge conflicts by analyzing changes from both branches and applying resolutions.

Extra user prompt: $ARGUMENTS

## Usage

```
/git_resolve_merge_conflicts [context-hints]
```

## What it does

1. **Identify conflicts**: List all files with merge conflicts
2. **Gather context**: Check git log for relevant changes on both branches
3. **Analyze each conflict**: Read conflicting files and understand intent from both sides
4. **Resolve conflicts**: Apply best-judgment resolutions
5. **Complete merge**: Stage resolved files and commit the merge

## Autonomy Guidelines

- **No risk of logic bugs**: Proceed autonomously—resolve, stage, and commit
- **Questions or ambiguity**: Raise questions first, then once clarified, resolve + stage + commit in one go
- **Never stop at staging**: Always complete the merge commit after resolving

## Process

### Step 1: Identify Conflicts

```bash
git status --porcelain | grep "^UU\|^AA\|^DD"
git diff --name-only --diff-filter=U
```

### Step 2: Gather Context

Check recent commits on both branches for context about the changes:

```bash
# What changed on the branch being merged
git log --stat HEAD...MERGE_HEAD -- <conflicted-files>

# What changed on current branch
git log --stat MERGE_HEAD...HEAD -- <conflicted-files>
```

Additionally, use `/recent_context_from_git` to find relevant devlogs, plans, and specs that explain the intent behind recent changes. This is especially useful when conflicts involve feature work documented in `thoughts/shared/`.

If the user provides hints (like `thoughts/shared/{plans,devlog}`), check those for additional context.

### Step 3: Analyze Each Conflict

For each conflicted file:
1. Read the file to see conflict markers
2. Understand what each side was trying to achieve
3. Determine if changes are complementary or contradictory

### Step 4: Resolve Conflicts

Apply resolutions based on analysis:

| Scenario | Resolution |
|----------|------------|
| Non-overlapping changes | Keep both changes |
| Same intent, different implementation | Pick the better implementation |
| Complementary additions | Merge both |
| Formatting/whitespace only | Pick either, stay consistent |
| **Contradictory logic** | Ask user for guidance |

### Step 5: Complete Merge

After resolving all conflicts:

```bash
git add <resolved-files>
git commit --no-edit  # Uses default merge commit message
```

Or with a custom message if context warrants it:

```bash
git commit -m "Merge branch 'x' into y: resolve conflicts in <files>"
```

## When to Ask Questions

Only raise questions when there's genuine ambiguity that could cause logic bugs:

- Two features modify the same logic differently
- Contradictory business rules
- Unclear which implementation is "correct"
- Deletions that might break dependent code

Once the user answers, immediately resolve + stage + commit.

## Example Usage

```
/git_resolve_merge_conflicts

/git_resolve_merge_conflicts check thoughts/shared/devlog for context about changes
```

## Best Practices

1. **Trust your analysis** - if the resolution is clear, proceed
2. **Use `/recent_context_from_git`** - devlogs/plans often explain why changes were made
3. **Preserve both intents when possible** - conflicts often reflect parallel work
4. **Test after merging** - run build/tests after commit to verify
5. **Ask once, resolve fully** - don't ask multiple rounds of questions
