import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/ptw/ptw_model.dart';
import 'ptw_status_chip.dart';
import 'ptw_type_badge.dart';

class PtwCard extends StatelessWidget {
  final PermitToWork permit;
  final VoidCallback onTap;

  const PtwCard({
    super.key,
    required this.permit,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPowerBlock = permit.powerBlockRequired;

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
        side: BorderSide(
          color: permit.status == PtwStatus.started
              ? Colors.deepOrange.shade300
              : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: permit.status == PtwStatus.started ? 1.5 : 1,
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
              // Top Bar: PTW ID + Type Badge + Status Chip
              Row(
                children: [
                  Flexible(
                    child: Text(
                      permit.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.bold,
                        color: theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 6),
                  PtwTypeBadge(type: permit.type),
                  const Spacer(),
                  PtwStatusChip(status: permit.status),
                ],
              ),
              const SizedBox(height: 10),

              // Title
              Text(
                permit.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.bold,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 8),

              // Location & Corridor
              Row(
                children: [
                  Icon(Icons.location_on_outlined, size: 14, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      '${permit.corridor} • ${permit.location}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),

              // Power block highlight banner
              if (isPowerBlock) ...[
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  decoration: BoxDecoration(
                    color: Colors.red.shade50,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.red.shade200),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.bolt, size: 14, color: Colors.red.shade800),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          permit.powerBlockSector ?? '25kV Traction Power Block Enforced',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(fontSize: 11, color: Colors.red.shade900, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ],

              const Divider(height: 18),

              // Footer: PIC & Validity Window
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.person_pin_circle_outlined,
                            size: 14, color: Colors.teal.shade800),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            permit.picName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal.shade900),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.schedule_rounded,
                          size: 13, color: Colors.grey.shade600),
                      const SizedBox(width: 4),
                      Text(
                        '${DateFormat('HH:mm').format(permit.startTime)} - ${DateFormat('HH:mm').format(permit.endTime)}',
                        style: TextStyle(
                            fontSize: 11,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w600),
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
