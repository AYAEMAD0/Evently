// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:timezone/timezone.dart' as tz;
// import 'package:timezone/data/latest.dart' as tz;
//
// class NotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   static Future<void> init() async {
//     tz.initializeTimeZones();
//
//     const AndroidInitializationSettings androidInit =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     const InitializationSettings initSettings =
//     InitializationSettings(android: androidInit);
//
//     await _notificationsPlugin.initialize(initSettings);
//
//     final androidPlugin = _notificationsPlugin
//         .resolvePlatformSpecificImplementation<
//         AndroidFlutterLocalNotificationsPlugin>();
//     await androidPlugin?.requestNotificationsPermission();
//   }
//
//   static Future<void> scheduleNotification({
//     required String title,
//     required String body,
//     required DateTime dateTime,
//   }) async {
//     final tz.TZDateTime tzDate = tz.TZDateTime.from(dateTime, tz.local);
//
//     await _notificationsPlugin.zonedSchedule(
//       dateTime.hashCode,
//       title,
//       body,
//       tzDate,
//       const NotificationDetails(
//         android: AndroidNotificationDetails(
//           'event_channel',
//           'Event Notifications',
//           channelDescription: 'Reminders for upcoming events',
//           importance: Importance.high,
//           priority: Priority.high,
//         ),
//       ),
//       androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//       matchDateTimeComponents: DateTimeComponents.time,
//     );
//   }
// }
