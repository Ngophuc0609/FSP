---
title: Disaster Recovery & Business Continuity Plan (DRP)
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# DISASTER RECOVERY & BUSINESS CONTINUITY PLAN (`DRP`)

## Recovery Objectives
- **Recovery Time Objective (RTO):** `< 4 hours` (Maximum acceptable downtime before regional failover completes).
- **Recovery Point Objective (RPO):** `< 5 minutes` (Maximum acceptable data loss window during catastrophic datacenter outage).

---

## Regional Active-Passive Failover Strategy
If primary datacenter (`East US 2`) suffers a complete physical outage:
1. Azure Traffic Manager / Cloudflare automatically re-routes DNS traffic to secondary passive datacenter (`West US 2`).
2. Secondary Geo-Replicated SQL database instance transitions from Read-Only to Read-Write mode automatically within `180 seconds`.
