import 'package:flutter/material.dart';

class WaitingMaterialDialog extends StatefulWidget {
  final String srId;
  final ValueChanged<String> onConfirm;

  const WaitingMaterialDialog({
    super.key,
    required this.srId,
    required this.onConfirm,
  });

  @override
  State<WaitingMaterialDialog> createState() => _WaitingMaterialDialogState();
}

class _WaitingMaterialDialogState extends State<WaitingMaterialDialog> {
  final _reasonController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
          Icon(Icons.inventory_2_outlined, color: Colors.purple.shade700),
          const SizedBox(width: 8),
          const Text('Waiting for Material', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Specify the missing part or store requisition reason for ${widget.srId}:',
              style: const TextStyle(fontSize: 13, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _reasonController,
              maxLines: 3,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Please enter a reason' : null,
              decoration: InputDecoration(
                hintText: 'e.g. Awaiting replacement brake pad set #BP-904 from depot store...',
                hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
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
          style: FilledButton.styleFrom(backgroundColor: Colors.purple.shade700),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onConfirm(_reasonController.text.trim());
              Navigator.pop(context);
            }
          },
          child: const Text('Confirm'),
        ),
      ],
    );
  }
}
