# GitHub Access Plugin

Provides the `github-access` Skill for Claude Code. It guides the model through authenticated GitHub operations using either the `gh` CLI or REST API via `curl`, with detailed references for issues, pull requests, workflows, and troubleshooting.

## Contents
- `.claude-plugin/plugin.json` — plugin manifest
- `skills/github-access/SKILL.md` — main Skill instructions
- `skills/github-access/references/` — command and API reference material

## Usage
Install this plugin (or load from a local marketplace) to make the `github-access` Skill available in Claude Code sessions. Ensure `GH_TOKEN` is set; the Skill will choose between `gh` CLI and REST calls depending on tool availability.
