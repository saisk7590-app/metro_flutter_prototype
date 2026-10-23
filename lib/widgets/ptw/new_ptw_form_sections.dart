import 'package:flutter/material.dart';

class PtwPowerBlockCard extends StatelessWidget {
  final bool powerBlock;
  final TextEditingController sectorController;
  final ValueChanged<bool> onToggle;

  const PtwPowerBlockCard({
    super.key,
    required this.powerBlock,
    required this.sectorController,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: powerBlock ? Colors.red.shade50 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: powerBlock ? Colors.red.shade300 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.bolt, color: powerBlock ? Colors.red.shade800 : Colors.grey),
                  const SizedBox(width: 8),
                  const Text(
                    'Requires 25kV Power Block',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                  ),
                ],
              ),
              Switch(
                value: powerBlock,
                activeColor: Colors.red.shade800,
                onChanged: onToggle,
              ),
            ],
          ),
          if (powerBlock) ...[
            const SizedBox(height: 6),
            TextFormField(
              controller: sectorController,
              decoration: InputDecoration(
                labelText: 'Power Block Sector ID',
                hintText: 'e.g. DEPOT-SEC-2B',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class PtwPicFieldsRow extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const PtwPicFieldsRow({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Person In Charge (PIC)', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: nameController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
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
              const Text('PIC Mobile #', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              const SizedBox(height: 6),
              TextFormField(
                controller: phoneController,
                validator: (v) => (v == null || v.trim().isEmpty) ? 'Required' : null,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
