import '../../data/checklist_default_data.dart';
import '../../models/checklist/checklist_model.dart';
import '../base_api_service.dart';

/// Service handling Master Checklist configuration under Config Maintenance.
/// Configured for 100% offline standalone prototype operation.
class ChecklistConfigApiService extends BaseApiService {
  /// Fetch Asset Categories for Filter dropdown
  Future<List<ChecklistCategoryItem>> getAssetCategories() async {
    return ChecklistDefaultData.defaultCategoryItems;
  }

  /// Fetch Job Plans for Filter dropdown
  Future<List<ChecklistJobPlanItem>> getJobPlans() async {
    return ChecklistDefaultData.defaultJobPlanItems;
  }

  /// Fetch Checklist Names for Filter dropdown
  Future<List<ChecklistNameItem>> getJobPlanChecklistNames() async {
    return ChecklistDefaultData.defaultChecklistNameItems;
  }

  /// Fetch Master Checklists configured under Config Maintenance -> Checklists
  Future<List<JobPlanChecklistModel>> getScheduleChecklists({
    String categoryId = '0',
    String jobPlanId = '0',
    String checklistName = '',
    String status = '0',
  }) async {
    return ChecklistDefaultData.generateDefaultConfigChecklists();
  }

  /// Get groups and check items configured for a master Checklist
  Future<List<CheckGroupModel>> getChecklistDetails(int checkListId) async {
    return ChecklistDefaultData.generateDefaultChecklistGroups('Master Checklist');
  }

  /// Create a new Master Checklist
  Future<bool> saveChecklist({
    required int jobPlanId,
    required String checklistName,
    required int categoryId,
    int status = 1,
  }) async {
    return true;
  }

  /// Add a new group to a checklist
  Future<bool> saveChecklistGroup({
    required int checkListId,
    required String groupName,
  }) async {
    return true;
  }

  /// Add a new item to a checklist group
  Future<bool> saveChecklistGroupItem({
    required int groupId,
    required String subGroup,
    required String checkDescription,
  }) async {
    return true;
  }

  /// Update Checklist Name
  Future<bool> updateChecklistName({
    required int jpcId,
    required String checklistName,
    int? jobPlanId,
    int? categoryId,
    int? status,
  }) async {
    return true;
  }

  /// Delete a Checklist
  Future<bool> deleteChecklist({required int jpcId}) async {
    return true;
  }

  /// Delete an item from a group
  Future<bool> deleteChecklistItem({required int checkItemId}) async {
    return true;
  }

  /// Update Checklist Group Name
  Future<bool> updateChecklistGroup({
    required int groupId,
    required String groupName,
  }) async {
    return true;
  }

  /// Delete a Checklist Group
  Future<bool> deleteChecklistGroup({required int groupId}) async {
    return true;
  }

  /// Update Check Item Sub System and Check Description
  Future<bool> updateChecklistGroupItem({
    required int checkItemId,
    required String subGroup,
    required String checkDescription,
  }) async {
    return true;
  }
}

