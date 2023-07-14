import 'dart:async';

import 'package:app_settings/app_settings.dart';
import 'package:dio/dio.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolvesvn/firebase_options.dart';
import 'package:wolvesvn/services/api_service.dart';
import 'package:wolvesvn/services/firebase_api.dart';
import 'package:wolvesvn/services/notification_service.dart';
import 'package:wolvesvn/ui/login.dart';
import 'package:wolvesvn/ui/main_page.dart';

import 'generated/common.dart';
import 'generated/config.dart';
import 'models/account.dart';
import 'models/vip.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Handling a background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black87),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));
  String email = '';
  String password = '';

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    email = prefs.getString('email')!;
    password = prefs.getString('password')!;
  }

  NotificationService notificationService = NotificationService();
  FirebaseDatabase database = FirebaseDatabase.instance;

  Future<void> addToken(String value) async {
    database.ref('Token').child(value).set(value).then((value) {
      print('done');
    }).onError((error, stackTrace) {
      print('err');
    }).catchError((Object obj) {
      print('catch err');
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    notificationService.requestPermission();
    notificationService.firebaseInit(context);
    notificationService.isTokenRefresh();
    notificationService.getDeviceToken().then((value) {
      print('token ${value}');
      addToken(value as String);
    });
    getData();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              "assets/images/logo.png",
              width: 150,
              height: 150,
              fit: BoxFit.contain,
              scale: 0.1,
            ),
            const Text(
              "Bạn tốt - Tôi tốt - Chúng ta cùng tốt",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.orange),
            )
          ],
        ),
      ),
    );
  }

  int _seconds = 1; // Set the initial countdown time in seconds
  Timer? _timer;

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_seconds > 0) {
          _seconds--;
        } else {
          timer.cancel();
          if (email.isNotEmpty && password.isNotEmpty) {
            login();
          } else {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const Login()));
          }

          // Stop the timer when countdown reaches 0
          // Call the method to navigate to a new page
        }
      });
    });
  }

  bool isVip(List<String> expertDate, List<String> currentDate) {
    int expertYear = int.parse(expertDate[0]);
    int expertMonth = int.parse(expertDate[1]);
    int expertDay = int.parse(expertDate[2]);

    int currentYear = int.parse(currentDate[0]);
    int currentMonth = int.parse(currentDate[1]);
    int currentDay = int.parse(currentDate[2]);
    if (expertYear > currentYear) {
      return true;
    } else if (expertYear < currentYear) {
      return false;
    } else {
      if (expertMonth > currentMonth) {
        return true;
      } else if (expertMonth < currentMonth) {
        return false;
      } else {
        if (expertDay >= currentDay) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  void checkVip() {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    List<String> current = currentDate.split('-');
    apiServices.getVip(Common.ACCOUNT.Id as int).then(
      (value) {
        for (Vip vip in value) {
          String stringDate = vip.End.split('T')[0];
          List<String> expert = stringDate.split('-');
          Common.isVip = isVip(expert, current);
        }
      },
    ).onError(
      (error, stackTrace) {
        Common.isVip = false;
      },
    ).catchError((Object obj) {
      Common.isVip = false;
    });
  }

  void login() {
    Future<List<Account>> future = apiServices.login(email, password);
    future
        .then((value) => {
              Common.ACCOUNT = value[0],
              if (Common.ACCOUNT.IsActive == true)
                {
                  checkVip(),
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const MainPage(),
                  ))
                }
              else
                {navToLogin()},
            })
        .onError(
      (error, stackTrace) {
        throw Exception();
        navToLogin();
      },
    ).catchError((Object obj) {
      navToLogin();
    });
  }

  void navToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const Login()),
    );
  }
}
