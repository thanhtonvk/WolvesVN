import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../generated/common.dart';

class TinTucWolvesPage extends StatefulWidget {
  const TinTucWolvesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TinTucWolvesPageState();
  }
}

class TinTucWolvesPageState extends State<TinTucWolvesPage> {
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
          Common.wolvesNews.Titile,
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
    String htmlText = Common.wolvesNews.Content;
    WebViewController controller = WebViewController();
    controller.setBackgroundColor(Colors.black12);
    controller.loadHtmlString(htmlText);
    controller.enableZoom(false);
    return Expanded(
        child: WebViewWidget(
      controller: controller,
    ));
  }
}
