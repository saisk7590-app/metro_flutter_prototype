import 'package:flutter/material.dart';
import '../../models/service_request/service_request_model.dart';

class ServiceRequestProvider extends ChangeNotifier {
  final List<ServiceRequest> _requests = [
    ServiceRequest(
      id: 'SR-2026-0101',
      trainsetId: 'TS-04',
      carNumber: 'DM1-04',
      subsystem: 'Bogie & Suspension',
      faultCode: 'FC-BG-204',
      title: 'Abnormal squeal during curve negotiation',
      description:
          'Audible metallic vibration from wheel flange around Axle 2 during yard shunting. Primary spring damping requires physical verification.',
      priority: ServiceRequestPriority.high,
      status: ServiceRequestStatus.open,
      reportedBy: 'K. Sharma (Pilot)',
      reportedAt: DateTime.now().subtract(const Duration(hours: 3)),
      assignedTo: 'Rajesh Verma (Mechanical)',
      notes: ['Reported during morning turnaround in Bay 3.'],
    ),
    ServiceRequest(
      id: 'SR-2026-0102',
      trainsetId: 'TS-02',
      carNumber: 'T-02',
      subsystem: 'HVAC & Climate',
      faultCode: 'FC-HV-108',
      title: 'Saloon AC Unit 2 low cooling efficiency',
      description:
          'Temperature sensor reports 26.5°C vs setpoint 21.0°C. Compressor 2 high pressure cutout tripped twice on revenue service.',
      priority: ServiceRequestPriority.medium,
      status: ServiceRequestStatus.inProgress,
      reportedBy: 'S. Nagesh (Guard)',
      reportedAt: DateTime.now().subtract(const Duration(hours: 6)),
      assignedTo: 'Amit Kumar (HVAC Lead)',
      notes: [
        'Filter checked; requires refrigerant charge check.',
        'Technician dispatched to Bay 1.',
      ],
    ),
    ServiceRequest(
      id: 'SR-2026-0103',
      trainsetId: 'TS-07',
      carNumber: 'M-07',
      subsystem: 'Door System',
      faultCode: 'FC-DR-412',
      title: 'Door 4 obstruction sensor false trigger',
      description:
          'Obstacle detection loop triggered 3 consecutive times without physical obstacle during platform dwell. Optical sensor misalignment suspected.',
      priority: ServiceRequestPriority.critical,
      status: ServiceRequestStatus.waitingForMaterial,
      reportedBy: 'V. Rao (Platform Supervisor)',
      reportedAt: DateTime.now().subtract(const Duration(hours: 12)),
      assignedTo: 'Praveen K. (Electronics)',
      waitingReason: 'Awaiting replacement optical transceiver unit (Part #OPT-8821)',
      notes: ['Sensor harness tested normal. Part requisitioned from central store.'],
    ),
    ServiceRequest(
      id: 'SR-2026-0104',
      trainsetId: 'TS-01',
      carNumber: 'DM2-01',
      subsystem: 'Pneumatics & Brakes',
      faultCode: 'FC-BK-305',
      title: 'Brake cylinder pressure gauge slow response',
      description:
          'Pressure transducer BCP-2 displays 1.2s lag on rapid service brake application. Pneumatic manifold seal inspected.',
      priority: ServiceRequestPriority.high,
      status: ServiceRequestStatus.workOrderIssued,
      reportedBy: 'Anand M. (Depot Incharge)',
      reportedAt: DateTime.now().subtract(const Duration(days: 1, hours: 2)),
      assignedTo: 'R. Sunder (Pneumatics Lead)',
      workOrderId: 'WO-2026-0941',
      notes: ['Work order issued for caliper & transducer recalibration.'],
    ),
    ServiceRequest(
      id: 'SR-2026-0105',
      trainsetId: 'TS-09',
      carNumber: 'DM1-09',
      subsystem: 'Traction & Propulsion',
      faultCode: 'FC-TR-502',
      title: 'VVVF inverter minor temperature warning',
      description:
          'Auxiliary heat sink temp reached 72°C (Warning threshold: 70°C) during continuous peak gradient run.',
      priority: ServiceRequestPriority.low,
      status: ServiceRequestStatus.open,
      reportedBy: 'Automatic Diagnostics System',
      reportedAt: DateTime.now().subtract(const Duration(days: 1, hours: 5)),
      assignedTo: 'Unassigned',
      notes: ['Telemetry event logged from trainborne TCMS.'],
    ),
    ServiceRequest(
      id: 'SR-2026-0098',
      trainsetId: 'TS-03',
      carNumber: 'M-03',
      subsystem: 'Pantograph & Roof',
      faultCode: 'FC-PT-115',
      title: 'Carbon strip wear limit alert (Axle 4)',
      description:
          'Periodic laser profile gauge indicated 2.8mm remaining thickness on contact strip B.',
      priority: ServiceRequestPriority.high,
      status: ServiceRequestStatus.closed,
      reportedBy: 'D. Sen (OHE Inspector)',
      reportedAt: DateTime.now().subtract(const Duration(days: 3)),
      assignedTo: 'M. Patel (Overhaul Team)',
      notes: ['Carbon strip replaced and test run completed successfully in Bay 4.'],
    ),
    ServiceRequest(
      id: 'SR-2026-0095',
      trainsetId: 'TS-05',
      carNumber: 'T-05',
      subsystem: 'Passenger Info System',
      faultCode: 'FC-PIS-201',
      title: 'Saloon display LED row 3 blank',
      description: 'Route map indicator display flicker on Left Saloon door 2.',
      priority: ServiceRequestPriority.low,
      status: ServiceRequestStatus.closed,
      reportedBy: 'K. Pillai (Station Master)',
      reportedAt: DateTime.now().subtract(const Duration(days: 4)),
      assignedTo: 'G. Suresh (Telecom Lead)',
      notes: ['Ribbon cable reseated. Display operational.'],
    ),
  ];

