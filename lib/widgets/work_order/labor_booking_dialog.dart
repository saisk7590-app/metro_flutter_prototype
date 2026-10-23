import 'package:flutter/material.dart';

class LaborBookingDialog extends StatefulWidget {
  final String woNo;
  final Function(String techName, String craft, double hours, String remarks) onSave;

  const LaborBookingDialog({
    super.key,
    required this.woNo,
    required this.onSave,
  });

  @override
  State<LaborBookingDialog> createState() => _LaborBookingDialogState();
}

class _LaborBookingDialogState extends State<LaborBookingDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController(text: 'Rajesh Verma');
  final _hoursController = TextEditingController(text: '2.5');
  final _remarksController = TextEditingController();

  String _selectedCraft = 'Mechanical Lead';
  final List<String> _crafts = [
    'Mechanical Lead',
    'Pneumatics Fitter',
    'High-Voltage Electrician',
    'Signaling & Telecom Tech',
    'HVAC Technician',
    'General Depot Assistant',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _hoursController.dispose();
    _remarksController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.timer_outlined, color: Colors.blue.shade700),
          const SizedBox(width: 8),
          const Text('Log Labor Hours', style: TextStyle(fontSize: 18)),
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
                'Record active technician time spent on ${widget.woNo}:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text('Technician Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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
              const Text('Craft / Trade', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              DropdownButtonFormField<String>(
                value: _selectedCraft,
                items: _crafts.map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 13)))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedCraft = val);
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Hours Spent', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _hoursController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                validator: (v) {
                  final n = double.tryParse(v ?? '');
                  if (n == null || n <= 0) return 'Enter valid hours';
                  return null;
                },
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  suffixText: 'hrs',
                ),
              ),
              const SizedBox(height: 12),
              const Text('Activity Remarks', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _remarksController,
                decoration: InputDecoration(
                  hintText: 'e.g. Completed slide clearance check',
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSave(
                _nameController.text.trim(),
                _selectedCraft,
                double.parse(_hoursController.text.trim()),
                _remarksController.text.trim(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Save Hours'),
        ),
      ],
    );
  }
}
