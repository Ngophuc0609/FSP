---
title: Technology Decisions & Rationale - Field Service Platform (FSP)
category: architecture
version: 2.0.0
last_updated: 2026-07-15
---

# TECHNOLOGY DECISIONS & RATIONALE (`ADR Summary`)

## 1. Why `.NET Core 8+` over Node.js / Java?
- **Type Safety & Enterprise Maturity:** C# provides strict compile-time type safety, `record` types for immutable DTOs, and native `async/await` concurrency without callback hell or runtime type drift.
- **Performance:** .NET 8 benchmarks consistently outperform Node.js in CPU-bound calculations and high-throughput MediatR request processing.

---

## 2. Why `Flutter` + `Drift` over React Native / PWA for Mobile?
- **Direct Engine Rendering:** Flutter compiles directly to ARM machine code using the Skia/Impeller rendering engine, eliminating JavaScript bridge latency during complex touch interactions.
- **Offline Reliability:** PWAs drop offline data when iOS/Android clears Safari/Chrome storage under low memory. Flutter with native `Drift` SQLite guarantees permanent local ACID storage until synced.

---

## 3. Why `MediatR` + `Result<T>` over traditional Service classes and Exceptions?
- **Zero Exception Flow Control:** Throwing and catching `Exception` objects in C# incurs massive stack trace allocation overhead. `Result<T>` returns explicit success/error payloads safely.
- **Decoupled Handlers:** Each command (`CreateWorkOrderCommand`) has exactly one dedicated handler class (`CreateWorkOrderCommandHandler`), eliminating 2,000-line "God Service" classes.
