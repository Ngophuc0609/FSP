---
standard_id: STD-FLUTTER-001
title: Flutter Mobile Engineering Standard
version: 1.0.0
owner: Principal Mobile Engineer
scope: All Dart/Flutter code inside src/flutter/
rules_referencing: [RULE-FLUTTER-001, RULE-FLUTTER-002]
---

# Flutter Mobile Engineering Standard

## 1. Purpose & Scope
Ensures high performance, clean widget hierarchies, and robust offline synchronization for FSP mobile apps.

## 2. Widget & State Management
- **Stateless by Default:** Prefer `StatelessWidget` whenever possible. Only use `StatefulWidget` when managing ephemeral UI animation or controller state.
- **BLoC Architecture:** For all application and domain state, strictly use `flutter_bloc`.
- **Immutability:** All `Event` and `State` classes must be immutable (`@immutable` or `equatable`).

## 3. Offline-First Synchronization
- All network reads must cache locally using Isar/SQLite.
- All network writes must execute locally first (`Optimistic Mutation`) and enqueue a background synchronization job.
