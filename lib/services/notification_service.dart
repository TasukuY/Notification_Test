import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final _notificatinos = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    print('NotificationService._notificationDetails!!!!!!!!');
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'ln_channel',
        'TEST TITLE',
        channelDescription: 'TEST DESCRIPTION',
        importance: Importance.max,
        icon: '@drawable/ic_launcher',
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  static Future init({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('@drawable/ic_launcher');
    const iOS = DarwinInitializationSettings();
    const macOS = DarwinInitializationSettings();
    const settings =
        InitializationSettings(android: android, iOS: iOS, macOS: macOS);

    tz.initializeTimeZones();

    // when app is closed
    final details = await _notificatinos.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.notificationResponse?.payload);
    }

    await _notificatinos.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        if (payload.payload == null) return;
        onNotifications.add(payload.payload);
      },
    );
  }

  static Future showSimpleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notificatinos.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduledDate,
  }) async =>
      _notificatinos.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(scheduledDate, tz.local),
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
}
