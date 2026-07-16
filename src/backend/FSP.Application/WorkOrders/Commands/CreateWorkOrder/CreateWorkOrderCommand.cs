using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Domain.Entities;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Commands.CreateWorkOrder;

public record CreateWorkOrderCommand(
    string Title,
    string Description,
    WorkOrderPriority Priority,
    Guid ClientReferenceId
) : IRequest<Result<Guid>>;

public class CreateWorkOrderCommandValidator : AbstractValidator<CreateWorkOrderCommand>
{
    public CreateWorkOrderCommandValidator()
    {
        RuleFor(v => v.Title)
            .NotEmpty().WithMessage("Title is required.")
            .MaximumLength(200).WithMessage("Title must not exceed 200 characters.");

        RuleFor(v => v.Description)
            .NotEmpty().WithMessage("Description is required.")
            .MaximumLength(2000).WithMessage("Description must not exceed 2000 characters.");

        RuleFor(v => v.Priority)
            .IsInEnum().WithMessage("Invalid priority specified.");
    }
}

public class CreateWorkOrderCommandHandler : IRequestHandler<CreateWorkOrderCommand, Result<Guid>>
{
    private readonly IApplicationDbContext _context;
    private readonly ITenantProvider _tenantProvider;
    private readonly ICurrentUserProvider _currentUserProvider;

    public CreateWorkOrderCommandHandler(
        IApplicationDbContext context,
        ITenantProvider tenantProvider,
        ICurrentUserProvider currentUserProvider)
    {
        _context = context;
        _tenantProvider = tenantProvider;
        _currentUserProvider = currentUserProvider;
    }

    public async Task<Result<Guid>> Handle(CreateWorkOrderCommand request, CancellationToken cancellationToken)
    {
        // Check for idempotency deduplication per DEC-WO-002
        if (request.ClientReferenceId != Guid.Empty)
        {
            var existingId = await _context.WorkOrders
                .Where(w => w.ClientReferenceId == request.ClientReferenceId)
                .Select(w => w.Id)
                .FirstOrDefaultAsync(cancellationToken);

            if (existingId != Guid.Empty)
            {
                return Result<Guid>.Success(existingId);
            }
        }

        var tenantId = _tenantProvider.TenantId;
        var userId = _currentUserProvider.UserId;

        var workOrder = WorkOrder.Create(
            tenantId,
            request.Title,
            request.Description,
            request.Priority,
            request.ClientReferenceId,
            userId);

        _context.WorkOrders.Add(workOrder);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Guid>.Success(workOrder.Id);
    }
}
