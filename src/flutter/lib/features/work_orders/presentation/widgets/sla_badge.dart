import 'package:flutter/material.dart';

enum SlaStatus { onTrack, warning, breached, paused }

class SlaBadge extends StatelessWidget {
  final SlaStatus status;
  final int accumulatedMinutes;

  const SlaBadge({
    super.key,
    required this.status,
    required this.accumulatedMinutes,
  });

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    Color foregroundColor;
    IconData icon;
    String label;

    switch (status) {
      case SlaStatus.onTrack:
        backgroundColor = Colors.green.shade100;
        foregroundColor = Colors.green.shade800;
        icon = Icons.check_circle_outline;
        label = 'SLA On Track';
        break;
      case SlaStatus.warning:
        backgroundColor = Colors.orange.shade100;
        foregroundColor = Colors.orange.shade900;
        icon = Icons.warning_amber_rounded;
        label = 'SLA Warning';
        break;
      case SlaStatus.breached:
        backgroundColor = Colors.red.shade100;
        foregroundColor = Colors.red.shade900;
        icon = Icons.error_outline;
        label = 'SLA Breached';
        break;
      case SlaStatus.paused:
        backgroundColor = Colors.grey.shade200;
        foregroundColor = Colors.grey.shade700;
        icon = Icons.pause_circle_outline;
        label = 'SLA Paused';
        break;
    }

    // Format accumulated time
    final hours = accumulatedMinutes ~/ 60;
    final mins = accumulatedMinutes % 60;
    final timeString = hours > 0 ? '${hours}h ${mins}m' : '${mins}m';

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: foregroundColor.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: foregroundColor),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: foregroundColor,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: foregroundColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              timeString,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: foregroundColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
