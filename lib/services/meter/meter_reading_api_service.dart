import '../../models/meter/trainset_meter_reading_model.dart';
import '../base_api_service.dart';

/// Service handling trainset meter readings and recordings.
/// Configured for 100% offline standalone prototype operation.
class MeterReadingApiService extends BaseApiService {
  /// Fetch paginated list of trainset meter readings for a given date
  Future<TrainsetMeterReadingPage> getTrainsetMeterReadings({
    required String date,
    required int pageNo,
    required int pageSize,
    required int pagination,
    required String token,
    required String userSession,
    required String roleId,
  }) async {
    final allItems = List.generate(57, (i) {
      final id = i + 1;
      final tsNo = 'TS ${id.toString().padLeft(2, '0')}';
      final baseReading = 100000 + (id * 2450);
      final prevDate = '2026-10-14';
      final prevReading = '$baseReading';
      final todayRead = (id % 4 == 0) ? '' : '${baseReading + 210}';
      return TrainsetMeterReadingModel(
        assetId: id,
        assetNo: tsNo,
        assetLocation: (id % 2 == 0) ? 9373 : 9374,
        locationCode: (id % 2 == 0) ? 'MYP' : 'UPL',
        locationName: (id % 2 == 0) ? 'Miyapur Depot' : 'Uppal Depot',
        previousDate: prevDate,
        previousDateReading: prevReading,
        todayReading: todayRead,
      );
    });

    final startIndex = (pageNo - 1) * pageSize;
    final pagedItems = (pagination == 1 && startIndex < allItems.length)
        ? allItems.skip(startIndex).take(pageSize).toList()
        : allItems;

    return TrainsetMeterReadingPage(
      items: pagedItems,
      totalRows: allItems.length,
      pageNo: pageNo,
    );
  }

  /// Fetch meter details for a specific trainset, location, and date
  Future<List<Map<String, dynamic>>> getTrainsetMeterDetails({
    required int trainsetId,
    required String location,
    required String date,
    required String token,
    required String userSession,
    required String roleId,
  }) async {
    return [
      {'meter_name': 'Energy Meter - Aux Inverter', 'reading_value': '42120', 'unit': 'kWh'},
      {'meter_name': 'Traction Motor Energy', 'reading_value': '118450', 'unit': 'kWh'},
      {'meter_name': 'Odometer Reading', 'reading_value': '${100000 + trainsetId * 2450}', 'unit': 'km'},
      {'meter_name': 'Auxiliary Battery Voltage', 'reading_value': '110.4', 'unit': 'V'},
    ];
  }

  /// Save or submit newly entered trainset meter readings
  Future<Map<String, dynamic>> addTrainsetMeterReadings({
    required List<Map<String, dynamic>> readings,
    required String token,
    required String userSession,
    required String roleId,
  }) async {
    return {
      'status': 1,
      'success': true,
      'message': 'Meter readings saved successfully (Prototype mode)',
    };
  }
}

