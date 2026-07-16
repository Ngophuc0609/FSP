---
id: release_version
title: Multi-Agent Workflow - Release Version & Deployment Verification
tier: 5_workflows
version: 2.0.0
last_updated: 2026-07-15
description: Coordinates DevOps, QA, and Release Manager Personas to cut release branches, run smoke tests, and deploy to staging/prod.
---

# MULTI-AGENT WORKFLOW: RELEASE VERSION & DEPLOYMENT

This workflow coordinates DevOps/SRE, QA Lead, and Product Manager to safely build, tag, verify, and deploy new versions of `FSP`.

---

## Workflow DAG Execution Chain

```mermaid
graph TD
    A[Step 1: DevOps Engineer<br/>Generate Changelog & Tag Release] --> B[Step 2: QA Lead<br/>Execute E2E Regression & Smoke Test]
    B --> C{Gate 1: E2E & Smoke Pass 100%?}
    C -- Fail --> D[Abrogate Release & Rollback]
    C -- Pass --> E[Step 3: DevOps Engineer<br/>Execute Blue-Green Deployment]
    E --> F{Gate 2: Post-Deploy Telemetry Health Check}
    F -- Pass --> G([Release Successful])
    F -- Fail --> D
```

---

## Detailed Step & Gate Instructions

### Step 1: Release Tagging & Changelog (`DevOps Engineer`)
- **Action:** Activate `devops_engineer.md`. Compile git history into `docs/api/changelog.md` and bump Semantic Versioning (`vX.Y.Z`).

### Step 2: E2E Verification (`QA Automation Lead`)
- **Action:** Activate `qa_engineer.md`. Run automated Playwright/Appium suites against staging.
- **Gate 1:** 100% passing rate across all critical user journeys.

### Step 3: Production Deployment & Telemetry Verification (`SRE`)
- **Action:** Execute Blue-Green or Canary deployment via GitHub Actions (`docs/devops/github_actions.md`).
- **Gate 2:** Monitor Application Insights for 15 minutes; zero 5xx spike or memory leak allowed.
