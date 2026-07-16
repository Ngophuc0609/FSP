---
title: Production Release & Blue-Green Deployment Process
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# PRODUCTION RELEASE & BLUE-GREEN DEPLOYMENT PROCESS

## Zero-Downtime Blue-Green Deployment Workflow
```mermaid
graph LR
    TRAFFIC[Cloudflare CDN / Load Balancer] -->|Current Production Traffic| BLUE[Blue Environment<br/>Live Production v1.9.0]
    TRAFFIC -.-|Switch after Smoke Test| GREEN[Green Environment<br/>Staging Deploy v2.0.0]
    GREEN -->|Runs EF Core Online Migrations| SQL[(Azure SQL Server)]
    BLUE -->|Queries existing columns| SQL
```

### Deployment Runbook Steps
1. Deploy new container image (`v2.0.0`) to the passive **Green Environment**.
2. Execute EF Core non-destructive `Expand` database migrations.
3. Run automated smoke tests against Green endpoints (`/health`, `/api/v1/work-orders`).
4. Swap routing slots in Cloudflare (`100% traffic to Green`).
5. Maintain passive Blue container for `24 hours` for instant rollback capability if anomalous error rates occur.
