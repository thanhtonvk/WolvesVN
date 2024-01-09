import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:wolvesvn/ui/advanced_chart_page.dart';
import '../generated/common.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TradingPageState();
  }
}

class TradingPageState extends State<TradingPage> {
  String html = '''<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-technical-analysis.js" async>
  {
  "interval": "1m",
  "width": "100%",
  "isTransparent": true,
  "height": "100%",
  "symbol": "ahihi",
  "showIntervalTabs": true,
  "displayMode": "single",
  "locale": "vi_VN",
  "colorTheme": "dark"
}
  </script>
</div>
<!-- TradingView Widget END -->''';
  String htmlFinancials = '''<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-financials.js" async>
  {
  "colorTheme": "dark",
  "isTransparent": true,
  "largeChartUrl": "",
  "displayMode": "regular",
  "width": "480",
  "height": "830",
  "symbol": "ahihi",
  "locale": "vi_VN"
}
  </script>
</div>
<!-- TradingView Widget END -->''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: SingleChildScrollView(
        child:Container(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 450,
                child: Card(
                  color: Colors.black12,
                  child: technicalAnalytics(),
                ),
              ),

              SizedBox(
                  height: 830,
                  child: Card(
                    color: Colors.black12,
                    child: financialAnalytics(),
                  )),
            ],
          ),
        )

      ),
    );
  }

  Widget financialAnalytics() {
    htmlFinancials = htmlFinancials.replaceAll('ahihi', Common.money);
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.enableZoom(false);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    controller.setBackgroundColor(Colors.black);
    controller.loadHtmlString(htmlFinancials);
    return WebViewWidget(
      controller: controller,
    );
  }

  Widget technicalAnalytics() {
    html = html.replaceAll('ahihi', Common.money);
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
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AdvancedChartPage()),
              );
            },
            icon: const Icon(
              Icons.candlestick_chart_outlined,
              color: Colors.white,
              size: 34,
            ))
      ],
      backgroundColor: Colors.black,
      title: Text(
        Common.money,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
