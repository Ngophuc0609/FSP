using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Metadata.Builders;
using Microsoft.EntityFrameworkCore.ValueGeneration;
using FSP.Domain.Entities;

namespace FSP.Infrastructure.Persistence.Configurations;

public class TenantConfiguration : IEntityTypeConfiguration<Tenant>
{
    public void Configure(EntityTypeBuilder<Tenant> builder)
    {
        builder.ToTable("Tenants");

        builder.HasKey(t => t.Id);

        builder.Property(t => t.Id)
            .ValueGeneratedOnAdd()
            .HasValueGenerator<SequentialGuidValueGenerator>();

        builder.HasIndex(t => t.Subdomain).IsUnique();

        builder.Property(t => t.Name)
            .IsRequired()
            .HasMaxLength(100);

        builder.Property(t => t.Subdomain)
            .IsRequired()
            .HasMaxLength(50);
    }
}
