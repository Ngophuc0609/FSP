---
standard_id: STD-GIT-001
title: Git & Branching Standard
version: 1.0.0
owner: Principal DevOps Lead
scope: All git operations, commit messages, and pull request workflows
rules_referencing: [RULE-GIT-001]
---

# Git & Branching Standard

## 1. Branching Strategy (Trunk-Based / Feature Branches)
- `main`: Protected production-ready branch. Direct pushes prohibited.
- `develop`: Protected integration branch.
- `feature/<ticket-id>-<short-description>`: Feature work (e.g., `feature/FSP-102-assign-technician`).
- `bugfix/<ticket-id>-<short-description>`: Bug fixes.
- `hotfix/<ticket-id>-<short-description>`: Emergency production fixes.

## 2. Commit Message Standard (Conventional Commits)
Format: `<type>(<scope>): <short summary>`
- Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `perf`
- Example: `feat(work-order): add offline status transition support`
