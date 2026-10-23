import 'package:flutter/material.dart';

class LinkToolDialog extends StatefulWidget {
  final String woNo;
  final Function(String code, String name, DateTime expiry, String group) onSave;

  const LinkToolDialog({
    super.key,
    required this.woNo,
    required this.onSave,
  });

  @override
  State<LinkToolDialog> createState() => _LinkToolDialogState();
}

class _LinkToolDialogState extends State<LinkToolDialog> {
  final _formKey = GlobalKey<FormState>();

  final _codeController = TextEditingController(text: 'TW-140-CAL');
  final _nameController = TextEditingController(text: 'Digital Torque Wrench (40-200 Nm)');
  String _selectedGroup = 'Torque & Fastening';
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 60));

  final List<String> _groups = [
    'Torque & Fastening',
    'Pneumatic Pressure Testing',
    'High Voltage Insulation',
    'Optical Alignment & Gauge',
    'Thermal Imaging',
  ];

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.build_circle_outlined, color: Colors.purple.shade700),
          const SizedBox(width: 8),
          const Text('Link Calibrated Tool', style: TextStyle(fontSize: 18)),
        ],
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Associate certified depot tool with ${widget.woNo}:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text('Tool Master Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _codeController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Tool Description', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _nameController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Tool Category / Group', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _selectedGroup,
                items: _groups.map((g) => DropdownMenuItem(value: g, child: Text(g, style: const TextStyle(fontSize: 12.5)))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedGroup = val);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Calibration Expiration Date', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              InkWell(
                onTap: () async {
                  final picked = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate,
                    firstDate: DateTime.now().subtract(const Duration(days: 30)),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (picked != null) setState(() => _selectedDate = picked);
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
                      Text(
                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                      ),
                      const Icon(Icons.calendar_today, size: 16),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.purple.shade700),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSave(
                _codeController.text.trim(),
                _nameController.text.trim(),
                _selectedDate,
                _selectedGroup,
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Link Tool'),
        ),
      ],
    );
  }
}
