import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsp_mobile/features/work_orders/presentation/providers/work_order_providers.dart';
import 'package:fsp_mobile/features/work_orders/presentation/screens/conflict_queue_screen.dart';

/// Top visual banner showing sync state, pending counts, or conflicts per DEC-WO-006.
class SyncStatusBar extends ConsumerWidget {
  const SyncStatusBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workOrdersAsync = ref.watch(workOrderListNotifierProvider);

    return workOrdersAsync.when(
      data: (items) {
        final pendingCount = items.where((i) => i.syncStatus == 1).length;
        final errorCount = items.where((i) => i.syncStatus == 2).length;

        if (pendingCount == 0 && errorCount == 0) {
          return const SizedBox.shrink();
        }

        final isError = errorCount > 0;
        final backgroundColor = isError ? Colors.red.shade700 : Colors.amber.shade800;
        final icon = isError ? Icons.sync_problem : Icons.cloud_upload_outlined;
        final text = isError
            ? 'Lỗi xung đột ($errorCount phiếu). Nhấn để xem & xử lý.'
            : 'Đang lưu Offline ($pendingCount phiếu đang chờ đồng bộ API)';

        return InkWell(
          onTap: isError
              ? () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ConflictQueueModal(),
                  );
                }
              : null,
          child: Container(
            width: double.infinity,
            color: backgroundColor,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                    ),
                  ),
                ),
                if (isError) ...[
                  // Enforce minimum 48x48 logical pixel touch target for field gloves per RULE-FLUTTER-003
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                    child: IconButton(
                      icon: const Icon(Icons.warning_amber, color: Colors.white),
                      tooltip: 'Xem hàng đợi xung đột',
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (_) => const ConflictQueueModal(),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
      loading: () => Container(
        width: double.infinity,
        color: Colors.blue.shade700,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: const Row(
          children: [
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
            ),
            SizedBox(width: 12),
            Text(
              'Đang kiểm tra kết nối và đồng bộ dữ liệu hiện trường...',
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13),
            ),
          ],
        ),
      ),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
