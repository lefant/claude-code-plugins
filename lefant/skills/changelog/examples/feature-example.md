---
date: 2025-11-05
type: feature
related_issues: [#49]
related_prs: [#60]
related_devlog: thoughts/shared/devlog/2025-11-05_sync-database-tracking.md
---

Implemented automatic sync database creation during OAuth callback to track document versions and enable deduplication. Sync databases are now automatically created under the user's configured root page when they connect Notion.

## Details

- Added `createSyncDatabase()` function to create tracking database in Notion
- Modified OAuth callback to automatically create sync database after root page configuration
- Added `syncDatabaseId` to user metadata storage
- Updated workflows to use sync database for document tracking
- Implemented version tracking and deduplication logic
- Sync database uses Notion database API with custom properties for item tracking
- Database ID stored in Stack Auth user metadata
- Graceful degradation: sync works without database, just no deduplication
