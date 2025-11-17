# Context7 Plugin

Context7 MCP server integration for accessing up-to-date library documentation directly from Claude Code.

## Contents

- **Skill**: `context7` - Generic instructions for using Context7 to fetch library docs
- **MCP Server**: `.mcp.json` - Configuration for Context7 MCP server

## Usage

This plugin provides the Context7 skill and MCP server configuration, which allows Claude to fetch current, version-specific documentation for any library.

**Key commands:**
- `resolve-library-id` - Find the Context7 ID for a library
- `get-library-docs` - Fetch documentation for a specific topic

## Project-Specific Libraries

The list of libraries for your specific project should be maintained in a `LIBRARIES.md` file in your project root, which references this plugin.

## Configuration

The Context7 MCP server requires a `CONTEXT7_API_KEY` environment variable. Set this in your environment or in your Claude Code configuration:

```bash
export CONTEXT7_API_KEY=ctx7sk_your_api_key
```

## See Also

- Context7 skill documentation in `skills/context7/SKILL.md`
- Context7 website: https://context7.com
