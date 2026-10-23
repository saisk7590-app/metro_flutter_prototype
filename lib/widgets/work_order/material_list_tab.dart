import 'package:flutter/material.dart';
import '../../models/work_order/job_card_models.dart';

class MaterialListTab extends StatelessWidget {
  final List<WorkOrderMaterial> materialList;
  final VoidCallback onAddMaterial;

  const MaterialListTab({
    super.key,
    required this.materialList,
    required this.onAddMaterial,
  });

  @override
  Widget build(BuildContext context) {
    if (materialList.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.inventory_2_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            const Text('No materials consumed yet', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text('Use the floating button to issue spare parts from store.', style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 80, left: 14, right: 14),
      itemCount: materialList.length,
      itemBuilder: (context, index) {
        final item = materialList[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 6),
          elevation: 1,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.partNumber,
                      style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade50,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${item.quantity} ${item.unit}',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.orange.shade900),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  item.description,
                  style: TextStyle(fontSize: 13, color: Colors.grey.shade800, fontWeight: FontWeight.w500),
                ),
                const Divider(height: 14),
                Row(
                  children: [
                    Icon(Icons.warehouse_outlined, size: 14, color: Colors.grey.shade600),
                    const SizedBox(width: 4),
                    Text('Batch: ${item.storeBatch}', style: TextStyle(fontSize: 11.5, color: Colors.grey.shade600)),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
