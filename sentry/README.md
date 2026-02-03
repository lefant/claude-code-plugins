# Sentry Plugin

Fetch and analyze Sentry issues, events, transactions, and logs. Helps agents debug errors, find root causes, and understand what happened at specific times.

## Attribution

This plugin is forked from [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff) (skills/sentry) by Armin Ronacher.

## Setup

1. Install sentry-cli and authenticate:
   ```bash
   npm install -g @sentry/cli
   sentry-cli login
   ```

2. This creates `~/.sentryclirc` with your auth token.

## Usage

See the skill documentation in `skills/sentry/SKILL.md` for detailed usage.
