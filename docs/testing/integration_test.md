---
title: Containerized Integration Testing with Testcontainers
category: testing
version: 2.0.0
last_updated: 2026-07-15
---

# CONTAINERIZED INTEGRATION TESTING (`Testcontainers`)

## 1. Why Testcontainers over In-Memory Database?
EF Core's `UseInMemoryDatabase()` provider lacks support for raw SQL, relational constraints, foreign keys, and multi-tenant global query filters. Therefore, `FSP` enforces **Testcontainers for .NET (`Testcontainers.MsSql`)** to spin up ephemeral, production-equivalent Docker SQL Server instances during integration test execution.

---

## 2. Multi-Tenant Integration Test Pattern
Integration tests MUST verify that `TenantId` global query filters prevent data cross-contamination:
```csharp
[Fact]
public async Task GetWorkOrders_WhenTenantFilterActive_ShouldOnlyReturnCurrentTenantData()
{
    // Arrange
    var tenantA = Guid.NewGuid();
    var tenantB = Guid.NewGuid();
    
    // Seed Work Orders for both tenants inside ephemeral container DB...
    
    // Act: Query using scoped ITenantProvider set to tenantA
    _tenantProviderMock.TenantId.Returns(tenantA);
    var results = await _mediator.Send(new GetWorkOrdersQuery());

    // Assert: Only tenantA records returned, zero leakage of tenantB
    results.Value.Should().AllSatisfy(wo => wo.TenantId.Should().Be(tenantA));
}
```
