#!/usr/bin/env sh
# Send session-aware Claude hook notifications to ntfy

# Wrap everything in a subshell so errors don't prevent exit
(
set -e

# Read hook JSON from stdin
payload="$(cat)"

# Debug: log the payload to a file
echo "$(date -Iseconds): $payload" >> /tmp/claude-hook-debug.log

# Extract bits (jq required)
event="$(printf %s "$payload" | jq -r '.hook_event_name // "Event"')"
sid="$(printf %s "$payload"   | jq -r '.session_id        // "?"')"
cwd="$(printf %s "$payload"   | jq -r '.cwd               // ""')"
msg="$(printf %s "$payload"   | jq -r '.message           // ""')"

# Build title
title="Claude: ${event}"

# Try to get project name and branch from git
project_name=""
branch_name=""
if git rev-parse --git-dir >/dev/null 2>&1; then
  branch_name=$(git branch --show-current 2>/dev/null || echo "")
  remote_url=$(git config --get remote.origin.url 2>/dev/null || echo "")
  if [ -n "$remote_url" ]; then
    project_name=$(echo "$remote_url" | sed 's/\.git$//' | sed 's/.*[\/:]\([^/]*\/[^/]*\)$/\1/')
  fi
fi

# Fallback to directory basename if no git remote
if [ -z "$project_name" ]; then
  project_name="$(basename "$(pwd)")"
fi

# Get token usage - first check if it's provided directly in JSON
token_used="$(printf %s "$payload" | jq -r '.token_usage.used // empty')"
token_total="$(printf %s "$payload" | jq -r '.token_usage.total // empty')"
token_info=""

if [ -n "$token_used" ] && [ -n "$token_total" ]; then
  # Token usage provided directly in JSON
  used_k=$((token_used / 1000))
  total_k=$((token_total / 1000))
  percentage=$((token_used * 100 / token_total))
  token_info="${used_k}k/${total_k}k tokens (${percentage}%)"
else
  # Fallback: get token usage from the transcript
  transcript_path="$(printf %s "$payload" | jq -r '.transcript_path // ""')"

  if [ -z "$transcript_path" ]; then
    token_info="[no transcript_path]"
  elif [ ! -f "$transcript_path" ]; then
    token_info="[transcript not found]"
  else
    # Verify this transcript belongs to our session
    if [ -n "$sid" ]; then
      # Check if transcript path contains our session ID
      if [ "${transcript_path#*$sid}" = "$transcript_path" ]; then
        # Try to find the correct transcript file for this session
        transcript_dir=$(dirname "$transcript_path")
        session_transcript="${transcript_dir}/${sid}.jsonl"
        if [ -f "$session_transcript" ]; then
          transcript_path="$session_transcript"
        else
          token_info="[session transcript not found: ${sid}]"
        fi
      fi
    fi

    if [ -z "$token_info" ]; then
      # Extract the most recent token usage from transcript
      token_line=$(grep -o "Token usage: [0-9]*/[0-9]*" "$transcript_path" | tail -1)

      if [ -n "$token_line" ]; then
        # Extract used and total tokens
        used=$(echo "$token_line" | sed 's/Token usage: \([0-9]*\)\/[0-9]*/\1/')
        total=$(echo "$token_line" | sed 's/Token usage: [0-9]*\/\([0-9]*\)/\1/')

        # Convert to k format
        used_k=$((used / 1000))
        total_k=$((total / 1000))

        # Calculate percentage
        percentage=$((used * 100 / total))

        token_info="${used_k}k/${total_k}k tokens (${percentage}%)"
      else
        token_info="[no token usage in transcript]"
      fi
    fi
  fi
fi

# Build context string: repo@branch  •  directory  •  token stats
context=""
if [ -n "$project_name" ] && [ -n "$branch_name" ]; then
  context="${project_name}@${branch_name}"
elif [ -n "$project_name" ]; then
  context="$project_name"
fi

if [ -n "$context" ] && [ -n "$cwd" ]; then
  context="${context}  •  ${cwd}"
elif [ -n "$cwd" ]; then
  context="$cwd"
fi

if [ -n "$context" ] && [ -n "$token_info" ]; then
  context="${context}  •  ${token_info}"
fi

# Build body
if [ -n "$context" ] && [ -n "$msg" ]; then
  body="$(printf '%s\n\n%s' "$context" "$msg")"
elif [ -n "$context" ]; then
  body="$context"
elif [ -n "$msg" ]; then
  body="$msg"
else
  body="Done"
fi

# Require NTFY_URL
if [ -z "$NTFY_URL" ]; then
  echo "NTFY_URL not set" >&2
  exit 2
fi

# Send notification
if [ -n "$NTFY_TOKEN" ]; then
  printf '%s' "$body" | curl -fsS -X POST "$NTFY_URL" -H "Authorization: Bearer ${NTFY_TOKEN}" -H "Title: ${title}" -H "Priority: 4" -H "Tags: robot,bookmark_tabs" --data-binary @-
else
  printf '%s' "$body" | curl -fsS -X POST "$NTFY_URL" -H "Title: ${title}" -H "Priority: 4" -H "Tags: robot,bookmark_tabs" --data-binary @-
fi
) || true

# Always exit successfully to allow Claude Code to stop cleanly
exit 0
