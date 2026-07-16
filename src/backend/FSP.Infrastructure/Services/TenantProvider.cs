using System;
using Microsoft.AspNetCore.Http;
using FSP.Application.Common.Interfaces;

namespace FSP.Infrastructure.Services;

public class TenantProvider : ITenantProvider
{
    private readonly IHttpContextAccessor _httpContextAccessor;
    
    // Default tenant for CLI / Migrations / Seed
    public static readonly Guid DefaultTenantId = Guid.Parse("11111111-1111-1111-1111-111111111111");

    public TenantProvider(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public Guid TenantId
    {
        get
        {
            var context = _httpContextAccessor.HttpContext;
            if (context == null) return DefaultTenantId;

            if (context.Request.Headers.TryGetValue("X-Tenant-Id", out var headerValue) &&
                Guid.TryParse(headerValue, out var tenantId))
            {
                return tenantId;
            }

            var claim = context.User?.FindFirst("tenant_id");
            if (claim != null && Guid.TryParse(claim.Value, out var claimTenantId))
            {
                return claimTenantId;
            }

            return DefaultTenantId;
        }
    }
}
