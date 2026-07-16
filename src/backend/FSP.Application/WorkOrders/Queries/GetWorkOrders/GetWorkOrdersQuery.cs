using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Domain.Entities;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Queries.GetWorkOrders;

public record GetWorkOrdersQuery(
    WorkOrderStatus? StatusFilter = null,
    DateTime? CursorCreatedAt = null,
    Guid? CursorId = null,
    int PageSize = 20
) : IRequest<Result<KeysetPaginationResult<WorkOrderSummaryDto>>>;

public class GetWorkOrdersQueryHandler : IRequestHandler<GetWorkOrdersQuery, Result<KeysetPaginationResult<WorkOrderSummaryDto>>>
{
    private readonly IApplicationDbContext _context;

    public GetWorkOrdersQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<KeysetPaginationResult<WorkOrderSummaryDto>>> Handle(GetWorkOrdersQuery request, CancellationToken cancellationToken)
    {
        var pageSize = Math.Clamp(request.PageSize, 1, 100);
        
        // Enforce RULE-BACKEND-003: Mandatory AsNoTracking on read-only queries
        var query = _context.WorkOrders.AsNoTracking();

        if (request.StatusFilter.HasValue)
        {
            query = query.Where(w => w.Status == request.StatusFilter.Value);
        }

        // Keyset pagination index seek condition per DEC-WO-003: (CreatedAtUtc DESC, Id DESC)
        if (request.CursorCreatedAt.HasValue && request.CursorId.HasValue)
        {
            var cursorDate = request.CursorCreatedAt.Value;
            var cursorId = request.CursorId.Value;

            query = query.Where(w => w.CreatedAtUtc < cursorDate || 
                                    (w.CreatedAtUtc == cursorDate && w.Id.CompareTo(cursorId) < 0));
        }

        var items = await query
            .OrderByDescending(w => w.CreatedAtUtc)
            .ThenByDescending(w => w.Id)
            .Take(pageSize + 1)
            .Select(w => new WorkOrderSummaryDto(
                w.Id,
                w.Title,
                w.Description,
                w.Status,
                w.Priority,
                w.AssignedTechnicianId,
                w.CreatedAtUtc,
                w.ClientReferenceId,
                w.RowVersion
            ))
            .ToListAsync(cancellationToken);

        var hasMore = items.Count > pageSize;
        if (hasMore)
        {
            items.RemoveAt(items.Count - 1);
        }

        DateTime? nextCursorCreatedAt = hasMore && items.Count > 0 ? items[items.Count - 1].CreatedAtUtc : null;
        Guid? nextCursorId = hasMore && items.Count > 0 ? items[items.Count - 1].Id : null;

        var result = new KeysetPaginationResult<WorkOrderSummaryDto>(items, nextCursorCreatedAt, nextCursorId, hasMore);
        return Result<KeysetPaginationResult<WorkOrderSummaryDto>>.Success(result);
    }
}
