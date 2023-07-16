import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '../../generated/common.dart';

class MarketUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarketState();
  }
}

class MarketState extends State<MarketUI> {
  @override
  Widget build(BuildContext context) {
    String logo = '';
    if (Common.isVip) {
      logo = 'assets/images/logo-vip.png';
    } else {
      logo = 'assets/images/logo.png';
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  logo,
                  width: 80,
                  height: 80,
                  fit: BoxFit.contain,
                  scale: 0.1,
                ),
                Container(
                  width: 200,
                  margin: const EdgeInsets.only(left: 10),
                  child: Column(
                    children: [
                      showInformation("Tên",
                          ": ${Common.ACCOUNT.FirstName} ${Common.ACCOUNT.LastName}"),
                      showInformation("ID", ": ${Common.ACCOUNT.Id}")
                    ],
                  ),
                )
              ],
            ),
            const Divider(
              color: Colors.white,
              height: 10,
              thickness: 1,
              indent: 5,
              endIndent: 5,
            ),
            SizedBox(
              height: 25,
              child: Container(
                margin: const EdgeInsets.only(right: 10),
                alignment: Alignment.topRight,
                child: dropoutWidget(),
              ),
            ),
            listView()
          ],
        )));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  WebViewController controller = WebViewController();
  FirebaseDatabase database = FirebaseDatabase.instance;

  String dropdownValue = list.first;
  String chart = nameChart.first;

  Widget dropoutWidget() {
    return DropdownButton<String>(
      dropdownColor: Colors.black,
      underline: Container(
        height: 0,
      ),
      icon: const Icon(Icons.settings),
      elevation: 1,
      style: const TextStyle(color: Colors.orange),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          int index = list.indexOf(dropdownValue);
          chart = nameChart[index];
        });
      },
      items: list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  Widget listView() {
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setBackgroundColor(Colors.black);
    controller.enableZoom(false);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    DatabaseReference ref = database.ref('Chart').child(chart);
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String? html = snapshot.data?.snapshot.value.toString();
          controller.loadHtmlString(html as String);
          // controller.loadHtmlString();
          return Expanded(
              child: WebViewWidget(
            controller: controller,
          ));
        } else {
          return Container();
        }
      },
    );
  }

  Widget showInformation(String label, String content) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white),
        ),
        Text(
          content,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        )
      ],
    );
  }
}

const List<String> nameChart = [
  'General',
  'Advanced',
  'AdvancedSymbol',
  'HeatMapForex',
  'Crypto',
  'DataMarket',
  'EconomyCalendar',
  'Filter',
  'GiaNgoaiHoi'
];
const List<String> list = <String>[
  'Tổng quan',
  'Nâng cao',
  'Chỉ số nâng cao',
  'Bản đồ nhiệt Forex',
  'Tiền ảo',
  'Dữ liệu thị trường',
  'Lịch kinh tế',
  'Bộ lọc',
  'Ngoại hối'
];

class MarketPage extends StatelessWidget {
  MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketUI();
  }
}
