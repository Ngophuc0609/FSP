using System;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Domain.Entities;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Commands.AssignWorkOrder;

public record AssignWorkOrderCommand(
    Guid WorkOrderId,
    Guid TechnicianId,
    byte[] RowVersion
) : IRequest<Result<bool>>;

public class AssignWorkOrderCommandValidator : AbstractValidator<AssignWorkOrderCommand>
{
    public AssignWorkOrderCommandValidator()
    {
        RuleFor(v => v.WorkOrderId).NotEmpty().WithMessage("WorkOrderId is required.");
        RuleFor(v => v.TechnicianId).NotEmpty().WithMessage("TechnicianId is required.");
        RuleFor(v => v.RowVersion).NotEmpty().WithMessage("RowVersion concurrency token is required.");
    }
}

public class AssignWorkOrderCommandHandler : IRequestHandler<AssignWorkOrderCommand, Result<bool>>
{
    private readonly IApplicationDbContext _context;
    private readonly ICurrentUserProvider _currentUserProvider;

    public AssignWorkOrderCommandHandler(IApplicationDbContext context, ICurrentUserProvider currentUserProvider)
    {
        _context = context;
        _currentUserProvider = currentUserProvider;
    }

    public async Task<Result<bool>> Handle(AssignWorkOrderCommand request, CancellationToken cancellationToken)
    {
        var workOrder = await _context.WorkOrders
            .FirstOrDefaultAsync(w => w.Id == request.WorkOrderId, cancellationToken);

        if (workOrder == null)
            return Result<bool>.NotFound($"WorkOrder with ID {request.WorkOrderId} not found.");

        // Optimistic concurrency verification per DEC-WO-004
        if (workOrder.RowVersion != null && workOrder.RowVersion.Length > 0 && !workOrder.RowVersion.SequenceEqual(request.RowVersion))
        {
            return Result<bool>.Conflict("WorkOrder has been modified by another user. Please refresh and try again.");
        }

        var userId = _currentUserProvider.UserId;
        workOrder.AssignTechnician(request.TechnicianId, userId);

        try
        {
            await _context.SaveChangesAsync(cancellationToken);
        }
        catch (DbUpdateConcurrencyException)
        {
            return Result<bool>.Conflict("A concurrency conflict occurred while saving changes. Please refresh.");
        }

        return Result<bool>.Success(true);
    }
}
