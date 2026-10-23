import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/ptw/ptw_provider.dart';
import '../../widgets/common/custom_header.dart';
import '../../widgets/ptw/ptw_card.dart';
import '../../widgets/ptw/ptw_filter_bar.dart';
import 'new_ptw_screen.dart';
import 'ptw_detail_screen.dart';

class PtwListScreen extends StatelessWidget {
  final VoidCallback? onSwitchToRequest;

  const PtwListScreen({super.key, this.onSwitchToRequest});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<PtwProvider>();
    final activeList = provider.activePermits;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal.shade800,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_moderator_rounded),
        label: const Text('Request PTW', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          if (onSwitchToRequest != null) {
            onSwitchToRequest!();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewPtwScreen()),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            CustomHeader(
              title: 'PERMIT TO WORK',
              subtitle: 'Track Possession & Power Block Safety',
              actions: [
                IconButton(
                  tooltip: 'Reset Filters',
                  icon: const Icon(Icons.refresh_rounded),
                  onPressed: () => provider.resetFilters(),
                ),
              ],
            ),

            // Metrics Summary Strip
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
              child: Row(
                children: [
                  _buildMetricTile(
                    label: 'ACTIVE PERMITS',
                    count: provider.activeCount,
                    color: Colors.teal.shade800,
                  ),
                  const SizedBox(width: 8),
                  _buildMetricTile(
                    label: 'WORK IN PROGRESS',
                    count: provider.workInProgressCount,
                    color: Colors.deepOrange.shade700,
                  ),
                  const SizedBox(width: 8),
                  _buildMetricTile(
                    label: 'PENDING CLEARANCE',
                    count: provider.pendingApprovalCount,
                    color: Colors.amber.shade800,
                  ),
                ],
              ),
            ),

            // Search and Status Filters
            PtwFilterBar(
              searchQuery: provider.searchQuery,
              selectedStatus: provider.statusFilter,
              selectedType: provider.typeFilter,
              onSearchChanged: provider.setSearchQuery,
              onStatusChanged: provider.setStatusFilter,
              onTypeChanged: provider.setTypeFilter,
              onClear: () => provider.setSearchQuery(''),
            ),

            // Active Permits List
            Expanded(
              child: activeList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shield_outlined, size: 54, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'No active safety permits found',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try resetting filters or submit a new permit request.',
                            style: TextStyle(fontSize: 12, color: Colors.grey.shade500),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 8, bottom: 80),
                      itemCount: activeList.length,
                      itemBuilder: (context, index) {
                        final item = activeList[index];
                        return PtwCard(
                          permit: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => PtwDetailScreen(permitId: item.id),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricTile({
    required String label,
    required int count,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              count.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 9.5, fontWeight: FontWeight.bold, color: color.withValues(alpha: 0.8)),
            ),
          ],
        ),
      ),
    );
  }
}
