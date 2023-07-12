import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wolvesvn/generated/common.dart';

void main() {
  runApp(XAUPage());
}

class XAUPage extends StatefulWidget {
  const XAUPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return XAUPageState();
  }
}

class XAUPageState extends State<XAUPage> {
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
          Common.gold.Symbol as String,
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [showWeb()],
      ),
    );
  }

  Widget showWeb() {
    String htmlText = Common.gold.Content as String;
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
