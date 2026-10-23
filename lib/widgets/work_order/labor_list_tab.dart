import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/work_order/job_card_models.dart';

class LaborListTab extends StatelessWidget {
  final List<WorkOrderLabor> laborList;
  final VoidCallback onAddLabor;

  const LaborListTab({
    super.key,
    required this.laborList,
    required this.onAddLabor,
  });

  @override
  Widget build(BuildContext context) {
    if (laborList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.timer_off_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            const Text('No labor hours booked yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text('Use the floating button to log technician time.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 80, left: 14, right: 14),
      itemCount: laborList.length,
      itemBuilder: (context, index) {
        final item = laborList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.technicianName,
                      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.blue.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item.hoursSpent} hrs',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue.shade900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.engineering_outlined, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text(item.craft, style: TextStyle(fontSize: 12, color: Colors.grey.shade700, fontWeight: FontWeight.w500)),
                    const Spacer(),
                    Text(DateFormat('dd MMM, HH:mm').format(item.date),
                        style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ],
                ),
                if (item.remarks.isNotEmpty) ...[
                  const Divider(height: 14),
                  Text(item.remarks, style: TextStyle(fontSize: 12, color: Colors.grey.shade800)),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
