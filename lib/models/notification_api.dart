import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        _notificationDetails(),
        payload: payload,
      );

  static NotificationDetails? _notificationDetails() {
    return NotificationDetails(
        android: AndroidNotificationDetails('Channel id', 'Channel name',
            importance: Importance.max));
  }
}
