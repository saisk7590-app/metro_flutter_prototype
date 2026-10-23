class WorkOrderLabor {
  final String id;
  final String technicianName;
  final String craft;
  final double hoursSpent;
  final DateTime date;
  final String remarks;

  const WorkOrderLabor({
    required this.id,
    required this.technicianName,
    required this.craft,
    required this.hoursSpent,
    required this.date,
    this.remarks = '',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'technicianName': technicianName,
        'craft': craft,
        'hoursSpent': hoursSpent,
        'date': date.toIso8601String(),
        'remarks': remarks,
      };

  factory WorkOrderLabor.fromJson(Map<String, dynamic> json) => WorkOrderLabor(
        id: json['id'] as String,
        technicianName: json['technicianName'] as String,
        craft: json['craft'] as String,
        hoursSpent: (json['hoursSpent'] as num).toDouble(),
        date: DateTime.parse(json['date'] as String),
        remarks: json['remarks'] as String? ?? '',
      );
}

class WorkOrderMaterial {
  final String id;
  final String partNumber;
  final String description;
  final double quantity;
  final String unit;
  final String storeBatch;

  const WorkOrderMaterial({
    required this.id,
    required this.partNumber,
    required this.description,
    required this.quantity,
    this.unit = 'PCS',
    this.storeBatch = 'MAIN-WH-01',
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'partNumber': partNumber,
        'description': description,
        'quantity': quantity,
        'unit': unit,
        'storeBatch': storeBatch,
      };

  factory WorkOrderMaterial.fromJson(Map<String, dynamic> json) =>
      WorkOrderMaterial(
        id: json['id'] as String,
        partNumber: json['partNumber'] as String,
        description: json['description'] as String,
        quantity: (json['quantity'] as num).toDouble(),
        unit: json['unit'] as String? ?? 'PCS',
        storeBatch: json['storeBatch'] as String? ?? 'MAIN-WH-01',
      );
}

class WorkOrderTool {
  final String id;
  final String toolCode;
  final String toolName;
  final DateTime calibrationExpiryDate;
  final String toolGroup;

  const WorkOrderTool({
    required this.id,
    required this.toolCode,
    required this.toolName,
    required this.calibrationExpiryDate,
    this.toolGroup = 'Torque & Fastening',
  });

  bool get isCalibrated => calibrationExpiryDate.isAfter(DateTime.now());

  Map<String, dynamic> toJson() => {
        'id': id,
        'toolCode': toolCode,
        'toolName': toolName,
        'calibrationExpiryDate': calibrationExpiryDate.toIso8601String(),
        'toolGroup': toolGroup,
      };

  factory WorkOrderTool.fromJson(Map<String, dynamic> json) => WorkOrderTool(
        id: json['id'] as String,
        toolCode: json['toolCode'] as String,
        toolName: json['toolName'] as String,
        calibrationExpiryDate:
            DateTime.parse(json['calibrationExpiryDate'] as String),
        toolGroup: json['toolGroup'] as String? ?? 'Torque & Fastening',
      );
}
