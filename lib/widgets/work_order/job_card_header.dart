import 'package:flutter/material.dart';

class JobCardHeader extends StatelessWidget {
  final String woNo;
  final String assetDetails;
  final String status;
  final String priority;
  final String location;
  final double totalHours;

  const JobCardHeader({
    super.key,
    required this.woNo,
    required this.assetDetails,
    required this.status,
    required this.priority,
    required this.location,
    required this.totalHours,
  });

  Color _statusColor() {
    switch (status.toLowerCase()) {
      case 'in progress':
      case 'started':
        return Colors.orange.shade800;
      case 'completed':
      case 'closed':
        return Colors.green.shade700;
      case 'returned':
        return Colors.red.shade700;
      case 'rescheduled':
        return Colors.amber.shade800;
      default:
        return Colors.blue.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    final c = _statusColor();

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Colors.grey.shade200)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: Colors.indigo.shade50,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.indigo.shade200),
                ),
                child: Text(
                  assetDetails,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.indigo.shade900),
                ),
              ),
              const SizedBox(width: 8),
              Text(woNo, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: c.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: c.withValues(alpha: 0.3)),
                ),
                child: Text(
                  status.toUpperCase(),
                  style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: c),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
              const SizedBox(width: 4),
              Text(location, style: TextStyle(fontSize: 12, color: Colors.grey.shade700)),
              const SizedBox(width: 12),
              Icon(Icons.timer_outlined, size: 14, color: Colors.blue.shade700),
              const SizedBox(width: 4),
              Text('${totalHours.toStringAsFixed(1)} hrs logged',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.blue.shade800)),
              const Spacer(),
              Text('Priority: $priority',
                  style: TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600, color: Colors.grey.shade700)),
            ],
          ),
        ],
      ),
    );
  }
}
