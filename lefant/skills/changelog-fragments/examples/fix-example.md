---
date: 2025-11-03
author: Claude Code Assistant
type: fix
related_issues: []
related_prs: []
---

Fixed CI failure caused by environment variable naming mismatch. Code expected `TEST_REMARKABLE_TEST_ITEM_*` but local configuration used `TEST_REMARKABLE_ITEM_*`. Renamed all variables to use more explicit naming convention matching GitHub Actions configuration.
