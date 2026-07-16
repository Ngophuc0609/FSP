---
title: Flutter Mobile Domain Rules (Offline-First Architecture)
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# FLUTTER MOBILE DOMAIN RULES (`RULE-FLUTTER-001` to `005`)

## RULE-FLUTTER-001: Feature-First Directory Layout
All Dart code inside `src/flutter/lib/` must be structured cleanly by feature:
```text
lib/
├── core/                    # Networking (Dio), Database (Drift), Themeing, Error Handling
└── features/
    └── work_orders/
        ├── domain/          # Pure Dart entities & repository interfaces
        ├── data/            # Drift local database sources, API remote sources, repositories
        └── presentation/    # Riverpod state providers, BLoC/Controllers, Screens, Widgets
```

## RULE-FLUTTER-002: Mandatory Local-First Persistence (`Drift`)
Never fetch data from network remote repositories directly into UI screens. All remote payloads must be upserted into local `Drift` SQLite tables first. UI widgets must listen to local database streams (`watch()`) to guarantee instantaneous offline rendering.

## RULE-FLUTTER-003: Touch Ergonomics & Accessibility
Field service technicians operate outdoors with protective work gloves. Every tappable widget (`ElevatedButton`, `InkWell`, `Checkbox`) MUST enforce a minimum physical touch target box of `48x48 logical pixels`.
