import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> _firebaseMessagingBackgroundHandle(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print('body: ${message.notification?.body}');
  print('payload: ${message.data}');
}
class FirebaseApi {
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNofication() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    print('token :${fcmToken}');
    FirebaseMessaging.onBackgroundMessage((message) => _firebaseMessagingBackgroundHandle(
        message));
  }
}
