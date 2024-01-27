import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_native_timezone/flutter_native_timezone.dart';

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
      final locationName = await FlutterNativeTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(locationName));
    }
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
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(
          'Local Notification ID 1',
          'Local Notification Channel Name',
          'Local Notification Channel Description',
        ),
        payload: payload,
      );

  static Future showPeriodicNotification({
    int id = 2,
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
          'Periodic Notification ID 2',
          'Periodic Notification Channel Name',
          'Periodic Notification Channel Description',
        ),
        payload: payload,
      );

  static Future showScheduledNotification({
    int id = 3,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async =>
      _notifications.zonedSchedule(
        id,
        title,
        body,
        _scheduleDaily(DateTime(scheduleDate.hour)),
        // tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(
          'Periodic Notification ID 2',
          'Periodic Notification Channel Name',
          'Periodic Notification Channel Description',
        ),
        payload: payload,
        // androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );

  static tz.TZDateTime _scheduleDaily(DateTime time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      time.second,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
