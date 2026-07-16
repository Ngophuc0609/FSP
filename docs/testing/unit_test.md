---
title: Unit Testing Specifications & Mocking Guidelines
category: testing
version: 2.0.0
last_updated: 2026-07-15
---

# UNIT TESTING SPECIFICATIONS (`xUnit` / `flutter_test`)

## 1. Mocking Frameworks & Isolation Rules
- **Backend (.NET):** Use `xUnit` for test execution, `NSubstitute` for mocking interfaces (`IRepository<T>`, `ITenantProvider`), and `FluentAssertions` for readable assertions.
- **Mobile (Flutter):** Use `flutter_test` and `mocktail` for mocking `Dio` remote repositories and `Drift` local database engines.

---

## 2. Strict Zero-IO Rule for Unit Tests
Unit tests in `tests/FSP.Domain.Tests` and `tests/FSP.Application.Tests` MUST run in pure in-memory isolation without making network HTTP requests, accessing the file system, or connecting to real SQL/Redis instances. Execution of 1,000 unit tests must complete under `3 seconds`.
