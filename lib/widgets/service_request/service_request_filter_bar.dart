import 'package:flutter/material.dart';
import '../../models/service_request/service_request_model.dart';

class ServiceRequestFilterBar extends StatelessWidget {
  final String searchQuery;
  final ServiceRequestStatus? selectedStatus;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<ServiceRequestStatus?> onStatusChanged;
  final VoidCallback onClear;

  const ServiceRequestFilterBar({
    super.key,
    required this.searchQuery,
    required this.selectedStatus,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search TextField
          TextField(
            onChanged: onSearchChanged,
            decoration: InputDecoration(
              hintText: 'Search by SR#, Trainset, Car or Subsystem...',
              hintStyle: TextStyle(fontSize: 13, color: Colors.grey.shade500),
              prefixIcon: const Icon(Icons.search, size: 20),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, size: 18),
                      onPressed: onClear,
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 10),
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 10),

          // Horizontal Status Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  context,
                  label: 'All Active',
                  isSelected: selectedStatus == null,
                  onTap: () => onStatusChanged(null),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Open',
                  isSelected: selectedStatus == ServiceRequestStatus.open,
                  onTap: () => onStatusChanged(ServiceRequestStatus.open),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'In Progress',
                  isSelected: selectedStatus == ServiceRequestStatus.inProgress,
                  onTap: () => onStatusChanged(ServiceRequestStatus.inProgress),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Waiting for Material',
                  isSelected: selectedStatus == ServiceRequestStatus.waitingForMaterial,
                  onTap: () => onStatusChanged(ServiceRequestStatus.waitingForMaterial),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'WO Issued',
                  isSelected: selectedStatus == ServiceRequestStatus.workOrderIssued,
                  onTap: () => onStatusChanged(ServiceRequestStatus.workOrderIssued),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.primaryColor
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.primaryColor : Colors.transparent,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? Colors.white : theme.colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
