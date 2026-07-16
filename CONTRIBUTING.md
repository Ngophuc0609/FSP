# CONTRIBUTING TO FIELD SERVICE PLATFORM (`CONTRIBUTING.md`)

Thank you for contributing to the **Field Service Platform (FSP)** enterprise repository. We welcome contributions from both **Human Engineers** and **AI Assistants** working in tandem. To maintain architectural purity, security, and multi-tenant isolation across our `.NET Core 8+` backend and `Flutter` mobile client, all contributors must adhere to the standards and workflows detailed in this document.

---

## 1. Governance & Single Source of Truth

Before contributing code, documentation, or architectural designs, review our mandatory governance guidelines:
- **Repository Structure:** Refer to `REPO_MAP.md` for our exact physical folder topology.
- **Supreme Constitution:** Refer to `ai/constitution/core_constitution.md` for immutable architectural invariants.
- **Code Ownership (`CODEOWNERS`):** Refer to `docs/governance/ownership_rules.md` and `ai/governance/codeowners_policy.md`.
- **Definition of Done (`DoD`):** Refer to `docs/governance/definition_of_done.md`.

---

## 2. Development Environment Setup

### Prerequisites
1. **.NET Core SDK (`8.0.x` or later)**: Required for building and testing `src/backend/FSP.sln`.
2. **Flutter SDK (`3.22.x stable channel`)**: Required for developing `src/flutter/`.
3. **Docker Desktop & Testcontainers**: Required for running ephemeral SQL Server and Redis integration tests (`Testcontainers.MsSql`).
4. **Git**: Configured with your SSH key and GPG signing enabled (recommended).

### Local Workspace Initialization
```bash
# 1. Clone the repository
git clone https://github.com/enterprise/FSP.git
cd FSP

# 2. Restore .NET Backend Dependencies
dotnet restore src/backend/FSP.sln
dotnet build src/backend/FSP.sln --no-restore

# 3. Restore Flutter Client Dependencies
cd src/flutter
flutter pub get
flutter analyze
```

---

## 3. Branching Strategy & Git Workflow (`Trunk-Based Development`)

We strictly follow **Trunk-Based Development** (`docs/governance/branch_strategy.md`):
- **`main`**: Production-ready branch. Protected by strict review gates (`GOV-REV-001`). Direct commits are **PROHIBITED**.
- **`develop`**: Integration staging branch for daily development.
- **Feature Branches**: Must branch off `develop` using the format `feature/<ticket-id>-<short-description>` (e.g., `feature/FSP-104-offline-sync-queue`).
- **Bugfix Branches**: Must branch off `develop` using the format `bugfix/<ticket-id>-<short-description>` (e.g., `bugfix/FSP-209-tenant-filter-leak`).
- **Hotfix Branches**: Must branch off `main` using the format `hotfix/vX.Y.Z-<short-description>`.

### Commit Message Conventions (`Conventional Commits`)
All commit messages must follow the Conventional Commits format (`type(scope): description`):
```text
feat(backend): implement MediatR command for assigning technician to work order
fix(flutter): resolve Drift SQLite deadlock during background sync
docs(architecture): add sequence diagram for offline delta synchronization
refactor(api): convert raw SQL queries to EF Core compiled queries with AsNoTracking
test(domain): add unit test coverage for WorkOrder priority escalation SLA
```

---

## 4. Coding Standards & Architectural Boundaries

### Backend (`.NET Core 8+ Clean Architecture`)
1. **`FSP.Domain`**: Must remain pure C#. Zero external NuGet dependencies (`Microsoft.EntityFrameworkCore` or `System.Text.Json` are strictly forbidden here).
2. **`FSP.Application`**: Use CQRS (`MediatR`) for all use cases. Every command must be validated via `FluentValidation`. All query handlers MUST execute `.AsNoTracking()`.
3. **Multi-Tenant Security**: Every entity must include `TenantId` (`Guid`) and be filtered automatically by `EF Core` global query filters (`ITenantProvider`).

### Mobile (`Flutter / Dart`)
1. **Feature-First Organization**: Place code under `src/flutter/lib/features/<feature_name>/` (`domain/`, `data/`, `presentation/`).
2. **Offline-First Synchronization**: All field actions (`WorkOrder` completion, `Inspection` checklist toggles) must persist immediately into local `Drift` SQLite tables before syncing to the cloud API.
3. **Ergonomics & Touch Targets**: Field technicians wear gloves. All buttons and interactive touch targets must be at least `48x48px`.

---

## 5. Testing & Quality Assurance (`AAA Pattern`)

Before submitting any Pull Request, you must execute and pass the automated test suites locally:

```bash
# Run Backend Unit & Containerized Integration Tests (Must pass 100% with >= 90% coverage)
dotnet test src/backend/FSP.sln --configuration Release /p:CollectCoverage=true

# Run Flutter Unit & Widget Tests (Must pass 100% with >= 80% coverage)
cd src/flutter
flutter test --coverage
```

### Mandatory `AAA` Pattern (`Arrange-Act-Assert`)
Every unit test across `.NET` and `Flutter` must clearly demarcate `AAA` sections:
```csharp
[Fact]
public async Task CompleteWorkOrder_WhenAllInspectionsPassed_ShouldMarkStatusCompleted()
{
    // Arrange
    var workOrder = WorkOrder.Create(Guid.NewGuid(), Guid.NewGuid(), "Maintenance", WorkOrderPriority.Normal);
    
    // Act
    var result = workOrder.Complete();

    // Assert
    result.IsSuccess.Should().BeTrue();
    workOrder.Status.Should().Be(WorkOrderStatus.Completed);
}
```

---

## 6. Pull Request & Code Review Process

When your feature or bugfix is ready:
1. Push your branch to GitHub and create a Pull Request against `develop`.
2. Fill out the mandatory PR template, linking the associated Jira/Linear ticket ID.
3. Automated CI checks (`.github/workflows/ci.yml`) will run build, linting, and regression tests.
4. An automated AI Code Review (`ai/workflows/pr_review.md` via `ai_reviewer.md`) will verify security, `TenantId` isolation, `.AsNoTracking()`, and zero `TODO`/`FIXME` comments.
5. Once CI and AI review pass, at least one domain **CODEOWNER** (`@chief-backend-lead` or `@flutter-mobile-lead`) must approve the PR before merging.

---

## 7. Pairing with FSP AI Agents

If you are a human engineer working inside this repository, you can leverage our built-in **AI Engineering Platform (AIOS v2.0.0)** to accelerate development:
- **Scaffold C# Backend Modules:** Ask your AI assistant to run `ai/workflows/create_feature.md` or invoke `ai/prompts/generate_backend_module.md`.
- **Scaffold Flutter Screens:** Invoke `ai/prompts/generate_flutter_feature.md`.
- **Review Architecture / Security:** Invoke `ai/prompts/review_security.md` or `ai/prompts/review_performance.md`.
- **Understand AI Rules:** Read `AI_ONBOARDING.md` to see how our agents navigate and protect repository boundaries.
