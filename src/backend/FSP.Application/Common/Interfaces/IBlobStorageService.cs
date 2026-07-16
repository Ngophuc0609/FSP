using System;
using System.Threading;
using System.Threading.Tasks;

namespace FSP.Application.Common.Interfaces;

public record PreSignedUploadInfo(
    Guid AttachmentId,
    string UploadUrl,
    string BlobUrl,
    DateTime ExpiresAtUtc
);

/// <summary>
/// Blob storage service interface for Pre-Signed URL generation per DEC-WO-005.
/// Decouples Application layer from Azure Blob Storage / AWS S3 implementations.
/// </summary>
public interface IBlobStorageService
{
    Task<PreSignedUploadInfo> GeneratePreSignedUploadUrlAsync(
        Guid tenantId,
        Guid workOrderId,
        string fileName,
        long fileSizeBytes,
        CancellationToken cancellationToken = default);
}
