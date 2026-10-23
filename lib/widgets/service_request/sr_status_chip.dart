import 'package:flutter/material.dart';
import '../../models/service_request/service_request_model.dart';

class SrStatusChip extends StatelessWidget {
  final ServiceRequestStatus status;

  const SrStatusChip({super.key, required this.status});

  Color _chipColor() {
    switch (status) {
      case ServiceRequestStatus.open:
        return Colors.blue.shade700;
      case ServiceRequestStatus.inProgress:
        return Colors.orange.shade800;
      case ServiceRequestStatus.waitingForMaterial:
        return Colors.purple.shade700;
      case ServiceRequestStatus.workOrderIssued:
        return Colors.indigo.shade700;
      case ServiceRequestStatus.closed:
        return Colors.green.shade700;
      case ServiceRequestStatus.cancelled:
        return Colors.grey.shade600;
    }
  }

  IconData _icon() {
    switch (status) {
      case ServiceRequestStatus.open:
        return Icons.radio_button_checked;
      case ServiceRequestStatus.inProgress:
        return Icons.timelapse_rounded;
      case ServiceRequestStatus.waitingForMaterial:
        return Icons.inventory_2_outlined;
      case ServiceRequestStatus.workOrderIssued:
        return Icons.assignment_turned_in_outlined;
      case ServiceRequestStatus.closed:
        return Icons.check_circle_outline_rounded;
      case ServiceRequestStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _chipColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(), size: 13, color: c),
          const SizedBox(width: 5),
          Flexible(
            child: Text(
              status.label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: c,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
