---
title: End-to-End (E2E) Journey Testing Specifications
category: testing
version: 2.0.0
last_updated: 2026-07-15
---

# END-TO-END (E2E) JOURNEY TESTING

## 1. Web Portal E2E Automation (`Playwright`)
E2E testing for the Service Dispatcher portal is executed via `Playwright` in headless Chromium/WebKit. Critical journey required:
1. Dispatcher logs into web command center (`/login`).
2. Dispatcher filters `WorkOrders` by `Critical` priority.
3. Dispatcher drags and drops a job onto an available `Technician` slot.
4. System verifies instant SignalR socket confirmation toast.

---

## 2. Mobile App E2E Automation (`Appium / Integration Test`)
Mobile client testing verifies the offline synchronization journey:
1. Turn device Wi-Fi off (simulate offline zone).
2. Open assigned `WorkOrder`, complete checklist items, and sign signature canvas.
3. Turn device Wi-Fi back on.
4. Verify background sync worker pushes items and status changes to `Completed` on server.
