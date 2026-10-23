import 'package:flutter/material.dart';
import '../../models/ptw/ptw_model.dart';

class PtwFilterBar extends StatelessWidget {
  final String searchQuery;
  final PtwStatus? selectedStatus;
  final PtwType? selectedType;
  final ValueChanged<String> onSearchChanged;
  final ValueChanged<PtwStatus?> onStatusChanged;
  final ValueChanged<PtwType?> onTypeChanged;
  final VoidCallback onClear;

  const PtwFilterBar({
    super.key,
    required this.searchQuery,
    required this.selectedStatus,
    required this.selectedType,
    required this.onSearchChanged,
    required this.onStatusChanged,
    required this.onTypeChanged,
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
              hintText: 'Search by PTW#, Location, Corridor or PIC...',
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
                  label: 'In Progress',
                  isSelected: selectedStatus == PtwStatus.started,
                  onTap: () => onStatusChanged(PtwStatus.started),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Approved',
                  isSelected: selectedStatus == PtwStatus.approved,
                  onTap: () => onStatusChanged(PtwStatus.approved),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Pending Approval',
                  isSelected: selectedStatus == PtwStatus.waitingForApproval,
                  onTap: () => onStatusChanged(PtwStatus.waitingForApproval),
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  context,
                  label: 'Draft',
                  isSelected: selectedStatus == PtwStatus.draft,
                  onTap: () => onStatusChanged(PtwStatus.draft),
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
              ? Colors.teal.shade800
              : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? Colors.teal.shade800 : Colors.transparent,
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
