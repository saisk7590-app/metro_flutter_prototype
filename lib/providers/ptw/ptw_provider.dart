import 'package:flutter/material.dart';
import '../../models/ptw/ptw_model.dart';

class PtwProvider extends ChangeNotifier {
  final List<PermitToWork> _permits = [
    PermitToWork(
      id: 'PTW-2026-0041',
      permitNumber: 'PTW/OHE/2026/041',
      type: PtwType.powerBlockOHE,
      status: PtwStatus.started,
      title: '25kV Overhead Contact Wire Dropper Replacement',
      description:
          'De-energization and isolation of OHE line over Stabling Line 2 and 3. Earth discharge rods positioned at Mast M-201 and M-206. Periodic tension verification.',
      corridor: 'Miyapur Depot Yard',
      location: 'Stabling Line 2 & 3 (Mast 201 to 208)',
      workOrderId: 'WO-2026-0941',
      picName: 'D. Sen (OHE Supervisor)',
      picPhone: '+91 98490 11204',
      picCompany: 'Metro Traction Department',
      startTime: DateTime.now().subtract(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 3)),
      powerBlockRequired: true,
      powerBlockSector: 'DEPOT-SECTOR-2B (25kV Isolated)',
      safetyPrecautions: [
        'Power block permit confirmed from Traction Power Controller (TPC)',
        'Discharge rods applied on both upstream and downstream masts',
        'Red banner flags positioned 500m ahead on both approach tracks',
        'All personnel wearing Class 4 electrical safety gear',
      ],
      approvedBy: 'V. R. Murthy (Chief Controller - TPC)',
      approvalDate: DateTime.now().subtract(const Duration(hours: 3)),
      notes: [
        'Permit approved by TPC at 09:30 AM.',
        'Site isolation verified and work started at 10:15 AM.',
      ],
    ),
    PermitToWork(
      id: 'PTW-2026-0042',
      permitNumber: 'PTW/S&T/2026/042',
      type: PtwType.signalingTelecom,
      status: PtwStatus.waitingForApproval,
      title: 'Point Machine 104A/B Micro-switch Recalibration',
      description:
          'Lock & detector slide test on turnout point 104. Shunting of track circuit 104T required during detection gap measurement.',
      corridor: 'Corridor 1 (Red Line)',
      location: 'Turnout 104 (KM 14.200 to 14.500)',
      workOrderId: 'WO-2026-0955',
      picName: 'Rajesh K. Varma',
      picPhone: '+91 98765 43210',
      picCompany: 'Signaling & Interlocking Unit',
      startTime: DateTime.now().add(const Duration(hours: 1)),
      endTime: DateTime.now().add(const Duration(hours: 4)),
      powerBlockRequired: false,
      safetyPrecautions: [
        'Track circuit occupancy indicator activated with Station Master',
        'Point clamped and padlocked in normal position before inspection',
        'Walkie-talkie link verified with Central Control Room (CCR)',
      ],
      notes: ['Submitted to CCR and Traffic Controller for line clearance.'],
    ),
    PermitToWork(
      id: 'PTW-2026-0043',
      permitNumber: 'PTW/CIV/2026/043',
      type: PtwType.civilViaduct,
      status: PtwStatus.approved,
      title: 'Viaduct Pier P-112 Bearings & Expansion Joint Inspection',
      description:
          'Visual inspection and ultrasonic test on elastomeric bearings under span S-112. Mobile boom lift deployment under viaduct beam.',
      corridor: 'Corridor 2 (Green Line)',
      location: 'Viaduct Piers P-112 to P-116 (Street Level)',
      picName: 'S. Naidu (Civil Lead)',
      picPhone: '+91 94401 22890',
      picCompany: 'Infrastructure & Structures Dept',
      startTime: DateTime.now().add(const Duration(hours: 2)),
      endTime: DateTime.now().add(const Duration(hours: 6)),
      powerBlockRequired: false,
      safetyPrecautions: [
        'Traffic barricades and warning lights arranged at road median',
        'Safety harness secured to lifeline cables',
        'Safety net rigged under span S-112',
      ],
      approvedBy: 'K. Mohan Rao (Chief Civil Engineer)',
      approvalDate: DateTime.now().subtract(const Duration(hours: 1)),
      notes: ['Approved. Awaiting technician team mobilization on site.'],
    ),
    PermitToWork(
      id: 'PTW-2026-0044',
      permitNumber: 'PTW/TRK/2026/044',
      type: PtwType.trackPossession,
      status: PtwStatus.draft,
      title: 'Ultrasonic Flaw Detection (USFD) Rail Testing',
      description:
          'Routine trolley-mounted ultrasonic weld testing on Up Main Line between Secunderabad East and Mettuguda.',
      corridor: 'Corridor 3 (Blue Line)',
      location: 'Up Main Line (KM 08.400 to 11.200)',
      picName: 'P. Anand (PW Inspector)',
      picPhone: '+91 93902 44510',
      picCompany: 'Permanent Way Team',
      startTime: DateTime.now().add(const Duration(hours: 5)),
      endTime: DateTime.now().add(const Duration(hours: 9)),
      powerBlockRequired: false,
      safetyPrecautions: [
        'Track possession block requested from Traffic Controller',
        'Lookout men with red hand signals stationed 600m on both ends',
      ],
      notes: ['Draft created by Permanent Way office.'],
    ),
    PermitToWork(
      id: 'PTW-2026-0038',
      permitNumber: 'PTW/MEP/2026/038',
      type: PtwType.stationMEP,
      status: PtwStatus.completed,
      title: 'Hot Work Welding on Chilled Water Manifold',
      description:
          'Oxy-acetylene cutting and welding for bypass pipe insertion on chiller pump #3 in station plant room.',
      corridor: 'Corridor 1 (Red Line)',
      location: 'Ameerpet Station (Basement Plant Room)',
      picName: 'M. Qasim (Mechanical Lead)',
      picPhone: '+91 97003 11844',
      picCompany: 'Station Facilities Team',
      startTime: DateTime.now().subtract(const Duration(hours: 8)),
      endTime: DateTime.now().subtract(const Duration(hours: 1)),
      powerBlockRequired: false,
      safetyPrecautions: [
        'Fire detection zone isolated during welding',
        'Two 5kg CO2 fire extinguishers placed within 2m',
        '30-minute post-welding thermal watch completed',
      ],
      approvedBy: 'Station Safety Officer (SSO-02)',
      approvalDate: DateTime.now().subtract(const Duration(hours: 9)),
      notes: [
        'Welding complete. Hydrostatic leak test passed at 6.5 bar.',
        'Fire detection zone restored to normal status.',
      ],
    ),
    PermitToWork(
      id: 'PTW-2026-0035',
      permitNumber: 'PTW/OHE/2026/035',
      type: PtwType.powerBlockOHE,
      status: PtwStatus.closed,
      title: 'Contact Wire Stagger Adjustment at Neutral Section',
      description:
          'Adjustment of steady arms and registration assemblies at Neutral Section NS-1. Traction power safely restored.',
      corridor: 'Corridor 2 (Green Line)',
      location: 'Neutral Section NS-1 (KM 04.100)',
      picName: 'D. Sen (OHE Supervisor)',
      picPhone: '+91 98490 11204',
      picCompany: 'Metro Traction Department',
      startTime: DateTime.now().subtract(const Duration(days: 2)),
      endTime: DateTime.now().subtract(const Duration(days: 2, hours: -4)),
      powerBlockRequired: true,
      powerBlockSector: 'SEC-2A (Miyapur Corridor)',
      safetyPrecautions: ['Full power isolation and earth discharge confirmed'],
      approvedBy: 'V. R. Murthy (TPC)',
      approvalDate: DateTime.now().subtract(const Duration(days: 2, hours: 1)),
      notes: [
        'Work completed on schedule.',
        'Discharge rods removed, track cleared, line energized and handed over.',
      ],
    ),
  ];

  String _searchQuery = '';
  PtwStatus? _statusFilter;
  PtwType? _typeFilter;

  String get searchQuery => _searchQuery;
  PtwStatus? get statusFilter => _statusFilter;
  PtwType? get typeFilter => _typeFilter;

  List<PermitToWork> get allPermits => List.unmodifiable(_permits);

  List<PermitToWork> get activePermits {
    return _permits.where((p) {
      final isActive = p.status != PtwStatus.completed &&
          p.status != PtwStatus.closed &&
          p.status != PtwStatus.cancelled;
      if (!isActive) return false;

      if (_statusFilter != null && p.status != _statusFilter) return false;
      if (_typeFilter != null && p.type != _typeFilter) return false;

      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = p.id.toLowerCase().contains(q) ||
            p.permitNumber.toLowerCase().contains(q) ||
            p.title.toLowerCase().contains(q) ||
            p.corridor.toLowerCase().contains(q) ||
            p.location.toLowerCase().contains(q) ||
            p.picName.toLowerCase().contains(q);
        if (!match) return false;
      }
      return true;
    }).toList();
  }

  List<PermitToWork> get historyPermits {
    return _permits.where((p) {
      final isHistory = p.status == PtwStatus.completed ||
          p.status == PtwStatus.closed ||
          p.status == PtwStatus.cancelled;
      if (!isHistory) return false;

      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = p.id.toLowerCase().contains(q) ||
            p.permitNumber.toLowerCase().contains(q) ||
            p.title.toLowerCase().contains(q) ||
            p.corridor.toLowerCase().contains(q) ||
            p.location.toLowerCase().contains(q) ||
            p.picName.toLowerCase().contains(q);
        if (!match) return false;
      }
      return true;
    }).toList();
  }

  int get activeCount => _permits
      .where((p) =>
          p.status == PtwStatus.started ||
          p.status == PtwStatus.approved ||
          p.status == PtwStatus.waitingForApproval)
      .length;

  int get workInProgressCount =>
      _permits.where((p) => p.status == PtwStatus.started).length;

  int get pendingApprovalCount =>
      _permits.where((p) => p.status == PtwStatus.waitingForApproval).length;

  void setSearchQuery(String q) {
    _searchQuery = q.trim();
    notifyListeners();
  }

  void setStatusFilter(PtwStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void setTypeFilter(PtwType? type) {
    _typeFilter = type;
    notifyListeners();
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = null;
    _typeFilter = null;
    notifyListeners();
  }

  void createPermit({
    required PtwType type,
    required String title,
    required String description,
    required String corridor,
    required String location,
    String? workOrderId,
    required String picName,
    required String picPhone,
    required String picCompany,
    required DateTime startTime,
    required DateTime endTime,
    required bool powerBlockRequired,
    String? powerBlockSector,
    required List<String> safetyPrecautions,
  }) {
    final nextIdNum = (_permits.length + 45).toString().padLeft(4, '0');
    final newPermit = PermitToWork(
      id: 'PTW-2026-$nextIdNum',
      permitNumber: 'PTW/${type.code}/2026/$nextIdNum',
      type: type,
      status: PtwStatus.waitingForApproval,
      title: title,
      description: description,
      corridor: corridor,
      location: location,
      workOrderId: workOrderId,
      picName: picName,
      picPhone: picPhone,
      picCompany: picCompany,
      startTime: startTime,
      endTime: endTime,
      powerBlockRequired: powerBlockRequired,
      powerBlockSector: powerBlockSector,
      safetyPrecautions: safetyPrecautions,
      notes: ['Permit request submitted via Mobile field app.'],
    );

    _permits.insert(0, newPermit);
    notifyListeners();
  }

  void approvePermit(String id, String approverName) {
    final idx = _permits.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final old = _permits[idx];
      final notes = List<String>.from(old.notes);
      notes.insert(0, 'Approved by $approverName (Controller Clearance Granted).');
      _permits[idx] = old.copyWith(
        status: PtwStatus.approved,
        approvedBy: approverName,
        approvalDate: DateTime.now(),
        notes: notes,
      );
      notifyListeners();
    }
  }

  void startPermit(String id) {
    final idx = _permits.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final old = _permits[idx];
      final notes = List<String>.from(old.notes);
      notes.insert(0, 'Work physically started on site. Safety checklist verified.');
      _permits[idx] = old.copyWith(
        status: PtwStatus.started,
        notes: notes,
      );
      notifyListeners();
    }
  }

  void completePermit(String id) {
    final idx = _permits.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final old = _permits[idx];
      final notes = List<String>.from(old.notes);
      notes.insert(0, 'Work completed. Track cleared and personnel stood down.');
      _permits[idx] = old.copyWith(
        status: PtwStatus.completed,
        notes: notes,
      );
      notifyListeners();
    }
  }

  void closePermit(String id) {
    final idx = _permits.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final old = _permits[idx];
      final notes = List<String>.from(old.notes);
      notes.insert(
        0,
        'Permit closed & line handed over to Revenue Traffic / Power restored.',
      );
      _permits[idx] = old.copyWith(
        status: PtwStatus.closed,
        notes: notes,
      );
      notifyListeners();
    }
  }

  void changePic(String id, String newPicName, String newPhone, String newCompany) {
    final idx = _permits.indexWhere((p) => p.id == id);
    if (idx != -1) {
      final old = _permits[idx];
      final notes = List<String>.from(old.notes);
      notes.insert(0, 'PIC handover to $newPicName ($newPhone) from $newCompany.');
      _permits[idx] = old.copyWith(
        picName: newPicName,
        picPhone: newPhone,
        picCompany: newCompany,
        notes: notes,
      );
      notifyListeners();
    }
  }
}
