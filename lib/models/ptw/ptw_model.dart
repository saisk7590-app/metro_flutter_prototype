enum PtwType {
  powerBlockOHE,
  trackPossession,
  signalingTelecom,
  civilViaduct,
  stationMEP;

  String get label {
    switch (this) {
      case PtwType.powerBlockOHE:
        return 'OHE Power Block (25kV)';
      case PtwType.trackPossession:
        return 'Track Possession';
      case PtwType.signalingTelecom:
        return 'Signaling & Telecom (S&T)';
      case PtwType.civilViaduct:
        return 'Civil & Viaduct';
      case PtwType.stationMEP:
        return 'Station MEP & Hot Work';
    }
  }

  String get code {
    switch (this) {
      case PtwType.powerBlockOHE:
        return 'OHE';
      case PtwType.trackPossession:
        return 'TRK';
      case PtwType.signalingTelecom:
        return 'S&T';
      case PtwType.civilViaduct:
        return 'CIV';
      case PtwType.stationMEP:
        return 'MEP';
    }
  }
}

enum PtwStatus {
  draft,
  waitingForApproval,
  approved,
  started,
  completed,
  closed,
  cancelled;

  String get label {
    switch (this) {
      case PtwStatus.draft:
        return 'Draft';
      case PtwStatus.waitingForApproval:
        return 'Pending Approval';
      case PtwStatus.approved:
        return 'Approved';
      case PtwStatus.started:
        return 'Work In Progress';
      case PtwStatus.completed:
        return 'Work Completed';
      case PtwStatus.closed:
        return 'Line Handed Over';
      case PtwStatus.cancelled:
        return 'Cancelled';
    }
  }
}

class PermitToWork {
  final String id;
  final String permitNumber;
  final PtwType type;
  final PtwStatus status;
  final String title;
  final String description;
  final String corridor;
  final String location;
  final String? workOrderId;
  final String picName;
  final String picPhone;
  final String picCompany;
  final DateTime startTime;
  final DateTime endTime;
  final bool powerBlockRequired;
  final String? powerBlockSector;
  final List<String> safetyPrecautions;
  final String? approvedBy;
  final DateTime? approvalDate;
  final List<String> notes;

  const PermitToWork({
    required this.id,
    required this.permitNumber,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.corridor,
    required this.location,
    this.workOrderId,
    required this.picName,
    required this.picPhone,
    required this.picCompany,
    required this.startTime,
    required this.endTime,
    this.powerBlockRequired = false,
    this.powerBlockSector,
    this.safetyPrecautions = const [],
    this.approvedBy,
    this.approvalDate,
    this.notes = const [],
  });

  PermitToWork copyWith({
    String? id,
    String? permitNumber,
    PtwType? type,
    PtwStatus? status,
    String? title,
    String? description,
    String? corridor,
    String? location,
    String? workOrderId,
    String? picName,
    String? picPhone,
    String? picCompany,
    DateTime? startTime,
    DateTime? endTime,
    bool? powerBlockRequired,
    String? powerBlockSector,
    List<String>? safetyPrecautions,
    String? approvedBy,
    DateTime? approvalDate,
    List<String>? notes,
  }) {
    return PermitToWork(
      id: id ?? this.id,
      permitNumber: permitNumber ?? this.permitNumber,
      type: type ?? this.type,
      status: status ?? this.status,
      title: title ?? this.title,
      description: description ?? this.description,
      corridor: corridor ?? this.corridor,
      location: location ?? this.location,
      workOrderId: workOrderId ?? this.workOrderId,
      picName: picName ?? this.picName,
      picPhone: picPhone ?? this.picPhone,
      picCompany: picCompany ?? this.picCompany,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      powerBlockRequired: powerBlockRequired ?? this.powerBlockRequired,
      powerBlockSector: powerBlockSector ?? this.powerBlockSector,
      safetyPrecautions: safetyPrecautions ?? this.safetyPrecautions,
      approvedBy: approvedBy ?? this.approvedBy,
      approvalDate: approvalDate ?? this.approvalDate,
      notes: notes ?? this.notes,
    );
  }
}
