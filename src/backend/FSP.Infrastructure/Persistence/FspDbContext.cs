using System.Linq;
using System.Reflection;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Domain.Entities;
using FSP.Application.Common.Interfaces;

namespace FSP.Infrastructure.Persistence;

public class FspDbContext : DbContext, IApplicationDbContext
{
    private readonly ITenantProvider _tenantProvider;
    private readonly IPublisher _publisher;

    public DbSet<WorkOrder> WorkOrders => Set<WorkOrder>();
    public DbSet<Tenant> Tenants => Set<Tenant>();
    public DbSet<WorkOrderAttachment> WorkOrderAttachments => Set<WorkOrderAttachment>();
    public DbSet<SlaPolicy> SlaPolicies => Set<SlaPolicy>();

    public FspDbContext(
        DbContextOptions<FspDbContext> options, 
        ITenantProvider tenantProvider,
        IPublisher publisher) : base(options)
    {
        _tenantProvider = tenantProvider;
        _publisher = publisher;
    }

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        modelBuilder.ApplyConfigurationsFromAssembly(Assembly.GetExecutingAssembly());

        // Enforce RULE-DB-001: Global Tenant Isolation Query Filters per ADR-002
        modelBuilder.Entity<WorkOrder>().HasQueryFilter(w => w.TenantId == _tenantProvider.TenantId);
        modelBuilder.Entity<WorkOrderAttachment>().HasQueryFilter(a => a.TenantId == _tenantProvider.TenantId);
        modelBuilder.Entity<Tenant>().HasQueryFilter(t => t.Id == _tenantProvider.TenantId);
        modelBuilder.Entity<SlaPolicy>().HasQueryFilter(s => s.TenantId == _tenantProvider.TenantId);
    }

    public override async Task<int> SaveChangesAsync(CancellationToken cancellationToken = default)
    {
        // Dispatch domain events before saving or right after inside transaction
        var entitiesWithEvents = ChangeTracker.Entries<BaseTenantEntity>()
            .Select(e => e.Entity)
            .Where(e => e.DomainEvents.Any())
            .ToArray();

        var domainEvents = entitiesWithEvents
            .SelectMany(e => e.DomainEvents)
            .ToArray();

        foreach (var entity in entitiesWithEvents)
        {
            entity.ClearDomainEvents();
        }

        foreach (var domainEvent in domainEvents)
        {
            await _publisher.Publish(domainEvent, cancellationToken);
        }

        return await base.SaveChangesAsync(cancellationToken);
    }
}
