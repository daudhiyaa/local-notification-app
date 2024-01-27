import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    // When App is Closed
    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.notificationResponse!.payload);
    }

    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.payload);
      },
    );

    if (initScheduled) {
      tz.initializeTimeZones();
    }
  }

  static Future _notificationDetails(
    String channelID,
    String channelName,
    String channelDesc,
  ) async {
    String filePath = channelID.contains('1')
        ? 'assets/icons/appstore.png'
        : channelID.contains('2')
            ? 'assets/icons/ISRDVB.png'
            : 'assets/icons/ISRFM.png';
    ByteData data = await rootBundle.load(filePath);
    Uint8List bytes = data.buffer.asUint8List();

    final ByteArrayAndroidBitmap notificationIcon =
        ByteArrayAndroidBitmap(bytes);

    final styleInformation = BigPictureStyleInformation(
      notificationIcon,
      largeIcon: notificationIcon,
      contentTitle: 'Image Local Notification',
    );

    return NotificationDetails(
      android: AndroidNotificationDetails(
        channelID,
        channelName,
        channelDescription: channelDesc,
        importance: Importance.max,
        ticker: 'ticker',
        styleInformation: styleInformation,
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
        // _scheduleDaily(DateTime(scheduleDate.hour)),
        tz.TZDateTime.from(scheduleDate, tz.local),
        await _notificationDetails(
          'Scheduled Notification ID 3',
          'Scheduled Notification Channel Name',
          'Scheduled Notification Channel Description',
        ),
        payload: payload,
        // androidAllowWhileIdle: true,
        matchDateTimeComponents: DateTimeComponents.time,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
