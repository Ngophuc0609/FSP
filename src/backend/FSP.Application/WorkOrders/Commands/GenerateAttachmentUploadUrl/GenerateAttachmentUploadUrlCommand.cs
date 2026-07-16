using System;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using MediatR;
using FluentValidation;
using Microsoft.EntityFrameworkCore;
using FSP.Domain.Common;
using FSP.Application.Common.Interfaces;

namespace FSP.Application.WorkOrders.Commands.GenerateAttachmentUploadUrl;

public record GenerateAttachmentUploadUrlCommand(
    Guid WorkOrderId,
    string FileName,
    long FileSizeBytes,
    string FileHashSha256
) : IRequest<Result<PreSignedUploadInfo>>;

public class GenerateAttachmentUploadUrlCommandValidator : AbstractValidator<GenerateAttachmentUploadUrlCommand>
{
    private static readonly string[] AllowedExtensions = { ".jpg", ".jpeg", ".png", ".pdf" };
    private const long MaxFileSizeBytes = 15 * 1024 * 1024; // 15MB max per DEC-WO-005

    public GenerateAttachmentUploadUrlCommandValidator()
    {
        RuleFor(v => v.WorkOrderId)
            .NotEmpty().WithMessage("WorkOrder ID is required.");

        RuleFor(v => v.FileName)
            .NotEmpty().WithMessage("File name is required.")
            .MaximumLength(260).WithMessage("File name exceeds maximum length.")
            .Must(HaveValidExtension).WithMessage("Only .jpg, .jpeg, .png, and .pdf attachments are permitted.");

        RuleFor(v => v.FileSizeBytes)
            .GreaterThan(0).WithMessage("File size must be greater than zero.")
            .LessThanOrEqualTo(MaxFileSizeBytes).WithMessage($"File size must not exceed {MaxFileSizeBytes / (1024 * 1024)}MB per DEC-WO-005.");

        RuleFor(v => v.FileHashSha256)
            .NotEmpty().WithMessage("SHA256 file hash is required for integrity verification.");
    }

    private bool HaveValidExtension(string fileName)
    {
        if (string.IsNullOrWhiteSpace(fileName)) return false;
        var ext = Path.GetExtension(fileName)?.ToLowerInvariant();
        return !string.IsNullOrEmpty(ext) && AllowedExtensions.Contains(ext);
    }
}

public class GenerateAttachmentUploadUrlCommandHandler : IRequestHandler<GenerateAttachmentUploadUrlCommand, Result<PreSignedUploadInfo>>
{
    private readonly IApplicationDbContext _context;
    private readonly ITenantProvider _tenantProvider;
    private readonly IBlobStorageService _blobStorageService;

    public GenerateAttachmentUploadUrlCommandHandler(
        IApplicationDbContext context,
        ITenantProvider tenantProvider,
        IBlobStorageService blobStorageService)
    {
        _context = context;
        _tenantProvider = tenantProvider;
        _blobStorageService = blobStorageService;
    }

    public async Task<Result<PreSignedUploadInfo>> Handle(GenerateAttachmentUploadUrlCommand request, CancellationToken cancellationToken)
    {
        var tenantId = _tenantProvider.TenantId;

        // Verify WorkOrder exists and belongs to current tenant
        var workOrderExists = await _context.WorkOrders
            .AnyAsync(w => w.Id == request.WorkOrderId && w.TenantId == tenantId, cancellationToken);

        if (!workOrderExists)
        {
            return Result<PreSignedUploadInfo>.Failure("NOT_FOUND", $"WorkOrder with ID '{request.WorkOrderId}' was not found.");
        }

        var uploadInfo = await _blobStorageService.GeneratePreSignedUploadUrlAsync(
            tenantId,
            request.WorkOrderId,
            request.FileName,
            request.FileSizeBytes,
            cancellationToken);

        return Result<PreSignedUploadInfo>.Success(uploadInfo);
    }
}
