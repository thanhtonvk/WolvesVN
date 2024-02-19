import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:wolvesvn/models/sangiaodich.dart';
import 'package:wolvesvn/models/tintuc.dart';
import 'package:wolvesvn/services/api_service.dart';
import 'package:wolvesvn/ui/ea_page.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '../../generated/common.dart';
import '../../models/wolves_news.dart';
import '../tin_tuc_wolves.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: Colors.black54,
      home: Container(
        color: Colors.black,
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.black54,
            appBar: AppBar(
                backgroundColor: Colors.black54,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: "Lịch KT",
                    ),
                    Tab(
                      text: 'Tin tức',
                    ),
                    Tab(
                      text: 'WolvesVN',
                    ),
                    Tab(
                      text: 'EA',
                    ),
                  ],
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.feed_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Tin tức",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            body: TabBarView(
              children: [
                CalendarEconomy(),
                NormalNews(),
                WolvesNewsPage(),
                SanGiaoDichPage()
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CalendarEconomy extends StatelessWidget {
  CalendarEconomy({super.key});

  @override
  Widget build(BuildContext context) {
    return calendarWidget();
  }

  String html = '''
   <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
    
     <body>
   
<div class="tradingview-widget-container">
  <div class="tradingview-widget-container__widget"></div>
 <script type="text/javascript" src="https://s3.tradingview.com/external-embedding/embed-widget-events.js" async>
  {
  "width": "100%",
  "height": "100%",
  "colorTheme": "dark",
  "isTransparent": true,
  "locale": "vi_VN",
  "importanceFilter": "-1,0,1"
}
  </script>
</div>
     </body>

 </html>''';

  Widget calendarWidget() {
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
}

class VipNews extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  VipNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: listNews(),
      ),
    );
  }

  Widget listNews() {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd');
    String currentDate = dateFormat.format(today);

    DatabaseReference ref = database.ref('NewsVip').child(currentDate);
    List<TinTuc> newsList = [];
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          newsList.clear();
          var dataSnapshot = snapshot.data!.snapshot.children;
          for (var val in dataSnapshot) {
            var value = val.value as Map<dynamic, dynamic>;
            TinTuc tinTuc = TinTuc(value['Content'], value['Date'], value['Id'],
                value['Time'], value['Type']);
            newsList.add(tinTuc);
          }
          newsList = newsList.reversed.toList();
          return Column(
            children: newsList.map((news) {
              return Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          news.Date,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            news.Content,
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ]),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          news.Time,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    )
                  ],
                ),
              );
            }).toList(),
          );
        }
        return Container();
      },
    );
  }
}

class NormalNews extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  NormalNews({super.key});

  @override
  Widget build(BuildContext context) {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd');
    String currentDate = dateFormat.format(today);

    DatabaseReference ref = database.ref('News').child(currentDate);
    List<TinTuc> newsList = [];

    return Container(
        color: Colors.black87,
        child: SingleChildScrollView(
          child: StreamBuilder(
            stream: ref.onValue,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                newsList.clear();
                var dataSnapshot = snapshot.data!.snapshot.children;
                for (var val in dataSnapshot) {
                  var value = val.value as Map<dynamic, dynamic>;
                  TinTuc tinTuc = TinTuc(value['Content'], value['Date'],
                      value['Id'], value['Time'], value['Type']);
                  newsList.add(tinTuc);
                }
                newsList = newsList.reversed.toList();
                return Column(
                  children: newsList.map((news) {
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                news.Date,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  news.Content,
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ]),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                news.Time,
                                style: const TextStyle(color: Colors.white),
                              )
                            ],
                          )
                        ],
                      ),
                    );
                  }).toList(),
                );
              }
              return Container();
            },
          ),
        ));
  }
}

class WolvesNewsPage extends StatelessWidget {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  WolvesNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: FutureBuilder<Widget>(
            future: listWolvesNews(context),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
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
        )));
  }

  Widget itemNewsWolves(WolvesNews wolvesNews, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Common.wolvesNews = wolvesNews;
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => const TinTucWolvesPage(),
        ));
      },
      child: Column(
        children: [
          Text(
            wolvesNews.Titile,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
            textAlign: TextAlign.left,
          ),
          Image.network(
            wolvesNews.Image,
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            color: Colors.white,
            height: 10,
            thickness: 1,
            indent: 5,
            endIndent: 5,
          ),
        ],
      ),
    );
  }

  Future<Widget> listWolvesNews(BuildContext context) async {
    List<WolvesNews> wolvesNewsList = [];
    var res = apiServices.getWolvesNews('2022-1-1');
    await res.then(
      (value) {
        for (WolvesNews news in value) {
          wolvesNewsList.add(news);
        }
      },
    ).onError(
      (error, stackTrace) {
        print(error);
      },
    ).catchError((Object obj) {
      print('err');
    });
    return Column(
      children: wolvesNewsList.map((wolvesNews) {
        return itemNewsWolves(wolvesNews, context);
      }).toList(),
    );
  }
}

class SanGiaoDichPage extends StatelessWidget {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  SanGiaoDichPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black87,
        child: SingleChildScrollView(
          child: FutureBuilder<Widget>(
            future: getSanGiaoDichs(context),
            builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
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
        ));
  }

  Future<Widget> getSanGiaoDichs(BuildContext context) async {
    List<SanGiaoDich> sanGiaoDichList = [];
    var res = apiServices.getSanGiaoDich();
    await res.then(
      (value) {
        for (SanGiaoDich sanGD in value) {
          sanGiaoDichList.add(sanGD);
        }
      },
    ).onError(
      (error, stackTrace) {
        print(error);
      },
    ).catchError((Object obj) {
      print('err');
    });

    return Column(
      children: sanGiaoDichList.map((sanGiaoDich) {
        return GestureDetector(
          onTap: () {
            Common.sanGiaoDich = sanGiaoDich;
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const MyEAPage()),
            );
          },
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  sanGiaoDich.Titile,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  color: Colors.white,
                  height: 10,
                  thickness: 1,
                  indent: 5,
                  endIndent: 5,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
