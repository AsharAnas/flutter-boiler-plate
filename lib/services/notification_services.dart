// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:permission_handler/permission_handler.dart';

// class LocalNotificationService {
//   static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

//   static Future<void> initialize() async {
//     // Initialization settings for Android
//     const AndroidInitializationSettings androidInitializationSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
//     // Initialization settings for iOS
//     final DarwinInitializationSettings iosInitializationSettings = DarwinInitializationSettings(
//       requestAlertPermission: true,
//       requestBadgePermission: true,
//       requestSoundPermission: true,
//       // onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {
//       //   // Handle when a notification is tapped while the app is in the background
//       // },
//     );

//     final InitializationSettings initializationSettings =
//         InitializationSettings(android: androidInitializationSettings, iOS: iosInitializationSettings);

//     await _notificationsPlugin.initialize(
//       initializationSettings,
//       onDidReceiveNotificationResponse: (details) {
//         // Handle when a notification is tapped while the app is in the foreground
//         print('Notification tapped: $details');
//       },
//     );
//   }

//   static Future<void> requestPermissionForAndroid() async {
//     final status = await Permission.notification.request();
//     print("Notification permission status for Android: $status");
//   }

//   static Future<void> requestPermissionForIOS() async {
//     // Request permissions for iOS
//     final bool? result = await _notificationsPlugin.resolvePlatformSpecificImplementation<IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
//           alert: true,
//           badge: true,
//           sound: true,
//         );
//     if (result != null && result) {
//       print('iOS notification permissions granted');
//     }
//   }

//   static Future<void> createAndDisplayNotification(RemoteMessage message) async {
//     try {
//       const NotificationDetails notificationDetails = NotificationDetails(
//         android: AndroidNotificationDetails(
//           'pushnotificationapp',
//           'pushnotificationappchannel',
//           importance: Importance.max,
//           priority: Priority.high,
//         ),
//         iOS: DarwinNotificationDetails(
//           presentAlert: true,
//           presentBadge: true,
//           presentSound: true,
//         ),
//       );
//       await _notificationsPlugin.show(
//         0,
//         message.notification!.title,
//         message.notification!.body,
//         notificationDetails,
//         payload: message.data['_id'],
//       );
//     } on Exception catch (e) {
//       print('Failed to display notification: $e');
//     }
//   }
// }
