import 'package:flutter/material.dart';
import '../../models/service_request/service_request_model.dart';
import 'sr_priority_badge.dart';
import 'sr_status_chip.dart';

class ServiceRequestCard extends StatelessWidget {
  final ServiceRequest request;
  final VoidCallback onTap;

  const ServiceRequestCard({
    super.key,
    required this.request,
    required this.onTap,
  });

  IconData _subsystemIcon(String sub) {
    final s = sub.toLowerCase();
    if (s.contains('bogie') || s.contains('wheel')) return Icons.tire_repair;
    if (s.contains('hvac') || s.contains('climate')) return Icons.ac_unit;
    if (s.contains('door')) return Icons.sensor_door_outlined;
    if (s.contains('brake') || s.contains('pneumatic')) return Icons.speed;
    if (s.contains('traction') || s.contains('propulsion')) return Icons.bolt;
    if (s.contains('pantograph') || s.contains('ohe')) return Icons.electric_bolt;
    return Icons.build_circle_outlined;
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: request.priority == ServiceRequestPriority.critical
              ? Colors.red.shade200
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: request.priority == ServiceRequestPriority.critical ? 1.5 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Trainset Tag + SR Number + Priority Badge
              Row(
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 7, vertical: 3),
                            decoration: BoxDecoration(
                              color: theme.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              '${request.trainsetId} • ${request.carNumber}',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: theme.primaryColor,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 6),
                        Flexible(
                          child: Text(
                            request.id,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  SrPriorityBadge(priority: request.priority),
                ],
              ),
              const SizedBox(height: 10),

              // Title
              Text(
                request.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),

              // Subsystem & Fault Code row
              Row(
                children: [
                  Icon(_subsystemIcon(request.subsystem), size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Flexible(
                    child: Text(
                      request.subsystem,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      request.faultCode,
                      style: TextStyle(fontSize: 10.5, fontWeight: FontWeight.bold, color: Colors.grey.shade800),
                    ),
                  ),
                ],
              ),

              // Callout banner if Waiting for Material or WO Issued
              if (request.status == ServiceRequestStatus.waitingForMaterial && request.waitingReason != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.purple.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.purple.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.inventory_2_outlined, size: 14, color: Colors.purple.shade800),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          request.waitingReason!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.purple.shade900, fontWeight: FontWeight.w500),
                        ),
                      ),
                    ],
                  ),
                ),
              ] else if (request.status == ServiceRequestStatus.workOrderIssued && request.workOrderId != null) ...[
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.indigo.shade50,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.indigo.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.assignment_turned_in_outlined, size: 14, color: Colors.indigo.shade800),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          'Linked Work Order: ${request.workOrderId}',
                          style: TextStyle(fontSize: 11, color: Colors.indigo.shade900, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Divider(height: 18),

              // Footer: Status Chip + Reporter & Time
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: SrStatusChip(status: request.status),
                  ),
                  const SizedBox(width: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.access_time_rounded,
                          size: 12, color: Colors.grey.shade500),
                      const SizedBox(width: 4),
                      Text(
                        _formatTimeAgo(request.reportedAt),
                        style: TextStyle(
                            fontSize: 11, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
