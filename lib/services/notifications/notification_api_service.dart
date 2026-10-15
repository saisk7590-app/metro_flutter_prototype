import '../../models/notifications/notification_model.dart';
import '../base_api_service.dart';

/// Service handling push notifications, messaging, and read status.
/// Configured for 100% offline standalone prototype operation.
class NotificationApiService extends BaseApiService {
  /// Fetch notifications list
  Future<List<NotificationModel>> getNotifications({
    String? unitId,
    String? roleId,
  }) async {
    return [
      NotificationModel(
        id: 1,
        message: 'Work Order WO-2024-0101 assigned to your shift for TS-01 (Daily Pre-Service Inspection)',
        date: DateTime.now().subtract(const Duration(minutes: 25)),
        isRead: false,
      ),
      NotificationModel(
        id: 2,
        message: 'TS-04 Daily Meter reading due before 18:00 hrs',
        date: DateTime.now().subtract(const Duration(hours: 2)),
        isRead: false,
      ),
      NotificationModel(
        id: 3,
        message: 'Bay 03 (Miyapur Depot) allocation approved: TS-07 moved to Stabling Track SBL-03',
        date: DateTime.now().subtract(const Duration(hours: 5)),
        isRead: true,
      ),
      NotificationModel(
        id: 4,
        message: 'Wheel Turning & Profiling inspection completed for TS-03 Bogie 1',
        date: DateTime.now().subtract(const Duration(days: 1)),
        isRead: true,
      ),
    ];
  }

  /// Get unread notification count
  Future<int> getNotificationsCount({String? userId}) async {
    return 2;
  }

  /// Mark notification as read
  Future<bool> updateNotificationReadStatus({required int messageRecipientId}) async {
    return true;
  }
}

