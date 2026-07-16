---
title: Automated Regression Test Suite & Gatekeeper Policy
category: testing
version: 2.0.0
last_updated: 2026-07-15
---

# AUTOMATED REGRESSION TEST SUITE & POLICY

## 1. Regression Suite Execution SLA
The FSP regression suite (`dotnet test tests/` + `flutter test`) runs automatically on every pull request created on GitHub via GitHub Actions (`ci.yml`).

## 2. Zero-Regression Gatekeeper Policy
Any pull request that introduces a regression failure or reduces test coverage below the required `90%` boundary is automatically blocked from merge by branch protection rules (`GOV-REV-001`). No engineer or AI agent may bypass a failing regression test.
