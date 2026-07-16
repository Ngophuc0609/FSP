import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';
import 'package:fsp_mobile/features/work_orders/presentation/providers/work_order_providers.dart';

/// Conflict Queue Screen/Modal implementing DEC-WO-004 RowVersion 409 Conflict resolution UI.
/// Enforces RULE-FLUTTER-003 minimum 48x48 logical pixel touch targets for field gloves.
class ConflictQueueModal extends ConsumerWidget {
  const ConflictQueueModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workOrdersAsync = ref.watch(workOrderListNotifierProvider);

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Row(
                children: [
                  Icon(Icons.warning_amber_rounded, color: Colors.red, size: 28),
                  SizedBox(width: 10),
                  Text(
                    'Hàng Đợi Xung Đột Dữ Liệu',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              // Enforce 48x48 minimum close button for field gloves per RULE-FLUTTER-003
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
                child: IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Các phiếu bên dưới gặp lỗi xung đột phiên bản (RowVersion 409 Conflict) khi đồng bộ với máy chủ trung tâm.',
            style: TextStyle(color: Colors.grey.shade700, fontSize: 13),
          ),
          const Divider(height: 24),
          Flexible(
            child: workOrdersAsync.when(
              data: (items) {
                final conflictItems = items.where((i) => i.syncStatus == 2).toList();
                if (conflictItems.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: Text('Không có phiếu nào đang bị lỗi hoặc xung đột.'),
                    ),
                  );
                }
                return ListView.separated(
                  shrinkWrap: true,
                  itemCount: conflictItems.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = conflictItems[index];
                    return _buildConflictCard(context, ref, item);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, _) => Text('Lỗi: $err'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConflictCard(BuildContext context, WidgetRef ref, WorkOrderModel item) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                item.id,
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red.shade900),
              ),
              Text(
                'ClientRef: ${item.clientReferenceId.length > 8 ? item.clientReferenceId.substring(0, 8) : item.clientReferenceId}...',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(item.title, style: const TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 6),
          Text(
            item.syncErrorMessage ?? 'Xung đột RowVersion (409 Conflict)',
            style: TextStyle(fontSize: 12, color: Colors.red.shade800),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              // Button 1: Discard local & fetch server
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.grey.shade800,
                      side: BorderSide(color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.restore, size: 18),
                    label: const Text('Lấy bản máy chủ', style: TextStyle(fontSize: 13)),
                    onPressed: () async {
                      // Discard local error status and trigger fresh server keyset sync
                      final repo = ref.read(workOrderRepositoryProvider);
                      await repo.syncWithServer();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Button 2: Retry sync
              Expanded(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(minHeight: 48),
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade700,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Thử lại đồng bộ', style: TextStyle(fontSize: 13)),
                    onPressed: () async {
                      await ref.read(workOrderListNotifierProvider.notifier).refreshSync();
                      if (context.mounted) Navigator.of(context).pop();
                    },
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
