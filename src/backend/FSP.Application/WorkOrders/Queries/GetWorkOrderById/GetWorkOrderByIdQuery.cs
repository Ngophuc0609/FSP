using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Queries.GetWorkOrderById;

public record GetWorkOrderByIdQuery(Guid Id) : IRequest<Result<WorkOrderDetailsDto>>;

public class GetWorkOrderByIdQueryHandler : IRequestHandler<GetWorkOrderByIdQuery, Result<WorkOrderDetailsDto>>
{
    private readonly IApplicationDbContext _context;

    public GetWorkOrderByIdQueryHandler(IApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<Result<WorkOrderDetailsDto>> Handle(GetWorkOrderByIdQuery request, CancellationToken cancellationToken)
    {
        var dto = await _context.WorkOrders
            .AsNoTracking()
            .Where(w => w.Id == request.Id)
            .Select(w => new WorkOrderDetailsDto(
                w.Id,
                w.Title,
                w.Description,
                w.Status,
                w.Priority,
                w.AssignedTechnicianId,
                w.CreatedAtUtc,
                w.CreatedBy,
                w.LastModifiedAtUtc,
                w.LastModifiedBy,
                w.ClientReferenceId,
                w.RowVersion,
                w.Attachments.Select(a => new WorkOrderAttachmentDto(
                    a.Id,
                    a.FileName,
                    a.BlobUrl,
                    a.FileHashSha256,
                    a.FileSizeBytes,
                    a.CreatedAtUtc
                )).ToList()
            ))
            .FirstOrDefaultAsync(cancellationToken);

        if (dto == null)
            return Result<WorkOrderDetailsDto>.NotFound($"WorkOrder with ID {request.Id} not found.");

        return Result<WorkOrderDetailsDto>.Success(dto);
    }
}
