---
title: Skill - Setup DevOps CI/CD Pipeline & Dockerfile
category: skill
version: 2.0.0
last_updated: 2026-07-15
---

# SKILL: SETUP DEVOPS PIPELINE (`Skill-Setup-DevOps-Pipeline`)

## 1. Purpose & Trigger
Use this skill when tasked with writing GitHub Actions workflows (`.github/workflows/`), Dockerfiles, or Azure Bicep / Terraform IaC scripts.

## 2. Execution Steps
1. **Verify Base Images:** Ensure Dockerfiles use official alpine runtime images (`mcr.microsoft.com/dotnet/aspnet:8.0-alpine`).
2. **Add Non-Root User:** Inject `adduser -u 5678 --disabled-password appuser` and switch `USER appuser`.
3. **Configure CI Steps:** Ensure GitHub Actions runs `dotnet test` with `/p:CollectCoverage=true` and checks coverage thresholds against Codecov/SonarCloud.
