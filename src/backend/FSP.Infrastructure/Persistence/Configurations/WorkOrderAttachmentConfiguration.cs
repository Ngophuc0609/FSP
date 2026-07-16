using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using FSP.Domain.Entities;

namespace FSP.Infrastructure.Persistence.Configurations;

public class WorkOrderAttachmentConfiguration : IEntityTypeConfiguration<WorkOrderAttachment>
{
    public void Configure(EntityTypeBuilder<WorkOrderAttachment> builder)
    {
        builder.ToTable("WorkOrderAttachments");

        builder.HasKey(a => a.Id);

        builder.Property(a => a.Id)
            .ValueGeneratedOnAdd()
            .HasValueGenerator<SequentialGuidValueGenerator>();

        builder.HasIndex(a => new { a.TenantId, a.WorkOrderId });

        builder.Property(a => a.FileName)
            .IsRequired()
            .HasMaxLength(255);

        builder.Property(a => a.BlobUrl)
            .IsRequired()
            .HasMaxLength(1024);

        builder.Property(a => a.FileHashSha256)
            .IsRequired()
            .HasMaxLength(64);
    }
}
