# Ntfy Plugin

Send Claude Code notifications via [ntfy](https://ntfy.sh) when sessions complete or events occur.

## Features

- Sends notifications on Claude Code events (primarily `Notification` hook)
- Includes session context: project name, branch, directory, token usage
- Extracts token usage from session transcripts
- Supports authenticated ntfy topics

## Configuration

This plugin requires environment variables to be set:

### Required
- `NTFY_URL` - Your ntfy topic URL (e.g., `https://ntfy.sh/claude-your-topic`)

### Optional
- `NTFY_TOKEN` - Bearer token for authenticated topics (e.g., `tk_...`)

### Setup

Set these environment variables in your shell or environment configuration:

```bash
export NTFY_URL=https://ntfy.sh/claude-your-topic
export NTFY_TOKEN=tk_your_token_here
```

The environment variables need to be available when Claude Code runs.

## How It Works

The plugin hooks into Claude Code's `Notification` event and sends:
- **Title**: Event type (e.g., "Claude: Notification")
- **Body**: Project context + message
  - Project name and branch (from git)
  - Current directory
  - Token usage statistics
  - Event message (if available)

## Requirements

- `jq` - JSON parsing
- `curl` - Sending notifications
- `git` (optional) - For project/branch detection

## Hook Configuration

The plugin registers a `Notification` hook that runs the `claude-ntfy.sh` script using `${CLAUDE_PLUGIN_ROOT}` to ensure it works regardless of working directory.

## Testing

You can test the hook manually by sending JSON to the script:

```bash
echo '{"hook_event_name":"Test","session_id":"test123","message":"Hello"}' | \
  NTFY_URL=https://ntfy.sh/your-topic \
  .claude/plugins/ntfy/scripts/claude-ntfy.sh
```

Check your ntfy topic to see if the notification arrived.

## Disabling

To disable notifications without uninstalling the plugin, either:
1. Unset the `NTFY_URL` environment variable
2. Disable the plugin using `/plugin disable ntfy`
3. Add to `.claude/settings.json`:
   ```json
   {
     "disabledPlugins": ["ntfy"]
   }
   ```
