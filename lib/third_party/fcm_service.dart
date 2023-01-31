import 'package:amplify_core/amplify_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FcmService {
  late final Future<void> _allReady;

  get allReady => _allReady;

  FcmService() {
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      safePrint("new token: $newToken");
    });
    _allReady = init();
  }

  Future<void> init() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'dingmo_notification_channel_id',
      'dingmo notification service',
      importance: Importance.max,
    );

    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      safePrint('Got a message whilst in the foreground!');
      safePrint('Message data: ${message.data}');

      if (message.notification != null) {
        safePrint(
            'Message also contained a notification: ${message.notification}');
        flutterLocalNotificationsPlugin.show(
            message.hashCode,
            message.notification?.title,
            message.notification?.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channelDescription: channel.description,
                  icon: '@mipmap/ic_launcher',
                ),
                iOS: const DarwinNotificationDetails(
                  badgeNumber: 1,
                  subtitle: 'the subtitle',
                  sound: 'slow_spring_board.aiff',
                )));
      }
    });

    FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessageHandler);
  }

  // Future<String?> _getToken() async {
  //   return await FirebaseMessaging.instance.getToken(
  //       vapidKey:
  //           "BKIq0xaQXtWo7QqMH8I3aVebHSzXXpHnYJcap4TfKy5QLjisqP-edVb2GbHZyO6-wTTuWRyLypQFvkZtqatbp3A");
  // }
}

Future<void> _firebaseBackgroundMessageHandler(RemoteMessage message) async {
  safePrint('background message: $message');
}
