---
title: Branching Strategy & Git Flow - Field Service Platform (FSP)
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# BRANCHING STRATEGY & GIT FLOW (`Trunk-Based Development`)

## 1. Branch Topology

```mermaid
gitGraph
    commit id: "v1.8.0"
    branch develop
    checkout develop
    commit id: "sync-develop"
    branch feature/wo-offline-sync
    checkout feature/wo-offline-sync
    commit id: "add Drift table"
    commit id: "add delta sync worker"
    checkout develop
    merge feature/wo-offline-sync
    branch release/v2.0.0
    checkout release/v2.0.0
    commit id: "bump version v2.0.0"
    checkout main
    merge release/v2.0.0 tag: "v2.0.0"
```

## 2. Branch Naming Rules
- **Feature Branches:** `feature/<ticket-id>-<short-description>` (e.g., `feature/FSP-104-offline-sync-queue`).
- **Bug Fixes:** `bugfix/<ticket-id>-<short-description>` (e.g., `bugfix/FSP-209-tenant-filter-leak`).
- **Hotfixes (Production):** `hotfix/vX.Y.Z-<short-description>` (e.g., `hotfix/v2.0.1-redis-timeout`).
