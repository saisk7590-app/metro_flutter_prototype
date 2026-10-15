import '../../data/checklist_default_data.dart';
import '../../models/checklist/checklist_model.dart';
import 'checklist_config_api_service.dart';

export 'checklist_config_api_service.dart';

/// Service handling Work Order Checklists (Mobile Execution & Sync).
/// Configured for 100% offline standalone prototype operation.
class ChecklistApiService extends ChecklistConfigApiService {
  /// Fetch Work Orders for technicians to inspect
  Future<List<ChecklistWorkOrder>> getWorkOrdersForChecklist({
    String woNo = '',
    String unit = '0',
    String status = '0',
  }) async {
    return ChecklistDefaultData.generateDefaultDepotWorkOrders();
  }

  /// Load checklist groups and inspection items for a Work Order
  Future<List<CheckGroupModel>> getWorkOrderChecklistDetails(int workOrderId) async {
    return ChecklistDefaultData.generateDefaultChecklistGroups('Work Order Inspection');
  }

  /// Instant real-time sync of an individual check item
  Future<bool> updateWorkOrderChecksheetItem({
    required int id,
    required int compliance,
    required String remarks,
  }) async {
    return true;
  }

  /// Batch save the entire workorder checksheet
  Future<bool> saveWorkOrderChecksheet({
    required List<CheckGroupModel> groups,
  }) async {
    return true;
  }
}

