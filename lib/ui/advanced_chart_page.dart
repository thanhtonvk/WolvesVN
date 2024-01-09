import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

import '../generated/common.dart';
import 'package:webview_flutter/webview_flutter.dart';

class AdvancedChartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AdvancedChartState();
  }
}

class AdvancedChartState extends State<AdvancedChartPage> {
  late final WebViewController controller;
  String html = '''<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container" style="height:100%;width:100%">
  <div id="tradingview_dcc75" style="height:calc(100% - 32px);width:100%"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/tv.js"></script>
  <script type="text/javascript">
  new TradingView.widget(
  {
  "autosize": true,
  "symbol": "ahihi",
  "interval": "D",
  "timezone": "Asia/Ho_Chi_Minh",
  "theme": "dark",
  "style": "1",
  "locale": "vi_VN",
  "enable_publishing": false,
  "withdateranges": true,
  "hide_side_toolbar": false,
  "allow_symbol_change": true,
    "backgroundColor": "rgba(0, 0, 0, 1)",
  "container_id": "tradingview_dcc75"
}
  );
  </script>
</div>
<!-- TradingView Widget END -->''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: appBar(),
        body: WebViewWidget(
          controller: controller,
        ));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    html = html.replaceAll('ahihi', Common.money);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('progress');
          },
          onPageStarted: (String url) {
            debugPrint('started');
          },
          onPageFinished: (String url) {
            debugPrint('finished');
          },
        ),
      )
      ..enableZoom(false)
      ..loadHtmlString(html);
  }

  Widget technicalAnalytics() {
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.enableZoom(false);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    controller.setBackgroundColor(Colors.black);
    controller.loadHtmlString(html);
    return WebViewWidget(
      controller: controller,
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: BackButton(
        onPressed: () {
          Navigator.pop(context);
        },
        color: Colors.white,
      ),
      backgroundColor: Colors.black,
      title: Text(
        Common.money,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
