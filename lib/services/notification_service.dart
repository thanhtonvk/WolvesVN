import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotification(
      BuildContext context, RemoteMessage remoteMessage) async {
    var androidInit =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var iosInit = const DarwinInitializationSettings();
    var initSetting =
        InitializationSettings(android: androidInit, iOS: iosInit,macOS: iosInit);
    await flutterLocalNotificationsPlugin.initialize(initSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {});
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user grant premission');
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('user grant provisional permisison');
    } else {
      print('user denied permission');
      AppSettings.openAppSettings();
    }
  }

  Future<String?> getDeviceToken() async {
    return await messaging.getToken();
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      if (kDebugMode) {
        print('refresh');
      }
    });
  }

  Future<void> showNotification(RemoteMessage message) async {
    AndroidNotificationChannel channel = AndroidNotificationChannel(
        Random.secure().nextInt(100000).toString(), "high_importance_channel",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(channel.id.toString(), channel.name.toString(),
            channelDescription: "Tin tức, tín hiệu, ...",
            importance: Importance.max,
            priority: Priority.max,
            ticker: 'ticker');
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails);
    });
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print(event.notification?.title.toString());
        print(event.notification?.body.toString());
      }
      showNotification(event);
    });
  }
}
