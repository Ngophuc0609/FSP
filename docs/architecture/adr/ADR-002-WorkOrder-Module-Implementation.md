---
adr_id: ADR-002
title: Work Order Management Module Technical Design (Phase 1 Implementation)
status: APPROVED (by Integrator/Arbiter Agent)
date: 2026-07-16
author: Primary Designer, Skeptic, Constraint Guardian, User Advocate, Arbiter
domain: backend, flutter, database, architecture
---

# ADR-002: Work Order Management Module Technical Design

## 1. Executive Summary & Purpose
This Architecture Decision Record (ADR) defines the end-to-end technical implementation blueprints for the **Work Order Management Module** across the FSP enterprise platform during Phase 1. It establishes:
1. CQRS MediatR Handlers (`FSP.Application`) with validation and result monads.
2. EF Core `DbContext`, Entity Configurations, Global Query Filters, and migrations (`FSP.Infrastructure`).
3. Flutter offline-first Riverpod providers, Drift SQLite local repository, and ergonomic screens (`src/flutter/lib/features/work_orders/`).

---

## 2. Technical Architecture Blueprints

### A. CQRS MediatR Handlers (`src/backend/FSP.Application/WorkOrders/`)
We enforce explicit separation of Commands (mutations) and Queries (pure reads):

#### 1. Commands
- **`CreateWorkOrderCommand`**:
  - Properties: `string Title`, `string Description`, `WorkOrderPriority Priority`, `Guid ClientReferenceId` (idempotency key).
  - Handler: Uses static factory `WorkOrder.Create(...)`, saves via `IApplicationDbContext`, raises `WorkOrderCreatedDomainEvent`.
  - Validator (`FluentValidation`): Enforces `Title` maximum length 200, mandatory non-empty description.
- **`AssignWorkOrderCommand`**:
  - Properties: `Guid WorkOrderId`, `Guid TechnicianId`, `byte[] RowVersion` (concurrency token).
  - Handler: Verifies technician active status, checks row-level concurrency, calls `workOrder.AssignTechnician(...)`, saves changes.

#### 2. Queries (No-Tracking Mandatory per `RULE-BACKEND-003`)
- **`GetWorkOrdersQuery`**:
  - Properties: `WorkOrderStatus? StatusFilter`, `DateTime? CursorCreatedAt`, `Guid? CursorId`, `int PageSize = 20`.
  - Handler: Executes EF Core `.AsNoTracking()` cursor/keyset pagination projections to `WorkOrderSummaryDto` (guaranteeing `O(log N)` seeks).
- **`GetWorkOrderByIdQuery`**:
  - Properties: `Guid Id`.
  - Handler: Executes `.AsNoTracking().FirstOrDefaultAsync(w => w.Id == request.Id)` mapping to `WorkOrderDetailsDto`.

---

### B. EF Core Persistence & Multi-Tenancy (`src/backend/FSP.Infrastructure/Persistence/`)

#### 1. `FspDbContext` & Global Query Filters
```csharp
public class FspDbContext : DbContext, IApplicationDbContext
{
    private readonly ITenantProvider _tenantProvider;
    public DbSet<WorkOrder> WorkOrders => Set<WorkOrder>();
    public DbSet<Tenant> Tenants => Set<Tenant>();

    public FspDbContext(DbContextOptions<FspDbContext> options, ITenantProvider tenantProvider)
        : base(options)
    {
        _tenantProvider = tenantProvider;
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(typeof(FspDbContext).Assembly);

        // Enforce RULE-DB-001: Global Tenant Isolation Filter across all BaseTenantEntity classes
        modelBuilder.Entity<WorkOrder>().HasQueryFilter(w => w.TenantId == _tenantProvider.TenantId);
        modelBuilder.Entity<Tenant>().HasQueryFilter(t => t.Id == _tenantProvider.TenantId);
    }
}
```

#### 2. `WorkOrderConfiguration` (`IEntityTypeConfiguration<WorkOrder>`)
- Table Name: `"WorkOrders"`.
- Indexes: Composite Keyset Index on `(TenantId, Status, CreatedAtUtc DESC)` and `(TenantId, AssignedTechnicianId)` for rapid filtering without page scans.
- Key Strategy: `SequentialGuidValueGenerator` (`COMB` GUIDs) to eliminate index fragmentation (`page splits`).
- Concurrency Token: `builder.Property(w => w.RowVersion).IsRowVersion();`.
- Column Constraints: `Title` (`NVARCHAR(200)`, `NOT NULL`), `Description` (`NVARCHAR(2000)`, `NOT NULL`), `Status` (`INT`, `NOT NULL`), audit columns (`datetime2(7)`).

---

### C. Flutter Offline-First Presentation (`src/flutter/lib/features/work_orders/`)

