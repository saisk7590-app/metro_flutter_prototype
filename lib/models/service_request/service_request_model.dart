enum ServiceRequestPriority {
  critical,
  high,
  medium,
  low;

  String get label {
    switch (this) {
      case ServiceRequestPriority.critical:
        return 'Critical';
      case ServiceRequestPriority.high:
        return 'High';
      case ServiceRequestPriority.medium:
        return 'Medium';
      case ServiceRequestPriority.low:
        return 'Low';
    }
  }
}

enum ServiceRequestStatus {
  open,
  inProgress,
  waitingForMaterial,
  workOrderIssued,
  closed,
  cancelled;

  String get label {
    switch (this) {
      case ServiceRequestStatus.open:
        return 'Open';
      case ServiceRequestStatus.inProgress:
        return 'In Progress';
      case ServiceRequestStatus.waitingForMaterial:
        return 'Waiting for Material';
      case ServiceRequestStatus.workOrderIssued:
        return 'WO Issued';
      case ServiceRequestStatus.closed:
        return 'Closed';
      case ServiceRequestStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class ServiceRequest {
  final String id;
  final String trainsetId;
  final String carNumber;
  final String subsystem;
  final String faultCode;
  final String title;
  final String description;
  final ServiceRequestPriority priority;
  final ServiceRequestStatus status;
  final String reportedBy;
  final DateTime reportedAt;
  final String? assignedTo;
  final String? workOrderId;
  final String? waitingReason;
  final List<String> notes;

  const ServiceRequest({
    required this.id,
    required this.trainsetId,
    required this.carNumber,
    required this.subsystem,
    required this.faultCode,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.reportedBy,
    required this.reportedAt,
    this.assignedTo,
    this.workOrderId,
    this.waitingReason,
    this.notes = const [],
  });

  ServiceRequest copyWith({
    String? id,
    String? trainsetId,
    String? carNumber,
    String? subsystem,
    String? faultCode,
    String? title,
    String? description,
    ServiceRequestPriority? priority,
    ServiceRequestStatus? status,
    String? reportedBy,
    DateTime? reportedAt,
    String? assignedTo,
    String? workOrderId,
    String? waitingReason,
    List<String>? notes,
  }) {
    return ServiceRequest(
      id: id ?? this.id,
      trainsetId: trainsetId ?? this.trainsetId,
      carNumber: carNumber ?? this.carNumber,
      subsystem: subsystem ?? this.subsystem,
      faultCode: faultCode ?? this.faultCode,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      reportedBy: reportedBy ?? this.reportedBy,
      reportedAt: reportedAt ?? this.reportedAt,
      assignedTo: assignedTo ?? this.assignedTo,
      workOrderId: workOrderId ?? this.workOrderId,
      waitingReason: waitingReason ?? this.waitingReason,
      notes: notes ?? this.notes,
    );
  }
}
