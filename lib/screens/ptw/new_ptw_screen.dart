import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/ptw/ptw_model.dart';
import '../../providers/ptw/ptw_provider.dart';
import '../../widgets/common/custom_header.dart';
import '../../widgets/ptw/new_ptw_form_sections.dart';

class NewPtwScreen extends StatefulWidget {
  final VoidCallback? onCompleted;

  const NewPtwScreen({super.key, this.onCompleted});

  @override
  State<NewPtwScreen> createState() => _NewPtwScreenState();
}

class _NewPtwScreenState extends State<NewPtwScreen> {
  final _formKey = GlobalKey<FormState>();

  PtwType _selectedType = PtwType.powerBlockOHE;
  String _selectedCorridor = 'Miyapur Depot Yard';
  bool _powerBlock = true;

  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _locationController = TextEditingController(text: 'Stabling Line 3 (Mast 302-308)');
  final _woController = TextEditingController(text: 'WO-2026-0960');
  final _picNameController = TextEditingController(text: 'S. K. Nagesh (Traction)');
  final _picPhoneController = TextEditingController(text: '+91 98490 22340');
  final _sectorController = TextEditingController(text: 'DEPOT-SECTOR-2B');

  final List<String> _corridors = [
    'Miyapur Depot Yard',
    'Corridor 1 (Red Line - Miyapur to LB Nagar)',
    'Corridor 2 (Green Line - JBS to MGBS)',
    'Corridor 3 (Blue Line - Nagole to Raidurg)',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _locationController.dispose();
    _woController.dispose();
    _picNameController.dispose();
    _picPhoneController.dispose();
    _sectorController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final now = DateTime.now();
    context.read<PtwProvider>().createPermit(
      type: _selectedType,
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      corridor: _selectedCorridor,
      location: _locationController.text.trim(),
      workOrderId: _woController.text.trim().isEmpty ? null : _woController.text.trim(),
      picName: _picNameController.text.trim(),
      picPhone: _picPhoneController.text.trim(),
      picCompany: 'Depot Maintenance Division',
      startTime: now.add(const Duration(hours: 1)),
      endTime: now.add(const Duration(hours: 5)),
      powerBlockRequired: _powerBlock,
      powerBlockSector: _powerBlock ? _sectorController.text.trim() : null,
      safetyPrecautions: [
        'Site isolation and red flags at 500m mandatory',
        if (_powerBlock) 'Discharge rods to be verified by TPC before touching OHE',
        'All personnel in High-Visibility PPE with safety boots',
      ],
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Permit to Work request submitted for Controller clearance!'),
        backgroundColor: Colors.teal.shade800,
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
              title: 'REQUEST PTW',
              subtitle: 'Line Access & Power Isolation Safety Permit',
              actions: [
                IconButton(
                  tooltip: 'Reset Form',
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () {
                    _formKey.currentState?.reset();
                    _titleController.clear();
                    _descController.clear();
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
                    const Text('Permit Category', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<PtwType>(
                      initialValue: _selectedType,
                      items: PtwType.values
                          .map((t) => DropdownMenuItem(value: t, child: Text(t.label, style: const TextStyle(fontSize: 13))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) {
                          setState(() {
                            _selectedType = val;
                            _powerBlock = val == PtwType.powerBlockOHE;
                          });
                        }
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 14),

                    const Text('Operating Corridor', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    DropdownButtonFormField<String>(
                      initialValue: _selectedCorridor,
                      items: _corridors
                          .map((c) => DropdownMenuItem(value: c, child: Text(c, style: const TextStyle(fontSize: 12.5))))
                          .toList(),
                      onChanged: (val) {
                        if (val != null) setState(() => _selectedCorridor = val);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                    const SizedBox(height: 14),

                    const Text('Specific Location / Chainage / Mast', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _locationController,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter specific location' : null,
                      decoration: InputDecoration(
                        hintText: 'e.g. Stabling Line 3 (Mast 302 to 308)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    const Text('Purpose / Scope of Work', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _titleController,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter work purpose' : null,
                      decoration: InputDecoration(
                        hintText: 'e.g. Contact wire dropper inspection & mast bonding check',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    PtwPowerBlockCard(
                      powerBlock: _powerBlock,
                      sectorController: _sectorController,
                      onToggle: (val) => setState(() => _powerBlock = val),
                    ),
                    const SizedBox(height: 14),

                    PtwPicFieldsRow(
                      nameController: _picNameController,
                      phoneController: _picPhoneController,
                    ),
                    const SizedBox(height: 14),

                    const Text('Linked Work Order (Optional)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _woController,
                      decoration: InputDecoration(
                        hintText: 'e.g. WO-2026-0960',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                      ),
                    ),
                    const SizedBox(height: 14),

                    const Text('Detailed Work Scope & Safety Plan', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: _descController,
                      maxLines: 3,
                      validator: (v) => (v == null || v.trim().isEmpty) ? 'Please enter description' : null,
                      decoration: InputDecoration(
                        hintText: 'Specify equipment, scaffolding or boom lift deployment, approach track isolation...',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                    const SizedBox(height: 24),

                    FilledButton.icon(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.teal.shade800,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                      icon: const Icon(Icons.send_rounded),
                      label: const Text('SUBMIT PERMIT REQUEST', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
