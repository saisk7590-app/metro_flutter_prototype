import 'package:flutter/material.dart';
import '../../models/ptw/ptw_model.dart';

class PtwStatusChip extends StatelessWidget {
  final PtwStatus status;

  const PtwStatusChip({super.key, required this.status});

  Color _chipColor() {
    switch (status) {
      case PtwStatus.draft:
        return Colors.grey.shade600;
      case PtwStatus.waitingForApproval:
        return Colors.amber.shade800;
      case PtwStatus.approved:
        return Colors.blue.shade700;
      case PtwStatus.started:
        return Colors.deepOrange.shade700;
      case PtwStatus.completed:
        return Colors.teal.shade700;
      case PtwStatus.closed:
        return Colors.green.shade700;
      case PtwStatus.cancelled:
        return Colors.red.shade700;
    }
  }

  IconData _icon() {
    switch (status) {
      case PtwStatus.draft:
        return Icons.edit_note_rounded;
      case PtwStatus.waitingForApproval:
        return Icons.hourglass_top_rounded;
      case PtwStatus.approved:
        return Icons.verified_rounded;
      case PtwStatus.started:
        return Icons.play_circle_filled_rounded;
      case PtwStatus.completed:
        return Icons.task_alt_rounded;
      case PtwStatus.closed:
        return Icons.check_circle_rounded;
      case PtwStatus.cancelled:
        return Icons.cancel_outlined;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _chipColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3.5),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: c.withValues(alpha: 0.35)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon(), size: 12, color: c),
          const SizedBox(width: 4),
          Text(
            status.label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: c,
            ),
          ),
        ],
      ),
    );
  }
}
