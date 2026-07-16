---
title: Skill - Design Database Schema & EF Core Migrations
category: skill
version: 2.0.0
last_updated: 2026-07-15
---

# SKILL: DESIGN DATABASE SCHEMA (`Skill-Design-Database-Schema`)

## 1. Purpose & Trigger
Use this skill when tasked with designing relational database schemas, ER diagrams, or adding EF Core migrations.

## 2. Execution Steps
1. **Model Relational Entity:** Ensure entity inherits from `BaseTenantEntity` (guaranteeing `TenantId` and audit columns).
2. **Configure Fluent API:** Write explicit `IEntityTypeConfiguration<T>` in `FSP.Infrastructure/Persistence/Configurations/`. Configure indexes (`HasIndex(e => new { e.TenantId, e.Status })`).
3. **Verify Expand-and-Contract:** Check if new columns break backward compatibility. If non-nullable column is added to existing table, set default or make nullable first.
4. **Update ERD:** Update `docs/database/erd.md` Mermaid diagram with the new schema entities.
