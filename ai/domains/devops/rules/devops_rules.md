---
title: DevOps, CI/CD & Infrastructure Rules (Docker & GitHub Actions)
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# DEVOPS & INFRASTRUCTURE RULES (`RULE-DEVOPS-001` to `004`)

## RULE-DEVOPS-001: Multi-Stage Non-Root Docker Containerization
All Dockerfiles inside `src/backend/` and `src/web/` must execute multi-stage builds (`build` stage -> `publish` stage -> `runtime` alpine stage) and run as an unprivileged, non-root user (`appuser` with UID `5678`).

## RULE-DEVOPS-002: Zero-Downtime CI/CD Gates
Every GitHub Actions workflow (`ci.yml`) must run build, analyzer, and integration tests before allowing PR merges. Production deployments must follow Blue-Green slot swaps on Azure / Cloudflare.

## RULE-DEVOPS-003: Mandatory OpenTelemetry Trace Propagation
Every service must inject OpenTelemetry headers across HTTP and SignalR socket boundaries to guarantee end-to-end distributed trace continuity (`TraceId`, `SpanId`).
