using System;

namespace FSP.Application.Common.Interfaces;

/// <summary>
/// Resolves the authenticated user ID for audit logging per RULE-DB-003.
/// </summary>
public interface ICurrentUserProvider
{
    Guid UserId { get; }
}
