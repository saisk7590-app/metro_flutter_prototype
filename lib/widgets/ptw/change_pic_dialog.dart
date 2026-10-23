import 'package:flutter/material.dart';

class ChangePicDialog extends StatefulWidget {
  final String ptwId;
  final String currentPicName;
  final String currentPicPhone;
  final String currentCompany;
  final Function(String name, String phone, String company) onConfirm;

  const ChangePicDialog({
    super.key,
    required this.ptwId,
    required this.currentPicName,
    required this.currentPicPhone,
    required this.currentCompany,
    required this.onConfirm,
  });

  @override
  State<ChangePicDialog> createState() => _ChangePicDialogState();
}

class _ChangePicDialogState extends State<ChangePicDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;
  late final TextEditingController _companyController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.currentPicName);
    _phoneController = TextEditingController(text: widget.currentPicPhone);
    _companyController = TextEditingController(text: widget.currentCompany);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _companyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.person_pin_circle_outlined, color: Colors.teal.shade800),
          const SizedBox(width: 8),
          const Text('Handover PIC', style: TextStyle(fontSize: 18)),
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
                'Change Person In Charge (PIC) on site for ${widget.ptwId}:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey),
              ),
              const SizedBox(height: 14),
              const Text('New PIC Full Name', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _nameController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter name' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Emergency Mobile #', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _phoneController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter phone' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Department / Contractor', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _companyController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter department' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.teal.shade800),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onConfirm(
                _nameController.text.trim(),
                _phoneController.text.trim(),
                _companyController.text.trim(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Confirm Handover'),
        ),
      ],
    );
  }
}
