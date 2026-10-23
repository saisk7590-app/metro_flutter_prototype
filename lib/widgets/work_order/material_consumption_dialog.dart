import 'package:flutter/material.dart';

class MaterialConsumptionDialog extends StatefulWidget {
  final String woNo;
  final Function(String partNo, String desc, double qty, String unit, String batch) onSave;

  const MaterialConsumptionDialog({
    super.key,
    required this.woNo,
    required this.onSave,
  });

  @override
  State<MaterialConsumptionDialog> createState() => _MaterialConsumptionDialogState();
}

class _MaterialConsumptionDialogState extends State<MaterialConsumptionDialog> {
  final _formKey = GlobalKey<FormState>();

  final _partNoController = TextEditingController(text: 'BP-904-SYN');
  final _descController = TextEditingController(text: 'Sintered Brake Pad Set');
  final _qtyController = TextEditingController(text: '2.0');
  final _batchController = TextEditingController(text: 'DEPOT-WH-B2');
  String _selectedUnit = 'SETS';

  final List<String> _units = ['SETS', 'PCS', 'TIN', 'LTR', 'MTR', 'KG'];

  @override
  void dispose() {
    _partNoController.dispose();
    _descController.dispose();
    _qtyController.dispose();
    _batchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          Icon(Icons.inventory_2_outlined, color: Colors.orange.shade800),
          const SizedBox(width: 8),
          const Text('Consume Material', style: TextStyle(fontSize: 18)),
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
                'Record spare parts issued for ${widget.woNo}:',
                style: const TextStyle(fontSize: 12.5, color: Colors.grey),
              ),
              const SizedBox(height: 12),
              const Text('Part Number / SKU', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _partNoController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              const Text('Material Description', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _descController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Quantity', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        TextFormField(
                          controller: _qtyController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          validator: (v) {
                            final n = double.tryParse(v ?? '');
                            if (n == null || n <= 0) return 'Invalid';
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Unit', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: _selectedUnit,
                          items: _units.map((u) => DropdownMenuItem(value: u, child: Text(u, style: const TextStyle(fontSize: 13)))).toList(),
                          onChanged: (val) {
                            if (val != null) setState(() => _selectedUnit = val);
                          },
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('Warehouse Store Batch', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              TextFormField(
                controller: _batchController,
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
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.orange.shade800),
          onPressed: () {
            if (_formKey.currentState?.validate() ?? false) {
              widget.onSave(
                _partNoController.text.trim(),
                _descController.text.trim(),
                double.parse(_qtyController.text.trim()),
                _selectedUnit,
                _batchController.text.trim(),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Add Part'),
        ),
      ],
    );
  }
}
