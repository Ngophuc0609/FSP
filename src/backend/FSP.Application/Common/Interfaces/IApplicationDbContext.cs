using System.Threading;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Entities;

namespace FSP.Application.Common.Interfaces;

/// <summary>
/// Abstraction over EF Core DbContext to maintain clean architecture dependency rules.
/// </summary>
public interface IApplicationDbContext
{
    DbSet<WorkOrder> WorkOrders { get; }
    DbSet<Tenant> Tenants { get; }
    DbSet<WorkOrderAttachment> WorkOrderAttachments { get; }

    Task<int> SaveChangesAsync(CancellationToken cancellationToken = default);
}
