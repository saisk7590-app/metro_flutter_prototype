import 'package:flutter/material.dart';

class IssueWorkOrderDialog extends StatefulWidget {
  final String srId;
  final String trainsetId;
  final Function(String woId, String targetBay) onConfirm;

  const IssueWorkOrderDialog({
    super.key,
    required this.srId,
    required this.trainsetId,
    required this.onConfirm,
  });

  @override
  State<IssueWorkOrderDialog> createState() => _IssueWorkOrderDialogState();
}

class _IssueWorkOrderDialogState extends State<IssueWorkOrderDialog> {
  late final TextEditingController _woIdController;
  String _selectedBay = 'Bay 1 (Heavy Overhaul)';

  final List<String> _bays = [
    'Bay 1 (Heavy Overhaul)',
    'Bay 2 (Wheel Trueing)',
    'Bay 3 (Underfloor Inspection)',
    'Bay 4 (Roof & Pantograph)',
    'Bay 5 (Stabling & Minor Repairs)',
  ];

  @override
  void initState() {
    super.initState();
    final randomSuffix = (1000 + DateTime.now().millisecond % 8999).toString();
    _woIdController = TextEditingController(text: 'WO-2026-$randomSuffix');
  }

  @override
  void dispose() {
    _woIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.assignment_turned_in_outlined, color: Colors.indigo.shade700),
          const SizedBox(width: 8),
          const Text('Issue Work Order', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Escalate ${widget.srId} (${widget.trainsetId}) to a corrective Work Order:',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 14),
            const Text('Generated Work Order #', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            TextField(
              controller: _woIdController,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              ),
            ),
            const SizedBox(height: 14),
            const Text('Assign Depot Maintenance Bay', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              initialValue: _selectedBay,
              isExpanded: true,
              items: _bays
                  .map((b) => DropdownMenuItem(value: b, child: Text(b, style: const TextStyle(fontSize: 13))))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedBay = val);
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.indigo.shade700),
          onPressed: () {
            widget.onConfirm(_woIdController.text.trim(), _selectedBay);
            Navigator.pop(context);
          },
          child: const Text('Issue WO'),
        ),
      ],
    );
  }
}
