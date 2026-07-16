using System;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Domain.Entities;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Commands.ConfirmAttachmentUpload;

public record ConfirmAttachmentUploadCommand(
    Guid WorkOrderId,
    string FileName,
    string BlobUrl,
    string FileHashSha256,
    long FileSizeBytes
) : IRequest<Result<Guid>>;

public class ConfirmAttachmentUploadCommandValidator : AbstractValidator<ConfirmAttachmentUploadCommand>
{
    public ConfirmAttachmentUploadCommandValidator()
    {
        RuleFor(v => v.WorkOrderId)
            .NotEmpty().WithMessage("WorkOrder ID is required.");

        RuleFor(v => v.FileName)
            .NotEmpty().WithMessage("File name is required.");

        RuleFor(v => v.BlobUrl)
            .NotEmpty().WithMessage("Blob URL is required.");

        RuleFor(v => v.FileHashSha256)
            .NotEmpty().WithMessage("SHA256 file hash is required.");

        RuleFor(v => v.FileSizeBytes)
            .GreaterThan(0).WithMessage("File size must be greater than zero.");
    }
}

public class ConfirmAttachmentUploadCommandHandler : IRequestHandler<ConfirmAttachmentUploadCommand, Result<Guid>>
{
    private readonly IApplicationDbContext _context;
    private readonly ITenantProvider _tenantProvider;
    private readonly ICurrentUserProvider _currentUserProvider;

    public ConfirmAttachmentUploadCommandHandler(
        IApplicationDbContext context,
        ITenantProvider tenantProvider,
        ICurrentUserProvider currentUserProvider)
    {
        _context = context;
        _tenantProvider = tenantProvider;
        _currentUserProvider = currentUserProvider;
    }

    public async Task<Result<Guid>> Handle(ConfirmAttachmentUploadCommand request, CancellationToken cancellationToken)
    {
        var tenantId = _tenantProvider.TenantId;
        var userId = _currentUserProvider.UserId;

        var workOrder = await _context.WorkOrders
            .FirstOrDefaultAsync(w => w.Id == request.WorkOrderId && w.TenantId == tenantId, cancellationToken);

        if (workOrder == null)
        {
            return Result<Guid>.Failure("NOT_FOUND", $"WorkOrder with ID '{request.WorkOrderId}' was not found.");
        }

        var attachment = WorkOrderAttachment.Create(
            tenantId,
            request.WorkOrderId,
            request.FileName,
            request.BlobUrl,
            request.FileHashSha256,
            request.FileSizeBytes,
            userId);

        workOrder.AddAttachment(attachment);
        _context.WorkOrderAttachments.Add(attachment);
        await _context.SaveChangesAsync(cancellationToken);

        return Result<Guid>.Success(attachment.Id);
    }
}
