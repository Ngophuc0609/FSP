---
title: Semantic Versioning Strategy (SemVer 2.0.0)
category: governance
version: 2.0.0
last_updated: 2026-07-15
---

# SEMANTIC VERSIONING STRATEGY (`SemVer 2.0.0`)

## Version Format: `MAJOR.MINOR.PATCH` (`vX.Y.Z`)
- **MAJOR (`v2.0.0`):** Incremented when introducing breaking API changes, major architectural shifts (e.g., transitioning to MediatR CQRS), or non-backward-compatible database schema drops.
- **MINOR (`v2.1.0`):** Incremented when adding new backward-compatible functional features (e.g., adding a new `Inspection` checklist module or asset QR scanner).
- **PATCH (`v2.1.1`):** Incremented when shipping backward-compatible bug fixes, security patches, or performance optimizations (`AsNoTracking` fixes).
