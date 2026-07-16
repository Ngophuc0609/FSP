---
title: UI/UX Design System & Ergonomics Rules
category: rule
version: 2.0.0
last_updated: 2026-07-15
---

# UI/UX DESIGN SYSTEM RULES (`RULE-UI-001` to `003`)

## RULE-UI-001: High-Contrast & Field Ergonomics
Mobile screens for field technicians must maintain `WCAG 2.1 AA` contrast ratios (`>= 4.5:1`) and provide clear visual status badges for offline vs. online connectivity states.

## RULE-UI-002: Standard Design Token Enforcement
All padding, spacing, and colors across Flutter (`lib/core/theme/`) and Web (`index.css`) must reference centralized design tokens (`AppColors.primary`, `AppSpacing.md = 16.0`) instead of hardcoded hex codes or numeric margins.
