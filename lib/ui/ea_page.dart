import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../generated/common.dart';

void main() {
  runApp(const MyEAPage());
}

class MyEAPage extends StatefulWidget {
  const MyEAPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyEAPageState();
  }
}

class MyEAPageState extends State<MyEAPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text(
          Common.sanGiaoDich.Titile,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [showWeb()],
      ),
    );
  }

  Widget showWeb() {
    String htmlText = Common.sanGiaoDich.Content;
    WebViewController controller = WebViewController();
    controller.setBackgroundColor(Colors.black12);
    controller.loadHtmlString(htmlText);
    controller.enableZoom(true);
    return Expanded(
        child: WebViewWidget(
      controller: controller,
    ));
  }
}
