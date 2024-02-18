import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:wolvesvn/ui/advanced_chart_page.dart';
import '../generated/common.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class TradingPage extends StatefulWidget {
  const TradingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TradingPageState();
  }
}

class TradingPageState extends State<TradingPage> {
  String html = '''
   <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
    
     <body>
     
       <div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
<script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-technical-analysis.js" async>
  {
  "interval": "SETTIME",
  "width": "100%",
  "isTransparent": true,
  "height": "100%",
  "symbol": "FXSymbol",
  "showIntervalTabs": false,
  "displayMode": "single",
  "locale": "vi_VN",
  "colorTheme": "dark"
}
  </script>
</div>
     </body>

 </html>''';
  String htmlSingleSymbol = '''
   <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
    
     <body>
     
        <!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
  <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-symbol-info.js" async>
  {
  "symbol": "FXSymbol",
  "width": "100%",
  "locale": "vi_VN",
  "colorTheme": "dark",
  "isTransparent": true
}
  </script>
</div>
<!-- TradingView Widget END -->
     </body>

 </html>
  
''';
  List<String> listTimeVip = [
    "1m",
    "5m",
    "15m",
    "30m",
    "1h",
    "2h",
    "4h",
    "1D",
    "1W",
    "1M"
  ];
  List<String> listTimeNormal = ["1m", "5m", "15m"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: appBar(),
      body: SingleChildScrollView(
          child: Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            dropDownTimer(),
            SizedBox(
              height: 300,
              child: Card(
                color: Colors.black12,
                child: singleSymbol(),
              ),
            ),
            SizedBox(
              height: 350,
              child: Card(
                color: Colors.black12,
                child: technicalAnalytics(),
              ),
            ),

            Container(
              margin: EdgeInsets.all(5),
              child: const Text(
                "Miễn trừ trách nhiệm: Báo cáo này chỉ được cung cấp để tham khảo, được cung cấp dựa trên một số giả định và điều kiện thị trường tại ngày báo cáo và có thể được thay đổi mà không cần thông báo. WolvesVN không chịu bất kỳ trách nhiệm nào liên quan đến việc sử dụng hoặc dựa trên thông tin và ý kiến được trình bày trong báo cáo này.",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            )
          ],
        ),
      )),
    );
  }

  String? selectedValue = "5m";

  Widget dropDownTimer() {
    List<String> items = [];
    if (Common.isVip) {
      items = listTimeVip;
    } else {
      items = listTimeNormal;
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.candlestick_chart_outlined,
                color: Colors.blue,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Khung nến phân tích:",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        DropdownButtonHideUnderline(
          child: DropdownButton2<String>(
            isExpanded: true,
            hint: const Row(
              children: [
                Icon(
                  Icons.timeline,
                  size: 16,
                  color: Colors.yellow,
                ),
                SizedBox(
                  width: 4,
                ),
                Expanded(
                  child: Text(
                    '5m',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            items: items
                .map((String item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(
                        item,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.yellow,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ))
                .toList(),
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                selectedValue = value;
              });
            },
            buttonStyleData: ButtonStyleData(
              height: 50,
              width: 150,
              padding: const EdgeInsets.only(left: 14, right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: Colors.black26,
                ),
                color: Colors.transparent,
              ),
              elevation: 2,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(
                Icons.arrow_forward_ios_outlined,
              ),
              iconSize: 14,
              iconEnabledColor: Colors.yellow,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.black45,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: MaterialStateProperty.all(6),
                thumbVisibility: MaterialStateProperty.all(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget singleSymbol() {
    htmlSingleSymbol = htmlSingleSymbol.replaceAll('FXSymbol', Common.money);
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      controller.enableZoom(false);
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    } else {
      controller.enableZoom(false);
    }
    controller.setBackgroundColor(Colors.black);
    controller.loadHtmlString(htmlSingleSymbol);
    return WebViewWidget(
      controller: controller,
    );
  }

  Widget technicalAnalytics() {
    String new_html = html.replaceAll("SETTIME", selectedValue.toString());
    new_html = new_html.replaceAll('FXSymbol', Common.money);
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);

    if (controller.platform is AndroidWebViewController) {
      controller.enableZoom(false);
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    } else {
      controller.enableZoom(false);
    }
    controller.setBackgroundColor(Colors.black);
    controller.loadHtmlString(new_html);
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
