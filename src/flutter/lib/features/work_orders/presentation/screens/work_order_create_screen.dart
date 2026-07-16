import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fsp_mobile/features/work_orders/presentation/providers/work_order_providers.dart';

class WorkOrderCreateScreen extends ConsumerStatefulWidget {
  const WorkOrderCreateScreen({super.key});

  @override
  ConsumerState<WorkOrderCreateScreen> createState() => _WorkOrderCreateScreenState();
}

class _WorkOrderCreateScreenState extends ConsumerState<WorkOrderCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  int _selectedPriority = 1; // 1=Normal, 2=High, 3=Critical
  bool _isSaving = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);
    try {
      await ref.read(workOrderListNotifierProvider.notifier).createWorkOrder(
            title: _titleController.text.trim(),
            description: _descriptionController.text.trim(),
            priority: _selectedPriority,
          );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phiếu đã lưu Offline thành công! Sẽ tự động đồng bộ khi có mạng.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.of(context).pop();
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tạo Phiếu Công Việc (Offline-First)', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Tiêu đề công việc (*)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  hintText: 'Nhập tiêu đề kiểm tra / bảo trì...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                ),
                validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập tiêu đề' : null,
              ),
              const SizedBox(height: 20),
              const Text(
                'Mức độ ưu tiên (*)',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildPriorityButton(label: 'Bình thường', value: 1, color: Colors.green),
                  const SizedBox(width: 8),
                  _buildPriorityButton(label: 'Quan trọng', value: 2, color: Colors.orange),
                  const SizedBox(width: 8),
                  _buildPriorityButton(label: 'Khẩn cấp', value: 3, color: Colors.red),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Mô tả chi tiết kỹ thuật',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Ghi chú thiết bị, yêu cầu vật tư thay thế...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.all(16),
                ),
              ),
              const SizedBox(height: 32),
              // Enforce minimum 48x48 logical pixels touch box per RULE-FLUTTER-003 for field gloves
              ConstrainedBox(
                constraints: const BoxConstraints(minWidth: double.infinity, minHeight: 52),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  icon: _isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Icon(Icons.save, size: 24),
                  label: Text(
                    _isSaving ? 'Đang lưu vào SQLite Drift...' : 'LƯU PHIẾU CÔNG VIỆC',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: _isSaving ? null : _submit,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPriorityButton({required String label, required int value, required Color color}) {
    final isSelected = _selectedPriority == value;
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minHeight: 48),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            backgroundColor: isSelected ? color.withValues(alpha: 0.15) : Colors.transparent,
            side: BorderSide(color: isSelected ? color : Colors.grey.shade400, width: isSelected ? 2 : 1),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          onPressed: () => setState(() => _selectedPriority = value),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? color : Colors.grey.shade800,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}
