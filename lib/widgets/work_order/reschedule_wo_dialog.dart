import 'package:flutter/material.dart';

class RescheduleWorkOrderDialog extends StatefulWidget {
  final String woNo;
  final Function(DateTime newDate, String reason) onConfirm;

  const RescheduleWorkOrderDialog({
    super.key,
    required this.woNo,
    required this.onConfirm,
  });

  @override
  State<RescheduleWorkOrderDialog> createState() => _RescheduleWorkOrderDialogState();
}

class _RescheduleWorkOrderDialogState extends State<RescheduleWorkOrderDialog> {
  final _reasonController = TextEditingController();
  DateTime _newDate = DateTime.now().add(const Duration(days: 1));

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.schedule_send_outlined, color: Colors.amber.shade800),
          const SizedBox(width: 8),
          const Text('Reschedule Work Order', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Request deferral or rescheduling for ${widget.woNo}:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey)),
            const SizedBox(height: 14),
            const Text('New Target Maintenance Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            InkWell(
              onTap: () async {
                final picked = await showDatePicker(
                  context: context,
                  initialDate: _newDate,
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 60)),
                );
                if (picked != null) setState(() => _newDate = picked);
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${_newDate.day}/${_newDate.month}/${_newDate.year}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    const Icon(Icons.calendar_month, size: 16),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            const Text('Rescheduling Reason', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            TextField(
              controller: _reasonController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'e.g. Trainset delayed in revenue traffic; shift deferred to Night Stabling Window.',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.amber.shade800),
          onPressed: () {
            if (_reasonController.text.trim().isNotEmpty) {
              widget.onConfirm(_newDate, _reasonController.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('Confirm Reschedule'),
        ),
      ],
    );
  }
}
