import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:fsp_mobile/features/work_orders/presentation/providers/work_order_providers.dart';

/// Attachment upload item display record.
class UploadedAttachmentItem {
  final String fileName;
  final String blobUrl;
  final int fileSizeBytes;
  UploadedAttachmentItem({required this.fileName, required this.blobUrl, required this.fileSizeBytes});
}

/// Attachment Pre-Signed URL upload widget per DEC-WO-005.
/// Bypasses backend server RAM/bandwidth by uploading binary straight to Blob storage.
/// Enforces RULE-FLUTTER-003 minimum 48x48 logical pixel touch targets for field gloves.
class AttachmentUploadWidget extends ConsumerStatefulWidget {
  final String workOrderId;
  const AttachmentUploadWidget({super.key, required this.workOrderId});

  @override
  ConsumerState<AttachmentUploadWidget> createState() => _AttachmentUploadWidgetState();
}

class _AttachmentUploadWidgetState extends ConsumerState<AttachmentUploadWidget> {
  final List<UploadedAttachmentItem> _attachments = [];
  bool _isUploading = false;
  String? _uploadStatusText;

  Future<void> _pickAndUploadAttachment() async {
    setState(() {
      _isUploading = true;
      _uploadStatusText = 'Đang xin Pre-Signed URL từ máy chủ...';
    });

    try {
      final apiClient = ref.read(apiClientProvider);

      // Simulated field capture photo sample per DEC-WO-005 (in production connects to image_picker / camera)
      final sampleFileName = 'field_inspection_${DateTime.now().millisecondsSinceEpoch}.jpg';
      final sampleBytes = utf8.encode('SIMULATED_BINARY_IMAGE_DATA_FIELD_SERVICE_PLATFORM');
      final sampleSizeBytes = sampleBytes.length;
      final sampleHash = 'e3b0c44298fc1c149afbf4c8996fb92427ae41e4649b934ca495991b7852b855';

      // 1. Request Pre-Signed upload URL from backend
      final preSignedResponse = await apiClient.client.post(
        '/api/v1/work-orders/${widget.workOrderId}/attachments/pre-signed-url',
        data: {
          'fileName': sampleFileName,
          'fileSizeBytes': sampleSizeBytes,
          'fileHashSha256': sampleHash,
        },
      );

      if (preSignedResponse.statusCode != 200 || preSignedResponse.data == null) {
        throw Exception('Không nhận được Pre-Signed URL hợp lệ từ máy chủ.');
      }

      final data = preSignedResponse.data;
      final uploadUrl = data['uploadUrl']?.toString() ?? '';
      final blobUrl = data['blobUrl']?.toString() ?? '';
      final attachmentId = data['attachmentId']?.toString() ?? '';

      setState(() => _uploadStatusText = 'Đang tải tệp trực tiếp lên Cloud Blob Storage...');

      // 2. Direct binary PUT upload straight to Cloud Blob storage (bypassing backend RAM)
      final directDio = Dio();
      await directDio.put(
        uploadUrl,
        data: sampleBytes,
        options: Options(headers: {'Content-Type': 'image/jpeg'}),
      );

      setState(() => _uploadStatusText = 'Đang xác nhận lưu metadata vào SQL Server...');

      // 3. Confirm attachment record on backend
      await apiClient.client.post(
        '/api/v1/work-orders/${widget.workOrderId}/attachments/confirm',
        data: {
          'attachmentId': attachmentId,
          'fileName': sampleFileName,
          'blobUrl': blobUrl,
          'fileHashSha256': sampleHash,
          'fileSizeBytes': sampleSizeBytes,
        },
      );

      setState(() {
        _attachments.add(UploadedAttachmentItem(
          fileName: sampleFileName,
          blobUrl: blobUrl,
          fileSizeBytes: sampleSizeBytes,
        ));
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Đã đính kèm hình ảnh hiện trường "$sampleFileName" thành công!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Lỗi tải tệp đính kèm: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUploading = false;
          _uploadStatusText = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Đính kèm hình ảnh / tài liệu hiện trường (Pre-Signed URL)',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
        ),
        const SizedBox(height: 8),
        if (_attachments.isNotEmpty) ...[
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _attachments.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, idx) {
              final item = _attachments[idx];
              return Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.image, color: Colors.blueAccent),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(item.fileName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13)),
                          Text('Dung lượng: ${item.fileSizeBytes} bytes · Cloud Blob SAS',
                              style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),
                        ],
                      ),
                    ),
                    const Icon(Icons.check_circle, color: Colors.green, size: 18),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 12),
        ],
        if (_isUploading) ...[
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2)),
                const SizedBox(width: 12),
                Expanded(child: Text(_uploadStatusText ?? 'Đang tải...', style: const TextStyle(fontSize: 13))),
              ],
            ),
          ),
          const SizedBox(height: 12),
        ],
        // Enforce minimum 48x48 touch target per RULE-FLUTTER-003 for field gloves
        ConstrainedBox(
          constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 48),
          child: OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.blue.shade800,
              side: BorderSide(color: Colors.blue.shade800, width: 1.5),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('Thêm Ảnh Hiện Trường (Pre-Signed Upload)', style: TextStyle(fontWeight: FontWeight.bold)),
            onPressed: _isUploading ? null : _pickAndUploadAttachment,
          ),
        ),
      ],
    );
  }
}
