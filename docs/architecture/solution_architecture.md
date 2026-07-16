---
title: Solution Architecture & Technical Stack - Field Service Platform (FSP)
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# SOLUTION ARCHITECTURE & TECHNICAL STACK

## 1. Technical Stack Summary Table

| Layer / Component | Technology / Framework | Version | Purpose / Decision Rationale |
| :--- | :--- | :--- | :--- |
| **Backend Runtime** | `.NET Core` | `8.0+ (LTS)` | High-performance, cross-platform enterprise runtime with robust threading and memory management. |
| **Orchestration & CQRS**| `MediatR` | `12.x` | Decouples API endpoints from domain logic; enables pipeline validation and logging behaviors. |
| **Validation Engine** | `FluentValidation` | `11.x` | Strongly typed, testable validation rules cleanly separated from domain models. |
| **Database Engine** | `Microsoft SQL Server` | `2022+ / Azure SQL`| Enterprise ACID relational store with robust JSON column support and partitioned indexes. |
| **ORM & Data Access** | `Entity Framework Core` | `8.0+` | LINQ-to-SQL compiler with automatic global query filtering (`TenantId` isolation) and migrations. |
| **Mobile Client Engine**| `Flutter (Dart)` | `3.22+` | Single codebase compiling natively to iOS and Android with `60/120 FPS` rendering performance. |
| **Mobile State Mgmt** | `Riverpod` | `2.x (Generator)`| Compile-safe, testable state management with automatic lifecycle disposal and async state handling. |
| **Mobile Offline Store**| `Drift (SQLite)` | `2.x` | Reactive, strongly typed SQL database inside mobile devices ensuring zero data loss during offline operations. |
