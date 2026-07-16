---
title: Skill - Build Flutter Screen & Riverpod Provider
category: skill
version: 2.0.0
last_updated: 2026-07-15
---

# SKILL: BUILD FLUTTER SCREEN (`Skill-Build-Flutter-Screen`)

## 1. Purpose & Trigger
Use this skill when tasked with scaffolding a new Flutter UI feature or screen (`WorkOrderListScreen`, `InspectionChecklistScreen`).

## 2. Execution Steps
1. **Define Domain Model:** Create pure immutable class (`lib/features/<name>/domain/models/`).
2. **Setup Local Drift Table:** Add table definition inside `lib/core/database/schema/` and generate SQLite queries.
3. **Setup Riverpod `AsyncNotifierProvider`:** Create state notifier that streams Drift data directly to the presentation layer.
4. **Scaffold `ConsumerWidget` Screen:** Implement clean UI with explicit handling for `AsyncValue.loading`, `AsyncValue.error`, and `AsyncValue.data`. Enforce `48x48px` touch boxes.
