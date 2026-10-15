import '../../models/auth/profile_model.dart';
import '../base_api_service.dart';

/// Service handling user profiles and staff details.
/// Configured for 100% offline standalone prototype operation.
class StaffProfileApiService extends BaseApiService {
  /// Fetch staff details for user profile
  Future<StaffProfileModel?> getStaffDetails({required String staffId}) async {
    return StaffProfileModel(
      staffId: int.tryParse(staffId) ?? 1001,
      staffNo: 'EMP-7590',
      staffName: 'Metro Technical Staff',
      firstName: 'Technical',
      lastName: 'Staff',
      designationName: 'Senior Rolling Stock Engineer',
      unitName: 'Rolling Stock Maintenance',
      unitCode: 'RS-MAINT',
      locationName: 'Miyapur Depot',
      email: 'techstaff@ltmetro.com',
      mobile: '+91 98765 43210',
      gender: 'Male',
      status: 'Active',
      skill: 'Brake Systems, HVAC, CAD Depot Allocation',
      vendorName: 'L&T Metro Rail',
      staffTypeName: 'Permanent',
    );
  }

  /// Update staff profile (adminService/api/Admin/update-profile)
  Future<bool> updateStaffProfile({required Map<String, dynamic> staff}) async {
    return true;
  }
}

