import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wolvesvn/ui/main_fragment/exchanges.dart';
import 'package:wolvesvn/ui/main_fragment/general.dart';
import 'package:wolvesvn/ui/main_fragment/market.dart';
import 'package:wolvesvn/ui/main_fragment/news.dart';
import 'package:wolvesvn/ui/main_fragment/signal.dart';
import '../generated/common.dart';
import '../models/vip.dart';
import '../services/api_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MainPageHomeState();
  }
}

class MainPageHomeState extends State<MainPage> {
  int selectedIndex = 0;
  Widget generalPage = GeneralPage();
  Widget marketPage = MarketPage();
  Widget newsPage = NewsPage();
  Widget signalPage = SignalPage();
  Widget exchanges = ExchangesPage();
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

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

  void checkVip() async {
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

  FirebaseDatabase database = FirebaseDatabase.instance;

  @override
  void initState() {
    // checkVip();
    // TODO: implement initState

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    DatabaseReference ref = database.ref('TongQuat');
    ref.onValue.listen((event) {
      for (var obj in event.snapshot.children) {
        Map<dynamic, dynamic> value = obj.value as Map;
        Common.pip = value['TongPip'].toString();
        Common.trades = value['Trades'].toString();
        Common.winRate = value['WinRate'].toString();
      }
      setState(() {});
    });
    return getFragment();
  }

  Widget getFragment() {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: getBody(),
      bottomNavigationBar: BottomNavigationBar(
          selectedIconTheme:
              const IconThemeData(color: Colors.orange, size: 30),
          unselectedIconTheme:
              const IconThemeData(color: Colors.white, size: 20),
          backgroundColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.show_chart),
                tooltip: "Thị trường",
                label: "."),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.signal_cellular_alt_rounded,
                ),
                tooltip: "Tín hiệu",
                label: "."),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.candlestick_chart_outlined,
                ),
                tooltip: "Sàn",
                label: "."),
            BottomNavigationBarItem(
                icon: Icon(Icons.feed), tooltip: "Tin tức", label: "."),
            BottomNavigationBarItem(
                icon: Icon(Icons.menu), label: '.', tooltip: "Menu")
          ],
          onTap: (int index) {
            onTapHandler(index);
          }),
    );
  }

  void onTapHandler(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  Widget getBody() {
    switch (selectedIndex) {
      case 0:
        return marketPage;
      case 1:
        return signalPage;
      case 2:
        return exchanges;
      case 3:
        return newsPage;
      case 4:
        return generalPage;
      default:
        return marketPage;
    }
  }
}
