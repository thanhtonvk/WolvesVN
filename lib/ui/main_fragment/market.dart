import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:wolvesvn/models/quangcao.dart';
import 'package:wolvesvn/ui/trading_page.dart';
import '../../generated/common.dart';
import '../../services/api_service.dart';

class MarketUI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MarketState();
  }
}

class MarketState extends State<MarketUI> {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  FirebaseDatabase database = FirebaseDatabase.instance;
  String logo = '';
  List stocks = [];

  @override
  Widget build(BuildContext context) {
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
              header(),
              const Divider(
                color: Colors.white,
                height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: FutureBuilder<Widget>(
                  future: advertising(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while waiting for the future to complete
                      return const Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      // Show an error message if the future throws an error
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Show the widget returned by the future
                      return snapshot.data ??
                          Container(); // Use a default value if data is null
                    }
                  },
                ),
              ),
              Expanded(
                child: FutureBuilder<Widget>(
                  future: gridMoney(),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Show a loading indicator while waiting for the future to complete
                      return const Center(
                          child: SizedBox(
                              width: 50,
                              height: 50,
                              child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      // Show an error message if the future throws an error
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Show the widget returned by the future
                      return snapshot.data ??
                          Container(); // Use a default value if data is null
                    }
                  },
                ),
              )
            ],
          ),
        ));
  }

  @override
  void initState() {
    // TODO: implement initStat
    super.initState();
  }

  Future<Widget> gridMoney() async {
    var res = apiServices.getSymbols();
    await res.then((value) {
      for (String symbol in value) {
        stocks.add(symbol);
      }
    }).onError((error, stackTrace) {
      print(error);
    }).catchError((Object obj) {
      print(obj);
    });
    stocks = stocks.reversed.toList();
    return Container(
        padding: EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: stocks.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1 / .5),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Common.money = "FOREXCOM:" + stocks[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TradingPage()),
                  );
                },
                child: Stack(
                  children: [
                    webview(stocks[index]),
                    const Card(
                      color: Colors.transparent,
                      child: SizedBox(
                        width: 300,
                        height: 300,
                      ),
                    )
                  ],
                ));
          },
        ));
  }

  Widget webview(String stock) {
    String html = '''<!-- TradingView Widget BEGIN -->
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
 <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-single-quote.js" async>
  {
  "symbol": "ENTITY",
  "width": "100%",
  "colorTheme": "dark",
  "isTransparent": true,
  "locale": "vi_VN"
}
  </script>
</div>
<!-- TradingView Widget END -->'''
        .replaceAll('ENTITY', 'FOREXCOM:' + stock);
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

  Widget header() {
    return Row(
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
    );
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<Widget> advertising() async {
    List<QuangCao> quangCaoList = [];
    var res = apiServices.getQuangCaos();
    await res.then((value) {
      for (QuangCao quangCao in value) {
        quangCaoList.add(quangCao);
      }
    }).onError((error, stackTrace) {
      print(error);
    }).catchError((Object obj) {
      print(obj);
    });

    return CarouselSlider(
      options: CarouselOptions(
          height: 150, aspectRatio: 3 / 2, autoPlay: true, reverse: true),
      items: quangCaoList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return GestureDetector(
              onTap: () {
                print(i.Link.toString());
                openBrowser(i.Link.toString());
              },
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 1.0),
                  decoration: BoxDecoration(color: Common.backgroundColor),
                  child: Image.network(i.Image.toString())),
            );
          },
        );
      }).toList(),
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

class MarketPage extends StatelessWidget {
  MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketUI();
  }
}
