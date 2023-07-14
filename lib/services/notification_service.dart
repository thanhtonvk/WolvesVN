import 'dart:convert';
import 'dart:math';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initLocalNotification(
      BuildContext context, RemoteMessage remoteMessage) async {
    var androidInit = const AndroidInitializationSettings('app_icon');
    var iosInit = const DarwinInitializationSettings();
    var initSetting = InitializationSettings(
        android: androidInit, iOS: iosInit, macOS: iosInit);
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
    AndroidNotificationChannel channel = const AndroidNotificationChannel(
        '280301', "high_importance_channel",
        importance: Importance.max);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
            channel.id.toString(), channel.name.toString(),
            channelDescription: "Tin tức, tín hiệu, ...",
            importance: Importance.high,
            priority: Priority.high,
            ticker: 'ticker',
            enableVibration: true);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(
            presentAlert: true, presentBadge: true, presentSound: true);
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(0, message.notification?.title,
          message.notification?.body, notificationDetails);
      flutterLocalNotificationsPlugin.show(
        DateTime.now().millisecond,
        message.notification?.title,
        message.notification?.body,
        notificationDetails,
        payload: json.encode(message.data),
      );
    });
  }

  void firebaseInit(BuildContext context) {
   messaging.subscribeToTopic('thongbao');
    FirebaseMessaging.onMessage.listen((event) {
      if (kDebugMode) {
        print(event.notification?.title.toString());
        print(event.notification?.body.toString());
      }

      try {
        showNotification(event);
      } catch (e) {
        final snackbar = SnackBar(
          content: Text(event.notification!.body.toString()),
          action: SnackBarAction(
            label: event.notification!.title.toString(),
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }).onError((Object obj) {
      print('err');
    });
  }
}
