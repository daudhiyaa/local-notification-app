import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.payload);
      },
    );
  }

  static Future _notificationDetails(
    String channelID,
    String channelName,
    String channelDesc,
  ) async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelID,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        ticker: 'ticker',
      ),
    );
  }

  static Future showNotification({
    int id = 1,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.periodicallyShow(
        id,
        title,
        body,
        RepeatInterval.everyMinute,
        await _notificationDetails(
          'ID 1',
          'My Channel Name',
          'My Channel Description',
        ),
        payload: payload,
      );

  static Future showPeriodicNotification({
    int id = 2,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(
          'ID 2',
          'My Channel Name',
          'My Channel Description',
        ),
        payload: payload,
      );
}
