import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/work_order/job_card_provider.dart';
import 'reschedule_wo_dialog.dart';
import 'return_wo_dialog.dart';

class JobCardBottomBar extends StatelessWidget {
  final String woNo;
  final String status;

  const JobCardBottomBar({
    super.key,
    required this.woNo,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    final isDone =
        status == 'Completed' || status == 'Closed' || status == 'Returned';
    if (isDone) return const SizedBox.shrink();

    final provider = context.read<JobCardProvider>();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.schedule_send_outlined, size: 14),
                label: const Text('Reschedule',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => RescheduleWorkOrderDialog(
                    woNo: woNo,
                    onConfirm: (date, rsn) =>
                        provider.rescheduleWorkOrder(woNo, date, rsn),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.red.shade700,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  visualDensity: VisualDensity.compact,
                ),
                icon: const Icon(Icons.assignment_return_outlined, size: 14),
                label: const Text('Return',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
                onPressed: () => showDialog(
                  context: context,
                  builder: (_) => ReturnWorkOrderDialog(
                    woNo: woNo,
                    onConfirm: (rsn) => provider.returnWorkOrder(woNo, rsn),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              if (status != 'In Progress' && status != 'Started')
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(Icons.play_arrow_rounded, size: 16),
                  label: const Text('Start Work',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () => provider.updateStatus(woNo, 'In Progress'),
                )
              else
                FilledButton.icon(
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.green.shade700,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    visualDensity: VisualDensity.compact,
                  ),
                  icon: const Icon(Icons.check_circle_outline, size: 15),
                  label: const Text('Sign-Off & Complete',
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  onPressed: () => provider.updateStatus(woNo, 'Completed'),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
