using System;
using System.Collections.Generic;
using FSP.Domain.Entities;

namespace FSP.Application.WorkOrders.Queries.GetWorkOrderById;

public record WorkOrderAttachmentDto(
    Guid Id,
    string FileName,
    string BlobUrl,
    string FileHashSha256,
    long FileSizeBytes,
    DateTime CreatedAtUtc
);

public record WorkOrderDetailsDto(
    Guid Id,
    string Title,
    string Description,
    WorkOrderStatus Status,
    WorkOrderPriority Priority,
    Guid? AssignedTechnicianId,
    DateTime CreatedAtUtc,
    Guid CreatedBy,
    DateTime? LastModifiedAtUtc,
    Guid? LastModifiedBy,
    Guid ClientReferenceId,
    byte[] RowVersion,
    IReadOnlyList<WorkOrderAttachmentDto> Attachments
);
