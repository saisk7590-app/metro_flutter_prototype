import '../../constants/website_bay_markers.dart';
import '../../models/maintenance_bay/maintenance_bay_model.dart';
import '../base_api_service.dart';

/// Service handling maintenance bay allocations, bay statuses, and history logs.
class MaintenanceBayApiService extends BaseApiService {
  /// Search maintenance bays for a depot
  Future<List<MaintenanceBayModel>> getMaintenanceBay(int depotId) async {
    return _buildFallbackWebBays(depotId);
  }


  static List<MaintenanceBayModel> _buildFallbackWebBays(int depotId) {
    final markers = (depotId == 9373) ? WebsiteBayMarkers.miyapur : WebsiteBayMarkers.uppal;
    final list = <MaintenanceBayModel>[];
    for (int i = 0; i < markers.length; i++) {
      final marker = markers[i];
      final isAlloc = (i % 3 == 0);
      final trainNum = (i ~/ 3) + 1;
      final tsName = 'TS${trainNum.toString().padLeft(3, '0')}';

      list.add(
        MaintenanceBayModel(
          id: 1000 + i,
          slot: i + 1,
          slotName: marker.id,
          slotType: marker.id.contains('SBL') ? 'SBL' : (marker.id.contains('IBL') ? 'IBL' : 'MAIN'),
          trainSetId: isAlloc ? trainNum : 0,
          trainSetName: isAlloc ? tsName : '',
          statusId: isAlloc ? (i % 2 == 0 ? 1 : 2) : 0,
          statusName: isAlloc ? (i % 2 == 0 ? 'Stable' : 'In-Service') : '',
          purposeId: isAlloc ? 1 : 0,
          purposeName: isAlloc ? 'Scheduled Maintenance' : '',
          inward: isAlloc ? DateTime.now().subtract(const Duration(hours: 4)).toIso8601String() : '',
          outward: '',
          remark: isAlloc ? 'Daily Inspection Complete' : '',
          isAllocated: isAlloc,
        ),
      );
    }
    return list;
  }

  /// Get details of a single maintenance bay by its ID
  Future<Map<String, dynamic>> getMaintenanceBayById(int mbId) async {
    return {
      'mb_id': mbId,
      'mb_slot_name': 'Slot $mbId',
      'mb_train_set_name': 'TS 01',
      'mb_status_name': 'Allocated',
      'mb_purpose_name': 'Daily Inspection (A-Check)',
      'mb_inward': DateTime.now().subtract(const Duration(hours: 3)).toIso8601String(),
      'mb_outward': '',
      'mb_remarks': 'Bay track allocation record verified.',
    };
  }

  /// Save or update a maintenance bay record (Inward / Outward)
  Future<Map<String, dynamic>> saveMaintenanceBay({
    required int mbId,
    required int mbDepot,
    required int mbSlot,
    required int mbTrainSet,
    required int mbStatus,
    required int mbPurpose,
    required String mbInward,
    required String mbOutward,
    required String mbRemark,
    bool isOutward = false,
    int? userId,
  }) async {
    return {
      'status': 1,
      'success': true,
      'message': 'Simulated local save (Prototype mode)',
    };
  }

  /// Save maintenance bay allocation record
  Future<Map<String, dynamic>> saveMaintenanceBayAllocation({
    required int mbaMbId,
    required int mbaDepot,
    required int mbaSlot,
    required int mbaTrainSet,
    required int mbaPurpose,
    required int mbaStatus,
    required String mbaAllocatedOn,
    required String mbaAllocatedBy,
    required String mbaRemarks,
    int? userId,
  }) async {
    return {
      'status': 1,
      'success': true,
      'message': 'Simulated local allocation (Prototype mode)',
    };
  }

  /// Fetch historical maintenance bay allocation logs
  Future<List<Map<String, dynamic>>> getMaintenanceBayHistory({
    required String depot,
    String slot = '',
    String trainSet = '',
    String dateFrom = '',
    String dateTo = '',
  }) async {
    return _buildFallbackWebHistory(depot, slot, trainSet);
  }


  static List<Map<String, dynamic>> _buildFallbackWebHistory(
    String depot,
    String slot,
    String trainSet,
  ) {
    final isMiyapur = depot == '9373' || depot.toUpperCase().contains('MIYAPUR');
    final prefix = isMiyapur ? 'MP' : 'UPL';
    final result = <Map<String, dynamic>>[];

    for (int i = 1; i <= 15; i++) {
      final tsNum = (trainSet.isNotEmpty && trainSet != '0')
          ? trainSet
          : (i <= 9 ? 'TS00$i' : 'TS0$i');
      final bayName = slot.isNotEmpty
          ? slot
          : '${prefix}SBL${i}BE';
      final status = i % 3 == 0
          ? 'Under Maintenance'
          : (i % 2 == 0 ? 'In-Service' : 'Stable');
      final purpose = i % 3 == 0
          ? 'Scheduled Inspection'
          : (i % 2 == 0 ? 'Wheel Reprofiling' : 'Routine Maintenance');
      final date = DateTime.now().subtract(Duration(days: i, hours: i * 2));
      final dateStr =
          '${date.day.toString().padLeft(2, '0')}-${date.month.toString().padLeft(2, '0')}-${date.year} ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';

      result.add({
        'mbh_slot_name': bayName,
        'mbaSlotName': bayName,
        'slotName': bayName,
        'mbh_train_set_name': tsNum,
        'mbaTrainSetName': tsNum,
        'trainSetName': tsNum,
        'mbh_status_name': status,
        'mbaStatusName': status,
        'statusName': status,
        'mbh_purpose_name': purpose,
        'mbaPurposeName': purpose,
        'purposeName': purpose,
        'mbh_inward': dateStr,
        'mbaAllocatedOn': dateStr,
        'created_on': dateStr,
        'mbh_remarks': 'Bay track allocation record #$i verified.',
        'mbaRemarks': 'Bay track allocation record #$i verified.',
        'remarks': 'Bay track allocation record #$i verified.',
      });
    }
    return result;
  }
}
