using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using FSP.Domain.Entities;

namespace FSP.Infrastructure.Persistence.Configurations;

public class WorkOrderConfiguration : IEntityTypeConfiguration<WorkOrder>
{
    public void Configure(EntityTypeBuilder<WorkOrder> builder)
    {
        builder.ToTable("WorkOrders");

        builder.HasKey(w => w.Id);

        builder.Property(w => w.Id)
            .ValueGeneratedOnAdd()
            .HasValueGenerator<SequentialGuidValueGenerator>();

        // DEC-WO-003: Keyset Index on (TenantId, Status, CreatedAtUtc DESC) for O(log N) pagination seeks
        builder.HasIndex(w => new { w.TenantId, w.Status, w.CreatedAtUtc })
            .IsDescending(false, false, true);

        // Index on AssignedTechnicianId for fast technician workload lookups
        builder.HasIndex(w => new { w.TenantId, w.AssignedTechnicianId });

        // Idempotency deduplication index per DEC-WO-002
        builder.HasIndex(w => new { w.TenantId, w.ClientReferenceId }).IsUnique();

        builder.Property(w => w.Title)
            .IsRequired()
            .HasMaxLength(200);

        builder.Property(w => w.Description)
            .IsRequired()
            .HasMaxLength(2000);

        builder.Property(w => w.Status)
            .IsRequired();

        builder.Property(w => w.Priority)
            .IsRequired();

        // DEC-WO-004: RowVersion optimistic concurrency control
        builder.Property(w => w.RowVersion)
            .IsRowVersion()
            .IsRequired();

        builder.HasMany(w => w.Attachments)
            .WithOne()
            .HasForeignKey(a => a.WorkOrderId)
            .OnDelete(DeleteBehavior.Cascade);
    }
}
