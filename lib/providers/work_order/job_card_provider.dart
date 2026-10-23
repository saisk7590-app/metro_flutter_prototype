import 'package:flutter/material.dart';
import '../../models/work_order/job_card_models.dart';

class JobCardProvider extends ChangeNotifier {
  // Map of WorkOrder ID -> List of Labor records
  final Map<String, List<WorkOrderLabor>> _laborRecords = {
    'WO-2026-0941': [
      WorkOrderLabor(
        id: 'LB-101',
        technicianName: 'Rajesh Verma',
        craft: 'Mechanical Lead',
        hoursSpent: 3.5,
        date: DateTime.now().subtract(const Duration(hours: 4)),
        remarks: 'Caliper guide pin lubrication and slide alignment.',
      ),
      WorkOrderLabor(
        id: 'LB-102',
        technicianName: 'K. Somesh',
        craft: 'Pneumatics Fitter',
        hoursSpent: 2.0,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        remarks: 'Brake cylinder pressure transducer test.',
      ),
    ],
  };

  // Map of WorkOrder ID -> List of Material records
  final Map<String, List<WorkOrderMaterial>> _materialRecords = {
    'WO-2026-0941': [
      const WorkOrderMaterial(
        id: 'MT-501',
        partNumber: 'BP-904-SYN',
        description: 'Sintered Metallic Brake Pad Set (Axle 2)',
        quantity: 4.0,
        unit: 'SETS',
        storeBatch: 'DEPOT-WH-B2',
      ),
      const WorkOrderMaterial(
        id: 'MT-502',
        partNumber: 'LUB-KL-500',
        description: 'Synthetic High-Temp Caliper Grease',
        quantity: 1.0,
        unit: 'TIN',
        storeBatch: 'DEPOT-WH-CHEM',
      ),
    ],
  };

  // Map of WorkOrder ID -> List of Tools records
  final Map<String, List<WorkOrderTool>> _toolRecords = {
    'WO-2026-0941': [
      WorkOrderTool(
        id: 'TL-801',
        toolCode: 'TW-140-CAL',
        toolName: 'Digital Torque Wrench (40-200 Nm)',
        calibrationExpiryDate: DateTime.now().add(const Duration(days: 45)),
        toolGroup: 'Torque & Fastening',
      ),
      WorkOrderTool(
        id: 'TL-802',
        toolCode: 'PG-BCP-01',
        toolName: 'Master Pressure Test Gauge (0-10 Bar)',
        calibrationExpiryDate: DateTime.now().add(const Duration(days: 120)),
        toolGroup: 'Pneumatic Pressure Testing',
      ),
    ],
  };

  // Custom status overrides for Work Orders
  final Map<String, String> _customStatuses = {};
  final Map<String, String> _returnReasons = {};
  final Map<String, DateTime> _rescheduledDates = {};

  List<WorkOrderLabor> getLabor(String woId) =>
      List.unmodifiable(_laborRecords[woId] ?? []);

  List<WorkOrderMaterial> getMaterials(String woId) =>
      List.unmodifiable(_materialRecords[woId] ?? []);

  List<WorkOrderTool> getTools(String woId) =>
      List.unmodifiable(_toolRecords[woId] ?? []);

  double getTotalHours(String woId) {
    final list = _laborRecords[woId] ?? [];
    return list.fold(0.0, (sum, item) => sum + item.hoursSpent);
  }

  String getStatus(String woId, String defaultStatus) =>
      _customStatuses[woId] ?? defaultStatus;

  String? getReturnReason(String woId) => _returnReasons[woId];

  DateTime? getRescheduledDate(String woId) => _rescheduledDates[woId];

  void addLabor(String woId, {
    required String technicianName,
    required String craft,
    required double hoursSpent,
    String remarks = '',
  }) {
    final list = _laborRecords.putIfAbsent(woId, () => []);
    final nextId = 'LB-${DateTime.now().millisecondsSinceEpoch % 10000}';
    list.add(
      WorkOrderLabor(
        id: nextId,
        technicianName: technicianName,
        craft: craft,
        hoursSpent: hoursSpent,
        date: DateTime.now(),
        remarks: remarks,
      ),
    );
    notifyListeners();
  }

  void addMaterial(String woId, {
    required String partNumber,
    required String description,
    required double quantity,
    String unit = 'PCS',
    String storeBatch = 'MAIN-WH-01',
  }) {
    final list = _materialRecords.putIfAbsent(woId, () => []);
    final nextId = 'MT-${DateTime.now().millisecondsSinceEpoch % 10000}';
    list.add(
      WorkOrderMaterial(
        id: nextId,
        partNumber: partNumber,
        description: description,
        quantity: quantity,
        unit: unit,
        storeBatch: storeBatch,
      ),
    );
    notifyListeners();
  }

  void linkTool(String woId, {
    required String toolCode,
    required String toolName,
    required DateTime calibrationExpiryDate,
    String toolGroup = 'Torque & Fastening',
  }) {
    final list = _toolRecords.putIfAbsent(woId, () => []);
    final nextId = 'TL-${DateTime.now().millisecondsSinceEpoch % 10000}';
    list.add(
      WorkOrderTool(
        id: nextId,
        toolCode: toolCode,
        toolName: toolName,
        calibrationExpiryDate: calibrationExpiryDate,
        toolGroup: toolGroup,
      ),
    );
    notifyListeners();
  }

  void updateStatus(String woId, String newStatus) {
    _customStatuses[woId] = newStatus;
    notifyListeners();
  }

  void returnWorkOrder(String woId, String reason) {
    _customStatuses[woId] = 'Returned';
    _returnReasons[woId] = reason;
    notifyListeners();
  }

  void rescheduleWorkOrder(String woId, DateTime newDate, String reason) {
    _customStatuses[woId] = 'Rescheduled';
    _rescheduledDates[woId] = newDate;
    _returnReasons[woId] = reason;
    notifyListeners();
  }
}
