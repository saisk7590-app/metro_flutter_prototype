import 'package:flutter/material.dart';

class ReturnWorkOrderDialog extends StatefulWidget {
  final String woNo;
  final Function(String reason) onConfirm;

  const ReturnWorkOrderDialog({
    super.key,
    required this.woNo,
    required this.onConfirm,
  });

  @override
  State<ReturnWorkOrderDialog> createState() => _ReturnWorkOrderDialogState();
}

class _ReturnWorkOrderDialogState extends State<ReturnWorkOrderDialog> {
  String _selectedReason = 'Track access denied / occupied by shunting';
  final _remarksController = TextEditingController();

  final List<String> _commonReasons = [
    'Track access denied / occupied by shunting',
    'Traction power block not isolated by TPC',
    'Spare parts / materials unavailable in store',
    'Specialized calibrated tool not available',
    'Adverse weather / roof access unsafe',
    'Other operational blocker',
  ];

  @override
  void dispose() {
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.assignment_return_outlined, color: Colors.red.shade700),
          const SizedBox(width: 8),
          const Text('Return Work Order', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Return job card for ${widget.woNo} to supervisor:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey)),
            const SizedBox(height: 14),
            const Text('Primary Blocker Reason', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            DropdownButtonFormField<String>(
              value: _selectedReason,
              isExpanded: true,
              items: _commonReasons
                  .map((r) => DropdownMenuItem(value: r, child: Text(r, style: const TextStyle(fontSize: 12.5))))
                  .toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedReason = val);
              },
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Detailed Field Remarks', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            TextField(
              controller: _remarksController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter observation details or depot line status...',
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
          style: FilledButton.styleFrom(backgroundColor: Colors.red.shade700),
          onPressed: () {
            final combined = _remarksController.text.trim().isEmpty
                ? _selectedReason
                : '$_selectedReason - ${_remarksController.text.trim()}';
            widget.onConfirm(combined);
            Navigator.pop(context);
          },
          child: const Text('Return WO'),
        ),
      ],
    );
  }
}
