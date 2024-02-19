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

  String html = '''
   <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
    
     <body>
   
   <div class="tradingview-widget-container" style="height:100%;width:100%">
  <div class="tradingview-widget-container__widget" style="height:calc(100% - 32px);width:100%"></div>
  <div class="tradingview-widget-copyright"><a href="https://wolvesvn.com/" rel="noopener nofollow" target="_blank"><span class="blue-text">Theo dõi mọi thị trường trên WolvesVN</span></a></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-advanced-chart.js" async>
  {
  "autosize": true,
  "symbol": "FXSYMBOL",
  "interval": "D",
  "timezone": "Asia/Ho_Chi_Minh",
  "theme": "dark",
  "style": "1",
  "locale": "vi_VN",
  "backgroundColor": "rgba(0, 0, 0, 1)",
  "gridColor": "rgba(255, 255, 255, 0.06)",
  "enable_publishing": false,
  "allow_symbol_change": false,
  "calendar": true,
  "support_host": "https://wolvesvn.com/"
}
  </script>
</div>
     </body>

 </html>''';

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
    html = html.replaceAll('FXSYMBOL', Common.money);
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('ok');
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
      actions: [
        IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.candlestick_chart_outlined,
              color: Colors.white,
              size: 34,
            ))
      ],
      backgroundColor: Colors.black,
      title: Center(
        child: Text(
          Common.money,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
