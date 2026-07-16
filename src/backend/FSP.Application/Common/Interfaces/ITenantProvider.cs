using System;

namespace FSP.Application.Common.Interfaces;

/// <summary>
/// Provides the current active TenantId resolved from HTTP Header / JWT Claim per RULE-BACKEND-001 / RULE-DB-001.
/// </summary>
public interface ITenantProvider
{
    Guid TenantId { get; }
}
