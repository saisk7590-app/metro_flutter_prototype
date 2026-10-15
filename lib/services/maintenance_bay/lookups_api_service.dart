import '../../models/maintenance_bay/maintenance_purpose_model.dart';
import '../../models/maintenance_bay/status_model.dart';
import '../../models/maintenance_bay/train_model.dart';
import '../base_api_service.dart';

/// Service handling asset lookups, maintenance statuses, purposes, and trainset lists.
/// Configured for 100% offline standalone prototype operation.
class LookupsApiService extends BaseApiService {
  /// Fetch maintenance bay statuses (lookups)
  Future<List<StatusModel>> getMaintenanceStatus() async {
    return [
      StatusModel(id: 1, name: 'Allocated'),
      StatusModel(id: 2, name: 'Available'),
      StatusModel(id: 3, name: 'Under Maintenance'),
      StatusModel(id: 4, name: 'Stabled'),
    ];
  }

  /// Fetch maintenance schedule types / purposes
  Future<List<MaintenancePurposeModel>> getMaintenancePurposes() async {
    return [
      MaintenancePurposeModel(id: 1, name: 'Daily Inspection (A-Check)'),
      MaintenancePurposeModel(id: 2, name: 'Weekly Bogie PM (B-Check)'),
      MaintenancePurposeModel(id: 3, name: 'Monthly HV & Traction Check'),
      MaintenancePurposeModel(id: 4, name: 'Wheel Turning & Profiling'),
      MaintenancePurposeModel(id: 5, name: 'HVAC Seasonal Overhaul'),
      MaintenancePurposeModel(id: 6, name: 'Corrective Repair'),
    ];
  }

  /// Fetch list of all trainsets (TS 01 to TS 57)
  Future<List<TrainModel>> getTrainSets({
    String? token,
    String? userSession,
    String? roleId,
  }) async {
    return List.generate(57, (i) {
      final id = i + 1;
      final num = id.toString().padLeft(2, '0');
      return TrainModel(id: id, no: 'TS $num');
    });
  }
}

