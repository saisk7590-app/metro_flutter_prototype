import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/service_request/service_request_provider.dart';
import '../../widgets/common/custom_header.dart';
import '../../widgets/service_request/service_request_card.dart';
import '../../widgets/service_request/service_request_filter_bar.dart';
import 'new_service_request_screen.dart';
import 'service_request_detail_screen.dart';

class ServiceRequestListScreen extends StatelessWidget {
  final VoidCallback? onSwitchToReport;

  const ServiceRequestListScreen({super.key, this.onSwitchToReport});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final provider = context.watch<ServiceRequestProvider>();
    final activeList = provider.activeRequests;

    return Scaffold(
      backgroundColor: theme.colorScheme.surfaceContainerLowest,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.amber.shade800,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add_alert_rounded),
        label: const Text('Report Fault', style: TextStyle(fontWeight: FontWeight.bold)),
        onPressed: () {
          if (onSwitchToReport != null) {
            onSwitchToReport!();
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NewServiceRequestScreen()),
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Custom Header with Drawer Hamburger
            CustomHeader(
              title: 'SERVICE REQUESTS',
              subtitle: 'Depot Fleet Fault Logging & Tracking',
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
                    label: 'ACTIVE',
                    count: provider.totalActiveCount,
                    color: Colors.blue.shade700,
                  ),
                  const SizedBox(width: 8),
                  _buildMetricTile(
                    label: 'CRITICAL',
                    count: provider.criticalCount,
                    color: Colors.red.shade700,
                  ),
                  const SizedBox(width: 8),
                  _buildMetricTile(
                    label: 'WAITING MATERIAL',
                    count: provider.waitingMaterialCount,
                    color: Colors.purple.shade700,
                  ),
                ],
              ),
            ),

            // Search and Filter Bar
            ServiceRequestFilterBar(
              searchQuery: provider.searchQuery,
              selectedStatus: provider.statusFilter,
              onSearchChanged: provider.setSearchQuery,
              onStatusChanged: provider.setStatusFilter,
              onClear: () => provider.setSearchQuery(''),
            ),

            // Active Tickets List
            Expanded(
              child: activeList.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_turned_in_outlined, size: 54, color: Colors.grey.shade400),
                          const SizedBox(height: 12),
                          Text(
                            'No active service requests found',
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey.shade700),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Try clearing filters or report a new fault ticket.',
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
                        return ServiceRequestCard(
                          request: item,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ServiceRequestDetailScreen(requestId: item.id),
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
