import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/ptw/ptw_model.dart';
import '../../providers/ptw/ptw_provider.dart';
import '../../widgets/ptw/change_pic_dialog.dart';
import '../../widgets/ptw/ptw_detail_widgets.dart';
import '../../widgets/ptw/ptw_safety_checklist_dialog.dart';
import '../../widgets/ptw/ptw_type_badge.dart';

class PtwDetailScreen extends StatelessWidget {
  final String permitId;

  const PtwDetailScreen({super.key, required this.permitId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<PtwProvider>();
    final permit = provider.allPermits.firstWhere(
      (p) => p.id == permitId,
      orElse: () => provider.allPermits.first,
    );

    final isClosed = permit.status == PtwStatus.closed ||
        permit.status == PtwStatus.cancelled;

    return Scaffold(
      appBar: AppBar(
        title: Text(permit.id, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: PtwTypeBadge(type: permit.type),
          ),
        ],
      ),
      bottomNavigationBar: isClosed ? null : _buildBottomActions(context, permit),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            PtwStatusCard(permit: permit),
            const SizedBox(height: 14),

            PtwSectionCard(
              title: 'Work Purpose & Description',
              icon: Icons.description_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(permit.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(permit.description, style: TextStyle(fontSize: 13, color: Colors.grey.shade800, height: 1.4)),
                ],
              ),
            ),
            const SizedBox(height: 14),

            PtwSectionCard(
              title: 'Track Location & Window',
              icon: Icons.location_on_outlined,
              child: Column(
                children: [
                  PtwInfoRow(label: 'Corridor', value: permit.corridor),
                  PtwInfoRow(label: 'Specific Location', value: permit.location),
                  PtwInfoRow(label: 'Validity Window', value: '${DateFormat('HH:mm').format(permit.startTime)} - ${DateFormat('HH:mm').format(permit.endTime)}'),
                  if (permit.workOrderId != null)
                    PtwInfoRow(label: 'Linked Work Order', value: permit.workOrderId!, isHighlight: true),
                ],
              ),
            ),
            const SizedBox(height: 14),

            PtwSectionCard(
              title: 'Person In Charge (PIC)',
              icon: Icons.person_pin_circle_outlined,
              trailing: permit.status == PtwStatus.started
                  ? TextButton.icon(
                      icon: const Icon(Icons.sync_alt, size: 14),
                      label: const Text('Handover', style: TextStyle(fontSize: 12)),
                      onPressed: () => _openHandoverDialog(context, permit),
                    )
                  : null,
              child: Column(
                children: [
                  PtwInfoRow(label: 'PIC Full Name', value: permit.picName),
                  PtwInfoRow(label: 'Emergency Contact', value: permit.picPhone),
                  PtwInfoRow(label: 'Company / Dept', value: permit.picCompany),
                  if (permit.approvedBy != null)
                    PtwInfoRow(label: 'Approved By', value: permit.approvedBy!, isHighlight: true),
                ],
              ),
            ),
            const SizedBox(height: 14),

            PtwSectionCard(
              title: 'Safety Precautions & Site Isolations',
              icon: Icons.shield_outlined,
              child: Column(
                children: permit.safetyPrecautions.map((s) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline, size: 14, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(child: Text(s, style: const TextStyle(fontSize: 12.5))),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 14),

            PtwSectionCard(
              title: 'Audit & Authorization Log',
              icon: Icons.history_rounded,
              child: Column(
                children: permit.notes.map((n) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.5),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, size: 7, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(child: Text(n, style: const TextStyle(fontSize: 12.5))),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  void _openHandoverDialog(BuildContext context, PermitToWork permit) {
    showDialog(
      context: context,
      builder: (_) => ChangePicDialog(
        ptwId: permit.id,
        currentPicName: permit.picName,
        currentPicPhone: permit.picPhone,
        currentCompany: permit.picCompany,
        onConfirm: (name, phone, company) => context.read<PtwProvider>().changePic(permit.id, name, phone, company),
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, PermitToWork permit) {
    final provider = context.read<PtwProvider>();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, border: Border(top: BorderSide(color: Colors.grey.shade200))),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            if (permit.status == PtwStatus.waitingForApproval)
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.blue.shade700),
                icon: const Icon(Icons.verified_rounded, size: 16),
                label: const Text('Approve Permit (Controller)'),
                onPressed: () => provider.approvePermit(permit.id, 'V. R. Murthy (Chief Controller)'),
              ),
            if (permit.status == PtwStatus.approved)
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.deepOrange.shade800),
                icon: const Icon(Icons.play_circle_filled_rounded, size: 16),
                label: const Text('Verify & Start Work'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => PtwSafetyChecklistDialog(
                      ptwId: permit.id,
                      requiredPrecautions: permit.safetyPrecautions,
                      onAuthorized: () => provider.startPermit(permit.id),
                    ),
                  );
                },
              ),
            if (permit.status == PtwStatus.started)
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.teal.shade800),
                icon: const Icon(Icons.task_alt_rounded, size: 16),
                label: const Text('Complete Work'),
                onPressed: () => provider.completePermit(permit.id),
              ),
            if (permit.status == PtwStatus.completed)
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.green.shade700),
                icon: const Icon(Icons.check_circle_rounded, size: 16),
                label: const Text('Close & Hand Over Line'),
                onPressed: () => provider.closePermit(permit.id),
              ),
          ],
        ),
      ),
    );
  }
}
