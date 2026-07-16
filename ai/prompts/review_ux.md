---
id: review_ux
title: Prompt Wrapper - Review UI/UX & Field Ergonomics
tier: 4_prompt_wrappers
domain: design
target_agent: ai/domains/design/agents/ui_designer.md
version: 2.0.0
last_updated: 2026-07-15
---

# PROMPT WRAPPER: REVIEW UI/UX & FIELD ERGONOMICS

This prompt wrapper coordinates the Lead UI/UX & Design System Specialist persona to evaluate mobile screens, web dashboards, touch ergonomics, and accessibility (a11y).

---

## Execution Workflow (Mandatory Sequential Steps)

### Step 1: Load Universal Project DNA & Micro-Contexts
Read: `project_charter.md`, `universal_rules.md`, `product_context.md`, `flutter_context.md`.

### Step 2: Execute Target Agent Persona
Activate `ui_designer.md` to audit target screens or design specifications:
1. **Field Ergonomics Audit:** Verify touch targets are at least `48x48 logical pixels`, typography contrast ratios meet `WCAG 2.1 AA` (`>= 4.5:1`), and one-handed thumb reachability is maintained for technician mobile screens.
2. **Offline & Sync State Feedback:** Verify UI prominently displays offline status bars, dirty sync badges (`3 pending uploads`), and conflict resolution modals when connectivity drops.
3. **Design System Token Compliance:** Check that colors, padding, and typography explicitly reference centralized `ThemeData` / `Tailwind` tokens instead of hardcoded hex values (`#FF0000`) or pixel values.
4. **Accessibility Check:** Verify semantic screen reader labels (`Semantics` widget in Flutter / `aria-label` in React).

### Step 3: Output Final Artifact
Emit the UX/Ergonomic audit report and refactored UI code adhering to `ai/shared/output_format.md`.
