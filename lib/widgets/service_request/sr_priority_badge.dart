import 'package:flutter/material.dart';
import '../../models/service_request/service_request_model.dart';

class SrPriorityBadge extends StatelessWidget {
  final ServiceRequestPriority priority;

  const SrPriorityBadge({super.key, required this.priority});

  Color _color() {
    switch (priority) {
      case ServiceRequestPriority.critical:
        return Colors.red.shade700;
      case ServiceRequestPriority.high:
        return Colors.deepOrange.shade600;
      case ServiceRequestPriority.medium:
        return Colors.amber.shade800;
      case ServiceRequestPriority.low:
        return Colors.teal.shade700;
    }
  }

  IconData _icon() {
    switch (priority) {
      case ServiceRequestPriority.critical:
        return Icons.warning_rounded;
      case ServiceRequestPriority.high:
        return Icons.arrow_upward_rounded;
      case ServiceRequestPriority.medium:
        return Icons.remove_rounded;
      case ServiceRequestPriority.low:
        return Icons.arrow_downward_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _color();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: c.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(), size: 13, color: c),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              priority.label.toUpperCase(),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: FontWeight.bold,
                color: c,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