#### 1. Repository Architecture (`IWorkOrderRepository`)
- **Local Data Source (`Drift`)**: Acts as the single source of truth for the UI (`watchWorkOrders()`).
- **Remote Data Source (`Dio`)**: Fetches updates from ASP.NET Core API and upserts into local Drift SQLite.
- **Optimistic Mutations**: When `createWorkOrder()` or `assignWorkOrder()` is called on mobile, it immediately inserts a local Drift record with `SyncStatus.pending` and enqueues a background sync task using `ClientReferenceId` for deduplication.

#### 2. Riverpod State Providers
- **`workOrderListNotifierProvider`**: `AsyncNotifierProvider<WorkOrderListNotifier, List<WorkOrderModel>>`. Listens to `Drift` local database stream and triggers background synchronization on init or refresh.

#### 3. Ergonomic UI Screens (`RULE-FLUTTER-003` & `RULE-UI-001`)
- **`WorkOrderListScreen`**: Displays top connectivity & sync bar (`Online`, `Offline - 3 pending`, `Sync Error`), priority badges, and high-contrast filter chips.
- **`WorkOrderCreateScreen` & `WorkOrderDetailScreen`**: Form inputs with minimum `48x48 logical pixels` touch targets for field gloves. Large photo attachments are decoupled via chunked Azure Blob pre-signed URLs (`WorkOrderAttachments` table).

---

## 3. Multi-Agent Brainstorming Decision Log & Arbitration

| Decision ID | Decision Topic | Initial Proposal (Primary Designer) | Reviewer Objections Raised (Skeptic / Constraint / User) | Final Resolution & Arbitration Rationale |
| :--- | :--- | :--- | :--- | :--- |
| `DEC-WO-001` | **Result Handling in CQRS** | Use lightweight custom `Result<T>` monad inside MediatR pipelines. | **Constraint Guardian:** Must integrate cleanly with ASP.NET Core `ProblemDetails` (`RFC 7807`) when returned from API controllers. | **ACCEPTED & LOCKED:** `Result<T>` monad will map directly to `ProblemDetails` (`ValidationProblem`, `ConflictProblem`, `NotFoundProblem`) in API action filters. |
| `DEC-WO-002` | **EF Core Key Generation & Indexing** | Use `Guid.NewGuid()` for `Id` and `TenantId` across all entities to support offline generation on mobile devices. | **Skeptic (`OBJ-SKEP-001`):** Random v4 GUIDs cause severe SQL Server clustered index fragmentation (`page splits`) under heavy field insert volume. | **ACCEPTED & REVISED:** Use `COMB` / Sequential GUIDs (`SequentialGuidValueGenerator` / `Guid.CreateVersion7()`) on SQL Server primary keys. Mobile devices generate `ClientReferenceId` (`Guid` v4) for deduplication during offline sync. |
| `DEC-WO-003` | **Pagination Strategy** | Offset-based pagination (`PageNumber`, `PageSize`) for `GetWorkOrdersQuery`. | **Constraint Guardian (`OBJ-CONS-001`):** `OFFSET/FETCH` degrades quadratically on large datasets. | **ACCEPTED & REVISED:** Enforce **Keyset / Cursor-Based Pagination** (`CursorCreatedAt`, `CursorId`) matching composite index `(TenantId, Status, CreatedAtUtc DESC)`. |
| `DEC-WO-004` | **Offline Sync & Concurrency Control** | Last-Write-Wins (LWW) based on raw device timestamps (`LastModifiedAtUtc`). | **Skeptic (`OBJ-SKEP-002`):** Client clock drift and race conditions overwrite critical status transitions or field inspection notes. | **ACCEPTED & REVISED:** Enforce **RowVersion Concurrency Token** (`IsRowVersion()`) + **State Machine Validation** (`CanTransitionTo()`). If server returns `409 Conflict`, mobile triggers conflict resolution queue. |
| `DEC-WO-005` | **Large Attachment Handling** | Include inspection photos directly in `CreateWorkOrderCommand` JSON payloads. | **Constraint Guardian (`OBJ-CONS-002`):** 10MB+ photos over unstable 3G/LTE cellular connections cause API timeouts and local database bloat. | **ACCEPTED & REVISED:** Decouple binary attachments. `CreateWorkOrderCommand` sends metadata only. Photos/Signatures use **Pre-Signed Azure Blob Storage URLs** with background chunked transfer (`WorkOrderAttachments` table). |
| `DEC-WO-006` | **Offline Visibility & Error Microcopy** | Standard loading spinner or generic error toast on network failure. | **User Advocate (`OBJ-USER-001`):** Technicians in dead zones must never feel stuck or confused about whether local data is synced or stale. | **ACCEPTED & REVISED:** Add permanent **Top Sync Status Bar** (`Online - Synced just now`, `Offline - X pending`, `Sync Error - Tap to resolve`) and field-tested human microcopy on every screen per `RULE-FLUTTER-003`. |

