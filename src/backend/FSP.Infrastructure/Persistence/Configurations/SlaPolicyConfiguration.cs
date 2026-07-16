using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using FSP.Domain.Entities;

namespace FSP.Infrastructure.Persistence.Configurations;

public class SlaPolicyConfiguration : IEntityTypeConfiguration<SlaPolicy>
{
    public void Configure(EntityTypeBuilder<SlaPolicy> builder)
    {
        builder.ToTable("SlaPolicies");

        builder.HasKey(s => s.Id);

        builder.Property(s => s.Id)
            .ValueGeneratedOnAdd()
            .HasValueGenerator<SequentialGuidValueGenerator>();

        builder.Property(s => s.Name)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(s => s.TargetResponseMinutes)
            .IsRequired();

        builder.Property(s => s.TargetResolutionMinutes)
            .IsRequired();

        builder.Property(s => s.CalendarId)
            .HasMaxLength(50);

        builder.HasIndex(s => new { s.TenantId, s.Name }).IsUnique();
    }
}
