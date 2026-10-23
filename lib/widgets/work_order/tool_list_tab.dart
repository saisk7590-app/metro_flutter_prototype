import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/work_order/job_card_models.dart';

class ToolListTab extends StatelessWidget {
  final List<WorkOrderTool> toolList;
  final VoidCallback onLinkTool;

  const ToolListTab({
    super.key,
    required this.toolList,
    required this.onLinkTool,
  });

  @override
  Widget build(BuildContext context) {
    if (toolList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.build_circle_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            const Text('No calibrated tools linked', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text('Use the floating button to link certified depot tools.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 80, left: 14, right: 14),
      itemCount: toolList.length,
      itemBuilder: (context, index) {
        final item = toolList[index];
        final isValid = item.isCalibrated;

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
                      item.toolCode,
                      style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: isValid ? Colors.green.shade50 : Colors.red.shade50,
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: isValid ? Colors.green.shade300 : Colors.red.shade300),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(isValid ? Icons.verified : Icons.warning_rounded,
                              size: 12, color: isValid ? Colors.green.shade800 : Colors.red.shade800),
                          const SizedBox(width: 4),
                          Text(
                            isValid ? 'CALIBRATED' : 'EXPIRED',
                            style: TextStyle(
                              fontSize: 10.5,
                              fontWeight: FontWeight.bold,
                              color: isValid ? Colors.green.shade900 : Colors.red.shade900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.toolName,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
                ),
                const Divider(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Group: ${item.toolGroup}', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
                    Text(
                      'Expires: ${DateFormat('dd MMM yyyy').format(item.calibrationExpiryDate)}',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                        color: isValid ? Colors.grey.shade700 : Colors.red.shade700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
