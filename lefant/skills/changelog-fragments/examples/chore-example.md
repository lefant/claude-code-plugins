---
date: 2025-11-07
type: chore
---

Fixed test cleanup bug where `archiveMultiplePages()` was called with incorrect 4-parameter signature instead of 3 parameters. Removed unnecessary `connectionId` parameter from all test cleanup calls.
