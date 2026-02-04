---
date: 2026-02-04
status: completed
ticket: N/A
title: Update lefant/claude-code-plugins Repository
author: Claude (Opus 4.5)
---

# Plan: Update lefant/claude-code-plugins Repository

## Overview

Update the `lefant-claude-code-plugins` repository to:
1. Remove skills that have been migrated to `lefant/agent-skills`
2. Remove the `beads` plugin (deprecated)
3. Keep only Claude Code-specific plugins (commands, hooks, agents)

## Current State

```
lefant-claude-code-plugins/
├── .claude-plugin/marketplace.json
├── beads/                    # TO REMOVE (deprecated)
├── github-access/            # TO REMOVE (migrated to agent-skills)
├── lefant/                   # TO UPDATE (remove skills, keep commands)
├── ntfy/                     # KEEP (hooks-only)
├── rpi/                      # KEEP (commands + agents)
└── sentry/                   # TO REMOVE (migrated to agent-skills)
```

## Target State

```
lefant-claude-code-plugins/
├── .claude-plugin/marketplace.json   # Updated plugin list
├── lefant/                           # Commands only (no skills)
│   ├── .claude-plugin/plugin.json
│   └── commands/
│       ├── adr_create.md
│       ├── atomically_land.md
│       ├── changelog_create.md
│       ├── devlog.md
│       ├── git_resolve_merge_conflicts.md
│       ├── github_get_pr_comments.md
│       ├── handover.md
│       ├── recent_context_from_git.md
│       └── spec_create.md
├── ntfy/                             # Unchanged
│   ├── .claude-plugin/plugin.json
│   ├── hooks/hooks.json
│   └── scripts/claude-ntfy.sh
└── rpi/                              # Unchanged
    ├── .claude-plugin/plugin.json
    ├── agents/
    └── commands/
```

## Implementation Steps

### Phase 1: Remove Deprecated/Migrated Plugins [COMPLETED]

#### Step 1.1: Remove beads plugin [x]
```bash
rm -rf toolbox/lefant-claude-code-plugins/beads/
```

Reason: The beads plugin requires hooks (`bd prime` on PreCompact/SessionStart) which makes it unsuitable for the skills-only approach. If beads integration is needed later, it should be a full plugin or handled differently.

#### Step 1.2: Remove github-access plugin [x]
```bash
rm -rf toolbox/lefant-claude-code-plugins/github-access/
```

Reason: Migrated to `lefant/agent-skills` as a skill.

#### Step 1.3: Remove sentry plugin [x]
```bash
rm -rf toolbox/lefant-claude-code-plugins/sentry/
```

Reason: Migrated to `lefant/agent-skills` as a skill.

### Phase 2: Update lefant Plugin [COMPLETED]

#### Step 2.1: Remove skills directory from lefant plugin [x]
```bash
rm -rf toolbox/lefant-claude-code-plugins/lefant/skills/
```

Reason: All skills migrated to `lefant/agent-skills`.

#### Step 2.2: Update lefant plugin.json [x]
File: `toolbox/lefant-claude-code-plugins/lefant/.claude-plugin/plugin.json`

Update description to reflect commands-only:
```json
{
  "name": "lefant",
  "version": "0.4.0",
  "description": "lefant ai coding helpers. /devlog, /handover, /adr, /changelog, /spec commands.",
  "author": {
    "name": "Fabian Linzberger"
  },
  "keywords": ["devlog", "handover", "adr", "changelog", "spec", "commands"]
}
```

### Phase 3: Update Marketplace Configuration [COMPLETED]

#### Step 3.1: Update marketplace.json [x]
File: `toolbox/lefant-claude-code-plugins/.claude-plugin/marketplace.json`

Remove entries for beads, github-access, and sentry:
```json
{
  "name": "lefant-claude-code-plugins",
  "description": "Claude Code plugins for development workflows",
  "owner": {
    "name": "Fabian Linzberger"
  },
  "plugins": [
    {
      "name": "lefant",
      "source": "./lefant",
      "description": "Development commands: /devlog, /handover, /adr, /changelog, /spec"
    },
    {
      "name": "ntfy",
      "source": "./ntfy",
      "description": "Send Claude Code notifications via ntfy"
    },
    {
      "name": "rpi",
      "source": "./rpi",
      "description": "Research/Plan/Implement workflow with specialized agents"
    }
  ]
}
```

### Phase 4: Update Commands to Reference Skills [COMPLETED]

Some commands in the lefant plugin may reference skills (e.g., `/adr` might reference the ADR skill). These commands should be updated to work standalone or reference the new skill location.

#### Step 4.1: Audit command files for skill references [x]
Check each command file in `lefant/commands/` for references to skills.

#### Step 4.2: Update command instructions [x]
If commands reference skills, update them to either:
- Include the necessary instructions inline
- Reference the skill by name (skills are auto-loaded by agents)

### Phase 5: Commit and Push [COMPLETED]

#### Step 5.1: Stage changes [x]
```bash
cd toolbox/lefant-claude-code-plugins
git add -A
git status
```

#### Step 5.2: Commit with clear message [x]
```bash
git commit -m "Remove migrated plugins, keep commands-only

- Remove beads plugin (deprecated)
- Remove github-access plugin (migrated to lefant/agent-skills)
- Remove sentry plugin (migrated to lefant/agent-skills)
- Remove skills from lefant plugin (migrated to lefant/agent-skills)
- Keep lefant commands, ntfy hooks, rpi commands+agents
- Update marketplace.json to reflect changes"
```

## Verification

After completion, verify:
1. `marketplace.json` lists only: lefant, ntfy, rpi
2. `lefant/` contains only `.claude-plugin/` and `commands/`
3. No `skills/` directories remain in any plugin
4. Plugin installation still works:
   ```bash
   claude plugin marketplace add /opt/lefant-claude-code-plugins
   claude plugin install lefant@lefant-claude-code-plugins
   claude plugin install ntfy@lefant-claude-code-plugins
   claude plugin install rpi@lefant-claude-code-plugins
   ```

## File Summary

### Files to DELETE:
- `beads/` (entire directory)
- `github-access/` (entire directory)
- `sentry/` (entire directory)
- `lefant/skills/` (entire directory)

### Files to MODIFY:
- `.claude-plugin/marketplace.json` (remove 3 plugins)
- `lefant/.claude-plugin/plugin.json` (update version, description)

### Files UNCHANGED:
- `ntfy/` (entire directory)
- `rpi/` (entire directory)
- `lefant/commands/` (all command files)

## Dependencies

- `lefant/agent-skills` repository must be created first (skills migrated there)

## Risks and Mitigations

| Risk | Mitigation |
|------|------------|
| Commands may break without skills | Audit commands for skill references first |
| Users may expect old plugins | Document breaking changes in CHANGELOG |
| Git subtree in toolbox may need update | Push changes, then update subtree |

## Estimated Effort

- Phase 1 (Remove): 5 minutes
- Phase 2 (Update lefant): 10 minutes
- Phase 3 (Marketplace): 5 minutes
- Phase 4 (Audit commands): 15 minutes
- Phase 5 (Commit): 5 minutes

Total: ~40 minutes
