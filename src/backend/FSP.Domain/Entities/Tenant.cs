using System;
using FSP.Domain.Common;

namespace FSP.Domain.Entities;

public class Tenant : BaseTenantEntity
{
    public string Name { get; private set; } = string.Empty;
    public string Subdomain { get; private set; } = string.Empty;
    public bool IsActive { get; private set; }

    private Tenant() : base() { }

    public static Tenant Create(Guid tenantId, string name, string subdomain, Guid createdBy)
    {
        if (string.IsNullOrWhiteSpace(name))
            throw new ArgumentException("Tenant name cannot be empty.", nameof(name));
            
        return new Tenant
        {
            Id = tenantId,
            TenantId = tenantId,
            Name = name,
            Subdomain = subdomain,
            IsActive = true,
            CreatedAtUtc = DateTime.UtcNow,
            CreatedBy = createdBy
        };
    }
}
