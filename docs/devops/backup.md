---
title: Database Backup & Point-In-Time Restoration (PITR) Policy
category: devops
version: 2.0.0
last_updated: 2026-07-15
---

# DATABASE BACKUP & RESTORATION POLICY

## 1. Automated Backup SLA (`Azure SQL Server`)
- **Full Backups:** Executed automatically every `7 days`.
- **Differential Backups:** Executed every `12 hours`.
- **Transaction Log Backups:** Executed every `5 minutes`, enabling **Point-In-Time Recovery (`PITR`)** with a maximum Recovery Point Objective (`RPO`) of `< 5 minutes`.

---

## 2. Retention Windows
- Production backup snapshots are retained in geo-redundant storage (`RA-GRS`) for `35 days`.
- Monthly compliance audit snapshots are retained in cold storage for `7 years`.
