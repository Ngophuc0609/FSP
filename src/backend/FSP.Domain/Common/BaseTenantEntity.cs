using System;
using System.Collections.Generic;

namespace FSP.Domain.Common;

/// <summary>
/// Base class for all multi-tenant entities in FSP.
/// Enforces TenantId isolation, mandatory audit columns, and pure domain events per RULE-DB-001 / RULE-DB-003.
/// </summary>
public abstract class BaseTenantEntity
{
    private readonly List<IDomainEvent> _domainEvents = new();

    public Guid Id { get; protected set; } = CombGuid.NewGuid();
    public Guid TenantId { get; protected set; }
    
    public DateTime CreatedAtUtc { get; protected set; } = DateTime.UtcNow;
    public Guid CreatedBy { get; protected set; }
    
    public DateTime? LastModifiedAtUtc { get; protected set; }
    public Guid? LastModifiedBy { get; protected set; }

    public IReadOnlyCollection<IDomainEvent> DomainEvents => _domainEvents.AsReadOnly();

    protected BaseTenantEntity(Guid tenantId, Guid createdBy)
    {
        if (tenantId == Guid.Empty)
            throw new ArgumentException("TenantId must not be empty.", nameof(tenantId));
            
        TenantId = tenantId;
        CreatedBy = createdBy;
        CreatedAtUtc = DateTime.UtcNow;
    }

    protected BaseTenantEntity() { } // Required for EF Core reflection

    public void AddDomainEvent(IDomainEvent domainEvent)
    {
        _domainEvents.Add(domainEvent);
    }

    public void ClearDomainEvents()
    {
        _domainEvents.Clear();
    }
}
