import '../../data/wheel_measurement_default_data.dart';
import '../../models/wheel/wheel_measurement_model.dart';
import '../base_api_service.dart';

/// Service handling wheel measurements inspection, history, and submission.
/// Configured for 100% offline standalone prototype operation.
class WheelMeasurementApiService extends BaseApiService {
  /// Fetch wheel measurements history list
  Future<List<WheelMeasurementListItem>> getWheelMeasurementsList({
    String trainSet = '0',
    String schedule = '0',
    String from = '',
    String to = '',
    int pageNo = 1,
    int pageSize = 20,
  }) async {
    return [
      WheelMeasurementListItem(
        id: 1,
        woId: 1001,
        woNumber: 'WO-2024-0101',
        tsId: 1,
        tsNumber: 'TS 01',
        measuredDate: '2026-10-10',
        schedule: 'Daily Pre-Service Inspection',
        scheduleId: 1,
        kmReading: 124500.0,
        lastMeasuredSchedule: '30-Day Check',
        lastKmReading: 122100.0,
        remarks: 'All flange and wheel diameter parameters within tolerance.',
        averageDia: 840.1,
      ),
      WheelMeasurementListItem(
        id: 2,
        woId: 1002,
        woNumber: 'WO-2024-0102',
        tsId: 3,
        tsNumber: 'TS 03',
        measuredDate: '2026-10-08',
        schedule: 'Weekly Bogie PM',
        scheduleId: 2,
        kmReading: 135200.0,
        lastMeasuredSchedule: 'Weekly Bogie PM',
        lastKmReading: 132400.0,
        remarks: 'Axle 2 RHS flange thickness checked.',
        averageDia: 839.9,
      ),
      WheelMeasurementListItem(
        id: 3,
        woId: 1003,
        woNumber: 'WO-2024-0103',
        tsId: 7,
        tsNumber: 'TS 07',
        measuredDate: '2026-10-05',
        schedule: 'Wheel Turning & Profiling',
        scheduleId: 4,
        kmReading: 148900.0,
        lastMeasuredSchedule: 'Wheel Turning',
        lastKmReading: 146100.0,
        remarks: 'Reprofiled bogie 1 wheels; test run complete.',
        averageDia: 841.0,
      ),
    ];
  }

  /// Get measurement entry template/details for a Work Order & Trainset
  Future<WheelMeasurementData?> getWheelMeasurementDetails({
    required int woId,
    required int tsId,
  }) async {
    final effectiveTsId = tsId > 0 ? tsId : 1;
    final effectiveWoId = woId > 0 ? woId : 1001;
    final tsStr = 'TS ${effectiveTsId.toString().padLeft(2, '0')}';

    return WheelMeasurementData(
      woId: effectiveWoId,
      trainsetId: effectiveTsId,
      trainsetNo: tsStr,
      scheduleId: 1,
      scheduleCode: 'A-CHECK',
      remarks: 'Inspection template initialized.',
      kmReading: 124500.0,
      lastKmReading: 121800.0,
      lastMeasurePurpose: 'Daily Inspection',
      measuredDate: DateTime.now().toIso8601String().split('T').first,
      cars: WheelMeasurementDefaultData.generateDefaultCarHierarchy(),
    );
  }

  /// Save wheel measurements to database
  Future<bool> saveWheelMeasurementDetails(WheelMeasurementData data) async {
    return true;
  }
}