  String _searchQuery = '';
  ServiceRequestStatus? _statusFilter;
  String? _subsystemFilter;

  String get searchQuery => _searchQuery;
  ServiceRequestStatus? get statusFilter => _statusFilter;
  String? get subsystemFilter => _subsystemFilter;

  List<ServiceRequest> get allRequests => List.unmodifiable(_requests);

  List<ServiceRequest> get activeRequests {
    return _requests.where((r) {
      final isActive = r.status != ServiceRequestStatus.closed &&
          r.status != ServiceRequestStatus.cancelled;
      if (!isActive) return false;

      if (_statusFilter != null && r.status != _statusFilter) return false;
      if (_subsystemFilter != null &&
          _subsystemFilter!.isNotEmpty &&
          r.subsystem != _subsystemFilter) {
        return false;
      }
      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = r.id.toLowerCase().contains(q) ||
            r.trainsetId.toLowerCase().contains(q) ||
            r.carNumber.toLowerCase().contains(q) ||
            r.title.toLowerCase().contains(q) ||
            r.subsystem.toLowerCase().contains(q) ||
            r.faultCode.toLowerCase().contains(q);
        if (!match) return false;
      }
      return true;
    }).toList();
  }

  List<ServiceRequest> get historyRequests {
    return _requests.where((r) {
      final isHistory = r.status == ServiceRequestStatus.closed ||
          r.status == ServiceRequestStatus.cancelled;
      if (!isHistory) return false;

      if (_searchQuery.isNotEmpty) {
        final q = _searchQuery.toLowerCase();
        final match = r.id.toLowerCase().contains(q) ||
            r.trainsetId.toLowerCase().contains(q) ||
            r.carNumber.toLowerCase().contains(q) ||
            r.title.toLowerCase().contains(q) ||
            r.subsystem.toLowerCase().contains(q);
        if (!match) return false;
      }
      return true;
    }).toList();
  }

  int get totalActiveCount => _requests
      .where((r) =>
          r.status != ServiceRequestStatus.closed &&
          r.status != ServiceRequestStatus.cancelled)
      .length;

  int get criticalCount => _requests
      .where((r) =>
          r.priority == ServiceRequestPriority.critical &&
          r.status != ServiceRequestStatus.closed)
      .length;

  int get waitingMaterialCount => _requests
      .where((r) => r.status == ServiceRequestStatus.waitingForMaterial)
      .length;

  void setSearchQuery(String q) {
    _searchQuery = q.trim();
    notifyListeners();
  }

  void setStatusFilter(ServiceRequestStatus? status) {
    _statusFilter = status;
    notifyListeners();
  }

  void setSubsystemFilter(String? subsystem) {
    _subsystemFilter = subsystem;
    notifyListeners();
  }

  void resetFilters() {
    _searchQuery = '';
    _statusFilter = null;
    _subsystemFilter = null;
    notifyListeners();
  }

  void createServiceRequest({
    required String trainsetId,
    required String carNumber,
    required String subsystem,
    required String faultCode,
    required String title,
    required String description,
    required ServiceRequestPriority priority,
    required String reportedBy,
    String? assignedTo,
  }) {
    final nextNumber = (_requests.length + 101).toString().padLeft(4, '0');
    final newSR = ServiceRequest(
      id: 'SR-2026-$nextNumber',
      trainsetId: trainsetId,
      carNumber: carNumber,
      subsystem: subsystem,
      faultCode: faultCode,
      title: title,
      description: description,
      priority: priority,
      status: ServiceRequestStatus.open,
      reportedBy: reportedBy,
      reportedAt: DateTime.now(),
      assignedTo: assignedTo ?? 'Unassigned',
      notes: ['Service Request logged into depot maintenance system.'],
    );

    _requests.insert(0, newSR);
    notifyListeners();
  }

  void updateStatus(
    String id,
    ServiceRequestStatus newStatus, {
    String? note,
    String? waitingReason,
  }) {
    final idx = _requests.indexWhere((r) => r.id == id);
    if (idx != -1) {
      final old = _requests[idx];
      final updatedNotes = List<String>.from(old.notes);
      if (note != null && note.isNotEmpty) {
        updatedNotes.insert(0, note);
      } else {
        updatedNotes.insert(0, 'Status updated to ${newStatus.label}.');
      }

      _requests[idx] = old.copyWith(
        status: newStatus,
        waitingReason: newStatus == ServiceRequestStatus.waitingForMaterial
            ? (waitingReason ?? old.waitingReason)
            : null,
        notes: updatedNotes,
      );
      notifyListeners();
    }
  }

  void issueWorkOrder(String id, String workOrderId, {String? targetBay}) {
    final idx = _requests.indexWhere((r) => r.id == id);
    if (idx != -1) {
      final old = _requests[idx];
      final updatedNotes = List<String>.from(old.notes);
      updatedNotes.insert(
        0,
        'Converted to Work Order $workOrderId ${targetBay != null ? 'assigned to $targetBay' : ''}.',
      );

      _requests[idx] = old.copyWith(
        status: ServiceRequestStatus.workOrderIssued,
        workOrderId: workOrderId,
        notes: updatedNotes,
      );
      notifyListeners();
    }
  }

  void addNote(String id, String note) {
    final idx = _requests.indexWhere((r) => r.id == id);
    if (idx != -1) {
      final old = _requests[idx];
      final updatedNotes = List<String>.from(old.notes);
      updatedNotes.insert(0, note);
      _requests[idx] = old.copyWith(notes: updatedNotes);
      notifyListeners();
    }
  }
}
