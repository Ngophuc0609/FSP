using System;
using FSP.Domain.Common;

namespace FSP.Domain.Entities;

/// <summary>
/// Decoupled binary attachment metadata entity per DEC-WO-005.
/// Prevents large photo payloads from blocking mobile cellular synchronization or bloating SQLite.
/// </summary>
public class WorkOrderAttachment : BaseTenantEntity
{
    public Guid WorkOrderId { get; private set; }
    public string FileName { get; private set; } = string.Empty;
    public string BlobUrl { get; private set; } = string.Empty;
    public string FileHashSha256 { get; private set; } = string.Empty;
    public long FileSizeBytes { get; private set; }

    private WorkOrderAttachment() : base() { }

    public static WorkOrderAttachment Create(
        Guid tenantId,
        Guid workOrderId,
        string fileName,
        string blobUrl,
        string fileHashSha256,
        long fileSizeBytes,
        Guid createdBy)
    {
        if (string.IsNullOrWhiteSpace(blobUrl))
            throw new ArgumentException("Blob URL cannot be empty.", nameof(blobUrl));

        return new WorkOrderAttachment
        {
            Id = CombGuid.NewGuid(),
            TenantId = tenantId,
            WorkOrderId = workOrderId,
            FileName = fileName,
            BlobUrl = blobUrl,
            FileHashSha256 = fileHashSha256,
            FileSizeBytes = fileSizeBytes,
            CreatedAtUtc = DateTime.UtcNow,
            CreatedBy = createdBy
        };
    }
}
