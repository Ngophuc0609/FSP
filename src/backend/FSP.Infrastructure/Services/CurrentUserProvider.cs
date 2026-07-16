using System;
using Microsoft.AspNetCore.Http;
using FSP.Application.Common.Interfaces;

namespace FSP.Infrastructure.Services;

public class CurrentUserProvider : ICurrentUserProvider
{
    private readonly IHttpContextAccessor _httpContextAccessor;
    public static readonly Guid DefaultUserId = Guid.Parse("22222222-2222-2222-2222-222222222222");

    public CurrentUserProvider(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    public Guid UserId
    {
        get
        {
            var context = _httpContextAccessor.HttpContext;
            if (context == null) return DefaultUserId;

            var claim = context.User?.FindFirst("sub") ?? context.User?.FindFirst("user_id");
            if (claim != null && Guid.TryParse(claim.Value, out var userId))
            {
                return userId;
            }

            return DefaultUserId;
        }
    }
}
