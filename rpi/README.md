# RPI Plugin

RPI (Research/Plan/Implement) workflow agents and commands for structured development.

For a broader introduction, check out the [Advanced Context Engineering for Coding Agents talk](https://www.youtube.com/watch?v=IS_y40zY-hc) and the companion [ACE Framework for Coding Agents guide](https://github.com/humanlayer/advanced-context-engineering-for-coding-agents/blob/main/ace-fca.md). Command catalog lives in the [HumanLayer Claude commands reference](https://github.com/humanlayer/humanlayer/tree/main/.claude).

## Structure
- `.claude-plugin/plugin.json` — plugin manifest
- `agents/` — specialized agents (`codebase-analyzer`, `locator`, `pattern-finder`, `web-search-researcher`, etc.)
- `commands/` — slash commands (`research_codebase`, `create_plan`, `implement_plan`)

## Usage
Install this plugin (or load via a local marketplace) to enable the RPI workflow in Claude Code. Requires no external dependencies beyond standard tool access used by the original agents/commands.
