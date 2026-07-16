using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using FSP.Application.Common.Interfaces;
using FSP.Infrastructure.Persistence;
using FSP.Infrastructure.Services;

namespace FSP.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructureServices(this IServiceCollection services, IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("DefaultConnection") 
            ?? "Server=(localdb)\\mssqllocaldb;Database=FspDatabase;Trusted_Connection=True;MultipleActiveResultSets=true";

        services.AddDbContext<FspDbContext>(options =>
            options.UseSqlServer(connectionString));

        services.AddScoped<IApplicationDbContext>(provider => provider.GetRequiredService<FspDbContext>());

        services.AddHttpContextAccessor();
        services.AddScoped<ITenantProvider, TenantProvider>();
        services.AddScoped<ICurrentUserProvider, CurrentUserProvider>();
        services.AddScoped<IBlobStorageService, AzureBlobStorageService>();

        return services;
    }
}
