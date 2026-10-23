import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/service_request/service_request_model.dart';
import '../../providers/service_request/service_request_provider.dart';
import '../../widgets/service_request/issue_wo_dialog.dart';
import '../../widgets/service_request/sr_priority_badge.dart';
import '../../widgets/service_request/sr_status_chip.dart';
import '../../widgets/service_request/waiting_material_dialog.dart';

class ServiceRequestDetailScreen extends StatelessWidget {
  final String requestId;

  const ServiceRequestDetailScreen({super.key, required this.requestId});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServiceRequestProvider>();
    final request = provider.allRequests.firstWhere(
      (r) => r.id == requestId,
      orElse: () => provider.allRequests.first,
    );

    final isClosed = request.status == ServiceRequestStatus.closed ||
        request.status == ServiceRequestStatus.cancelled;

    return Scaffold(
      appBar: AppBar(
        title: Text(request.id, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 14),
            child: SrPriorityBadge(priority: request.priority),
          ),
        ],
      ),
      bottomNavigationBar: isClosed ? null : _buildBottomActions(context, request),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Status Banner Card
            _buildStatusCard(context, request),
            const SizedBox(height: 14),

            // Fault Summary & Description Card
            _buildCard(
              title: 'Fault Description',
              icon: Icons.description_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    request.title,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    request.description,
                    style: TextStyle(fontSize: 13.5, color: Colors.grey.shade800, height: 1.4),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Asset & Subsystem Info
            _buildCard(
              title: 'Asset Equipment Details',
              icon: Icons.train_rounded,
              child: Column(
                children: [
                  _infoRow('Trainset', request.trainsetId),
                  _infoRow('Car Unit', request.carNumber),
                  _infoRow('Subsystem', request.subsystem),
                  _infoRow('Fault Code', request.faultCode),
                  if (request.workOrderId != null)
                    _infoRow('Linked Work Order', request.workOrderId!, isHighlight: true),
                  if (request.waitingReason != null)
                    _infoRow('Waiting Reason', request.waitingReason!, isHighlight: true),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Reporter & Timeline
            _buildCard(
              title: 'Personnel & Logging Info',
              icon: Icons.person_outline,
              child: Column(
                children: [
                  _infoRow('Reported By', request.reportedBy),
                  _infoRow('Reported At', DateFormat('dd MMM yyyy, HH:mm').format(request.reportedAt)),
                  _infoRow('Assigned Lead', request.assignedTo ?? 'Unassigned'),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Activity History & Notes
            _buildCard(
              title: 'Activity Log (${request.notes.length})',
              icon: Icons.history_rounded,
              child: Column(
                children: request.notes.map((n) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.circle, size: 7, color: Colors.grey),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(n, style: const TextStyle(fontSize: 12.5)),
                        ),
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

  Widget _buildStatusCard(BuildContext context, ServiceRequest request) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.amber.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.amber.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('CURRENT TICKET STATUS', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.amber.shade900)),
              const SizedBox(height: 4),
              SrStatusChip(status: request.status),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.amber.shade200),
            ),
            child: Text(
              '${request.trainsetId} • ${request.carNumber}',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.amber.shade900),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey.shade700),
              const SizedBox(width: 6),
              Text(title, style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold, color: Colors.grey.shade800)),
            ],
          ),
          const Divider(height: 16),
          child,
        ],
      ),
    );
  }

  Widget _infoRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: 12.5, color: Colors.grey.shade600)),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 12.5,
                fontWeight: isHighlight ? FontWeight.bold : FontWeight.w600,
                color: isHighlight ? Colors.indigo.shade800 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomActions(BuildContext context, ServiceRequest request) {
    final provider = context.read<ServiceRequestProvider>();

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey.shade200)),
        ),
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          alignment: WrapAlignment.end,
          children: [
            if (request.status == ServiceRequestStatus.open)
              OutlinedButton.icon(
                icon: const Icon(Icons.play_arrow_rounded, size: 16),
                label: const Text('Start Work'),
                onPressed: () => provider.updateStatus(request.id, ServiceRequestStatus.inProgress),
              ),
            if (request.status == ServiceRequestStatus.inProgress)
              OutlinedButton.icon(
                icon: const Icon(Icons.inventory_2_outlined, size: 16),
                label: const Text('Waiting Material'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => WaitingMaterialDialog(
                      srId: request.id,
                      onConfirm: (reason) => provider.updateStatus(
                        request.id,
                        ServiceRequestStatus.waitingForMaterial,
                        waitingReason: reason,
                        note: 'Marked Waiting for Material: $reason',
                      ),
                    ),
                  );
                },
              ),
            if (request.status != ServiceRequestStatus.workOrderIssued)
              FilledButton.icon(
                style: FilledButton.styleFrom(backgroundColor: Colors.indigo.shade700),
                icon: const Icon(Icons.assignment_turned_in_outlined, size: 16),
                label: const Text('Issue WO'),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => IssueWorkOrderDialog(
                      srId: request.id,
                      trainsetId: request.trainsetId,
                      onConfirm: (woId, bay) => provider.issueWorkOrder(request.id, woId, targetBay: bay),
                    ),
                  );
                },
              ),
            FilledButton.icon(
              style: FilledButton.styleFrom(backgroundColor: Colors.green.shade700),
              icon: const Icon(Icons.check_circle_outline, size: 16),
              label: const Text('Resolve Ticket'),
              onPressed: () => provider.updateStatus(request.id, ServiceRequestStatus.closed, note: 'Service Request resolved on floor.'),
            ),
          ],
        ),
      ),
    );
  }
}
