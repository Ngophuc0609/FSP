import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsp_mobile/features/work_orders/domain/models/work_order_model.dart';
import 'package:fsp_mobile/features/work_orders/presentation/providers/work_order_providers.dart';
import 'package:fsp_mobile/features/work_orders/presentation/widgets/sync_status_bar.dart';
import 'package:fsp_mobile/features/work_orders/presentation/screens/work_order_create_screen.dart';

class WorkOrderListScreen extends ConsumerWidget {
  const WorkOrderListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workOrdersAsync = ref.watch(workOrderListNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phiếu Công Việc Field Service',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          // Enforce minimum 48x48 logical pixel touch box per RULE-FLUTTER-003
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: IconButton(
              icon: const Icon(Icons.sync),
              tooltip: 'Đồng bộ API ngay',
              onPressed: () {
                ref.read(workOrderListNotifierProvider.notifier).refreshSync();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đang kích hoạt đồng bộ dữ liệu SQLite với API...')),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 56, minHeight: 56),
        child: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const WorkOrderCreateScreen()),
            );
          },
          icon: const Icon(Icons.add),
          label: const Text('Tạo Phiếu', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.blue.shade800,
          foregroundColor: Colors.white,
        ),
      ),
      body: Column(
        children: [
          // Top sync banner per DEC-WO-006
          const SyncStatusBar(),
          Expanded(
            child: workOrdersAsync.when(
              data: (workOrders) {
                if (workOrders.isEmpty) {
                  return const Center(
                    child: Text('Không có phiếu công việc nào. Hãy nhấn Tạo Phiếu để thêm mới.'),
                  );
                }
                return RefreshIndicator(
                  onRefresh: () async {
                    await ref.read(workOrderListNotifierProvider.notifier).refreshSync();
                  },
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: workOrders.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final item = workOrders[index];
                      return _buildWorkOrderCard(context, ref, item);
                    },
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text('Lỗi tải dữ liệu: $err'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkOrderCard(BuildContext context, WidgetRef ref, WorkOrderModel item) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        item.id,
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.blueAccent,
                        ),
                      ),
                      if (item.syncStatus == 1) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.cloud_queue, size: 16, color: Colors.amber),
                      ] else if (item.syncStatus == 2) ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.error_outline, size: 16, color: Colors.red),
                      ] else ...[
                        const SizedBox(width: 8),
                        const Icon(Icons.cloud_done, size: 16, color: Colors.green),
                      ],
                    ],
                  ),
                  _buildPriorityBadge(item.priority),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                item.description,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              if (item.syncErrorMessage != null) ...[
                const SizedBox(height: 8),
                Text(
                  item.syncErrorMessage!,
                  style: TextStyle(color: Colors.red.shade700, fontSize: 12),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Enforce minimum 48x48 touch target for field gloves per RULE-FLUTTER-003
                  ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 130, minHeight: 48),
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue.shade800,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Bắt Đầu Job'),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityBadge(int priority) {
    Color color;
    String label;
    switch (priority) {
      case 3:
        color = Colors.red.shade700;
        label = 'KHẨN CẤP';
        break;
      case 2:
        color = Colors.orange.shade700;
        label = 'QUAN TRỌNG';
        break;
      default:
        color = Colors.green.shade700;
        label = 'BÌNH THƯỜNG';
    }
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }
}
