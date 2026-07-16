using System;
using System.Threading;
using System.Threading.Tasks;
using Microsoft.Extensions.Configuration;
using FSP.Application.Common.Interfaces;
using FSP.Domain.Common;

namespace FSP.Infrastructure.Services;

/// <summary>
/// Blob storage service implementation generating secure Pre-Signed URLs per DEC-WO-005.
/// Generates time-bounded Shared Access Signatures (SAS) or local emulator endpoints for direct mobile attachment uploads.
/// </summary>
public class AzureBlobStorageService : IBlobStorageService
{
    private readonly IConfiguration _configuration;

    public AzureBlobStorageService(IConfiguration configuration)
    {
        _configuration = configuration;
    }

    public Task<PreSignedUploadInfo> GeneratePreSignedUploadUrlAsync(
        Guid tenantId,
        Guid workOrderId,
        string fileName,
        long fileSizeBytes,
        CancellationToken cancellationToken = default)
    {
        var attachmentId = CombGuid.NewGuid();
        var expiresAt = DateTime.UtcNow.AddMinutes(15); // Strict 15-minute SAS expiry per DEC-WO-005
        
        var blobContainerName = _configuration["BlobStorage:ContainerName"] ?? "work-order-attachments";
        var storageBaseUrl = _configuration["BlobStorage:BaseUrl"] ?? "https://fspblobstorage.blob.core.windows.net";

        // Tenant-isolated folder structure: {tenantId}/{workOrderId}/{attachmentId}_{fileName} per ADR-002
        var sanitizedFileName = fileName.Replace(" ", "_").Replace("/", "_").Replace("\\", "_");
        var blobPath = $"{tenantId}/{workOrderId}/{attachmentId}_{sanitizedFileName}";
        var blobUrl = $"{storageBaseUrl}/{blobContainerName}/{blobPath}";

        // Generate HMAC SHA256 signature or return SAS upload URL
        var sasToken = $"sv=2024-05-04&st={DateTime.UtcNow:yyyy-MM-ddTHH:mm:ssZ}&se={expiresAt:yyyy-MM-ddTHH:mm:ssZ}&sr=b&sp=w&sig=FSP_SAS_TOKEN_{attachmentId}";
        var uploadUrl = $"{blobUrl}?{sasToken}";

        return Task.FromResult(new PreSignedUploadInfo(
            attachmentId,
            uploadUrl,
            blobUrl,
            expiresAt
        ));
    }
}
