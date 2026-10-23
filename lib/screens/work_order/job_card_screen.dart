import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/checklist/checklist_model.dart';
import '../../providers/checklist/checklist_provider.dart';
import '../../providers/work_order/job_card_provider.dart';
import '../../widgets/work_order/job_card_bottom_bar.dart';
import '../../widgets/work_order/job_card_header.dart';
import '../../widgets/work_order/labor_booking_dialog.dart';
import '../../widgets/work_order/labor_list_tab.dart';
import '../../widgets/work_order/link_tool_dialog.dart';
import '../../widgets/work_order/material_consumption_dialog.dart';
import '../../widgets/work_order/material_list_tab.dart';
import '../../widgets/work_order/tool_list_tab.dart';
import '../checklist/checksheet_detail_screen.dart';

class JobCardScreen extends StatefulWidget {
  final ChecklistWorkOrder workOrder;

  const JobCardScreen({super.key, required this.workOrder});

  @override
  State<JobCardScreen> createState() => _JobCardScreenState();
}

class _JobCardScreenState extends State<JobCardScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() => setState(() {}));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final clProvider = context.read<ChecklistProvider>();
      if (clProvider.configChecklists.isEmpty) {
        clProvider.loadConfigChecklists();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showAddDialog() {
    final wo = widget.workOrder;
    final provider = context.read<JobCardProvider>();

    if (_tabController.index == 1) {
      showDialog(
        context: context,
        builder: (_) => LaborBookingDialog(
          woNo: wo.no,
          onSave: (tech, craft, hrs, rem) => provider.addLabor(
            wo.no,
            technicianName: tech,
            craft: craft,
            hoursSpent: hrs,
            remarks: rem,
          ),
        ),
      );
    } else if (_tabController.index == 2) {
      showDialog(
        context: context,
        builder: (_) => MaterialConsumptionDialog(
          woNo: wo.no,
          onSave: (part, desc, qty, unit, batch) => provider.addMaterial(
            wo.no,
            partNumber: part,
            description: desc,
            quantity: qty,
            unit: unit,
            storeBatch: batch,
          ),
        ),
      );
    } else if (_tabController.index == 3) {
      showDialog(
        context: context,
        builder: (_) => LinkToolDialog(
          woNo: wo.no,
          onSave: (code, name, exp, group) => provider.linkTool(
            wo.no,
            toolCode: code,
            toolName: name,
            calibrationExpiryDate: exp,
            toolGroup: group,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final wo = widget.workOrder;
    final jobProvider = context.watch<JobCardProvider>();
    final currentStatus = jobProvider.getStatus(wo.no, wo.status);
    final totalHours = jobProvider.getTotalHours(wo.no);

    return Scaffold(
      appBar: AppBar(
        title: Text(wo.no, style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        bottom: TabBar(
          controller: _tabController,
          labelColor: theme.primaryColor,
          unselectedLabelColor: Colors.grey.shade600,
          indicatorColor: theme.primaryColor,
          labelStyle: const TextStyle(fontSize: 12.5, fontWeight: FontWeight.bold),
          tabs: const [
            Tab(text: 'Checksheet'),
            Tab(text: 'Labor'),
            Tab(text: 'Materials'),
            Tab(text: 'Tools'),
          ],
        ),
      ),
      floatingActionButton: _tabController.index > 0 ? _buildFab() : null,
      bottomNavigationBar: JobCardBottomBar(woNo: wo.no, status: currentStatus),
      body: SafeArea(
        child: Column(
          children: [
            JobCardHeader(
              woNo: wo.no,
              assetDetails: wo.assetDetails,
              status: currentStatus,
              priority: wo.priority,
              location: wo.location,
              totalHours: totalHours,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildChecksheetPlaceholder(context),
                  LaborListTab(
                    laborList: jobProvider.getLabor(wo.no),
                    onAddLabor: _showAddDialog,
                  ),
                  MaterialListTab(
                    materialList: jobProvider.getMaterials(wo.no),
                    onAddMaterial: _showAddDialog,
                  ),
                  ToolListTab(
                    toolList: jobProvider.getTools(wo.no),
                    onLinkTool: _showAddDialog,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChecksheetPlaceholder(BuildContext context) {
    final clProvider = context.watch<ChecklistProvider>();
    final activeChecklist = clProvider.configChecklists.isNotEmpty
        ? clProvider.configChecklists.first
        : null;

    if (activeChecklist == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.fact_check_outlined, size: 48, color: Colors.grey.shade400),
            const SizedBox(height: 10),
            const Text('Checksheet template active', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      );
    }

    return ChecksheetDetailScreen(
      checklist: activeChecklist,
      onBackToList: () => Navigator.pop(context),
    );
  }

  Widget? _buildFab() {
    String label = '';
    IconData icon = Icons.add;
    Color color = Colors.blue;

    if (_tabController.index == 1) {
      label = 'Log Hours';
      icon = Icons.timer_outlined;
      color = Colors.blue.shade700;
    } else if (_tabController.index == 2) {
      label = 'Add Part';
      icon = Icons.inventory_2_outlined;
      color = Colors.orange.shade800;
    } else if (_tabController.index == 3) {
      label = 'Link Tool';
      icon = Icons.build_circle_outlined;
      color = Colors.purple.shade700;
    }

    return FloatingActionButton.extended(
      backgroundColor: color,
      foregroundColor: Colors.white,
      icon: Icon(icon, size: 18),
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      onPressed: _showAddDialog,
    );
  }
}

