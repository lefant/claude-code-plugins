# Sentry Plugin

Fetch and analyze Sentry issues, events, transactions, and logs. Helps agents debug errors, find root causes, and understand what happened at specific times.

## Attribution

This plugin is forked from [mitsuhiko/agent-stuff](https://github.com/mitsuhiko/agent-stuff) (skills/sentry) by Armin Ronacher.

## Authentication

The skill supports multiple authentication methods (checked in order):

### Option 1: Environment Variables (recommended for CI/containers)

```bash
# Required: Auth token
export SENTRY_AUTH_TOKEN="sntryu_xxx..."

# Optional: Region URL (for EU, etc.)
export SENTRY_URL="https://de.sentry.io"
```

### Option 2: Config File (`~/.sentryclirc`)

```ini
[auth]
token=your-token-here
url=https://de.sentry.io  # For EU region (optional)
```

Create via `sentry-cli login` or manually.

### Token Permissions

Create a token at https://sentry.io/settings/account/api/auth-tokens/ with scopes:
- `project:read`
- `event:read`
- `org:read`

### Region Support

The skill auto-detects the region from:
1. `SENTRY_URL` environment variable
2. `url=` in `~/.sentryclirc`
3. Region embedded in new-style tokens (`sntrys_...`)
4. Defaults to US (`sentry.io`)

For EU: use `https://de.sentry.io`

## Usage

See the skill documentation in `skills/sentry/SKILL.md` for detailed usage.
