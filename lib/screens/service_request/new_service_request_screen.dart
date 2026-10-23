import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/service_request/service_request_model.dart';
import '../../providers/service_request/service_request_provider.dart';
import '../../widgets/common/custom_header.dart';

class NewServiceRequestScreen extends StatefulWidget {
  final VoidCallback? onCompleted;

  const NewServiceRequestScreen({super.key, this.onCompleted});

  @override
  State<NewServiceRequestScreen> createState() => _NewServiceRequestScreenState();
}

class _NewServiceRequestScreenState extends State<NewServiceRequestScreen> {
  final _formKey = GlobalKey<FormState>();

  String _selectedTrainset = 'TS-04';
  String _selectedCar = 'DM1-04';
  String _selectedSubsystem = 'Bogie & Suspension';
  ServiceRequestPriority _selectedPriority = ServiceRequestPriority.high;

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _faultCodeController = TextEditingController(text: 'FC-BG-101');

  final List<String> _trainsets = [
    'TS-01', 'TS-02', 'TS-03', 'TS-04', 'TS-05', 'TS-06',
    'TS-07', 'TS-08', 'TS-09', 'TS-10', 'TS-11', 'TS-12'
  ];

  final List<String> _subsystems = [
    'Bogie & Suspension',
    'HVAC & Climate',
    'Door System',
    'Pneumatics & Brakes',
    'Traction & Propulsion',
    'Pantograph & Roof',
    'Passenger Info System',
    'Signaling & Train Control'
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _faultCodeController.dispose();
    super.dispose();
  }

  void _updateCarForTrainset(String ts) {
    setState(() {
      _selectedTrainset = ts;
      final num = ts.replaceAll('TS-', '');
      _selectedCar = 'DM1-$num';
    });
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    context.read<ServiceRequestProvider>().createServiceRequest(
      trainsetId: _selectedTrainset,
      carNumber: _selectedCar,
      subsystem: _selectedSubsystem,
      faultCode: _faultCodeController.text.trim(),
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      priority: _selectedPriority,
      reportedBy: 'Field Engineer (Mobile Entry)',
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Service Request logged successfully for $_selectedTrainset!'),
        backgroundColor: Colors.green.shade700,
      ),
    );

    if (widget.onCompleted != null) {
      widget.onCompleted!();
    } else {
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'REPORT FAULT',
              subtitle: 'Log fleet fault or component defect',
              actions: [
                IconButton(
                  tooltip: 'Reset Form',
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _titleController.clear();
                    _descController.clear();
                    setState(() {
                      _selectedTrainset = 'TS-04';
                      _selectedCar = 'DM1-04';
                      _selectedSubsystem = 'Bogie & Suspension';
                      _selectedPriority = ServiceRequestPriority.high;
                    });
                  },
                ),
              ],
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
              // Trainset & Car Selector Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Trainset', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        DropdownButtonFormField<String>(
                          initialValue: _selectedTrainset,
                          items: _trainsets.map((t) => DropdownMenuItem(value: t, child: Text(t))).toList(),
                          onChanged: (val) {
                            if (val != null) _updateCarForTrainset(val);
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Car Unit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 6),
                        TextFormField(
                          initialValue: _selectedCar,
                          key: ValueKey(_selectedCar),
                          onChanged: (val) => _selectedCar = val,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              // Subsystem
              const Text('Fault Subsystem', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              DropdownButtonFormField<String>(
                initialValue: _selectedSubsystem,
                items: _subsystems.map((s) => DropdownMenuItem(value: s, child: Text(s))).toList(),
                onChanged: (val) {
                  if (val != null) setState(() => _selectedSubsystem = val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(height: 16),

              // Fault Code
              const Text('Fault Code', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _faultCodeController,
                decoration: InputDecoration(
                  hintText: 'e.g. FC-BG-101',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),

              // Priority Selector
              const Text('Fault Priority / Impact', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Row(
                children: ServiceRequestPriority.values.map((p) {
                  final isSel = _selectedPriority == p;
                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: ChoiceChip(
                        label: Text(p.label, style: TextStyle(fontSize: 11.5, fontWeight: isSel ? FontWeight.bold : FontWeight.normal)),
                        selected: isSel,
                        selectedColor: Colors.amber.shade700,
                        labelStyle: TextStyle(color: isSel ? Colors.white : Colors.black87),
                        onSelected: (_) => setState(() => _selectedPriority = p),
                      ),
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Fault Title
              const Text('Fault Summary / Headline', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _titleController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter a fault summary' : null,
                decoration: InputDecoration(
                  hintText: 'e.g. High friction sound during motor acceleration',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
              const SizedBox(height: 16),

              // Detailed Description
              const Text('Detailed Observation & Diagnostic Notes', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: _descController,
                maxLines: 3,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Please provide detailed description' : null,
                decoration: InputDecoration(
                  hintText: 'Enter symptoms observed, exact location on bogie/roof, diagnostic messages...',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 24),

              // Submit Button
              FilledButton.icon(
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.amber.shade800,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                icon: const Icon(Icons.send_rounded),
                label: const Text('SUBMIT SERVICE REQUEST', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                onPressed: _submit,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ],
  ),
),
);
  }
}
