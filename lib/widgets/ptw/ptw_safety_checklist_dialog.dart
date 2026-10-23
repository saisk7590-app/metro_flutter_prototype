import 'package:flutter/material.dart';

class PtwSafetyChecklistDialog extends StatefulWidget {
  final String ptwId;
  final List<String> requiredPrecautions;
  final VoidCallback onAuthorized;

  const PtwSafetyChecklistDialog({
    super.key,
    required this.ptwId,
    required this.requiredPrecautions,
    required this.onAuthorized,
  });

  @override
  State<PtwSafetyChecklistDialog> createState() =>
      _PtwSafetyChecklistDialogState();
}

class _PtwSafetyChecklistDialogState extends State<PtwSafetyChecklistDialog> {
  final Set<int> _checkedIndices = {};

  bool get _allChecked =>
      _checkedIndices.length == widget.requiredPrecautions.length;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.shield_outlined, color: Colors.deepOrange.shade800),
          const SizedBox(width: 8),
          const Text('Pre-Start Safety Gate', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Mandatory site verification for ${widget.ptwId}. You must confirm all safety precautions before starting track/power work:',
              style: const TextStyle(fontSize: 12.5, color: Colors.grey),
            ),
            const SizedBox(height: 12),
            ...widget.requiredPrecautions.asMap().entries.map((entry) {
              final idx = entry.key;
              final text = entry.value;
              final isChecked = _checkedIndices.contains(idx);

              return CheckboxListTile(
                value: isChecked,
                contentPadding: EdgeInsets.zero,
                dense: true,
                title: Text(text, style: const TextStyle(fontSize: 12)),
                activeColor: Colors.deepOrange.shade800,
                onChanged: (val) {
                  setState(() {
                    if (val == true) {
                      _checkedIndices.add(idx);
                    } else {
                      _checkedIndices.remove(idx);
                    }
                  });
                },
              );
            }),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton.icon(
          style: FilledButton.styleFrom(
            backgroundColor: _allChecked ? Colors.deepOrange.shade800 : Colors.grey,
          ),
          icon: const Icon(Icons.play_circle_filled_rounded, size: 16),
          label: const Text('Authorize & Start Work'),
          onPressed: _allChecked
              ? () {
                  widget.onAuthorized();
                  Navigator.pop(context);
                }
              : null,
        ),
      ],
    );
  }
}
