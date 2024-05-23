import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:wolvesvn/models/fxsymbol.dart';
import 'package:wolvesvn/models/quangcao.dart';
import 'package:wolvesvn/ui/trading_page.dart';
import '../../easy_search_bar.dart';
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
  List<FxSymbol> stocks = [];
  var f = NumberFormat("###.0#", "en_US");
  List<String> listStockStorage = [];
  late SharedPreferences prefs;

  void loadListStorage() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey("stocks")) {
      listStockStorage = prefs.getStringList("stocks")!;
      print('list stock');
      print(listStockStorage);
    } else {
      listStockStorage = [
        "EURUSD",
        "XAUUSD",
        "GBPUSD",
        "USDCAD",
        "USDCHF",
        "NZDUSD",
        "AUDUSD",
        "GBPJPY",
        "BTCUSD",
        "ETHUSD"
      ];
      prefs.setStringList("stocks", listStockStorage);
    }
  }

  FxSymbol getSymbol(String symbol) {
    late FxSymbol result;
    for (FxSymbol fxSymbol in stocks) {
      if (fxSymbol.T == symbol) {
        result = fxSymbol;
        break;
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    if (Common.isVip) {
      logo = 'assets/images/logo-vip.png';
    } else {
      logo = 'assets/images/logo.png';
    }
    loadListStorage();
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
              Container(
                margin: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.transparent),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                    side: BorderSide(color: Colors.blue)))),
                        onPressed: () {
                          addDialog(context);
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blue,
                        ),
                        label: const Text(
                          "Thêm cặp",
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ),
                  ],
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
    List<FxSymbol> stocksList = [];
    var res = apiServices.getSymbols();
    await res.then((value) {
      stocks.clear();
      for (FxSymbol symbol in value) {
        symbol.T = symbol.T?.split(":")[1];
        stocks.add(symbol);
        if (listStockStorage.contains(symbol.T.toString())) {
          stocksList.add(symbol);
        }
      }

      print('length ${stocksList.length}');
    }).onError((error, stackTrace) {
      print(error);
    }).catchError((Object obj) {
      print(obj);
    });
    return Container(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: stocksList.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
              childAspectRatio: 1 / .5),
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
                onTap: () {
                  Common.money = "FX_IDC:" + stocksList[index].T.toString();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const TradingPage()),
                  );
                },
                child: symbolItem(stocksList[index]));
          },
        ));
  }

  Widget symbolItem(FxSymbol fxSymbol) {
    String name = fxSymbol.T.toString();
    double open = double.parse(fxSymbol.o.toString());
    double close = double.parse(fxSymbol.c.toString());
    double raise = close - open;
    double percent = (raise.abs() / open) * 100;
    Color color = Colors.green;
    String result = "";
    if (raise < 0) {
      color = Colors.red;
      result =
          "➘ ${percent.toStringAsFixed(2)}% (${raise.abs().toStringAsFixed(5)})";
    } else if (raise > 0) {
      result =
          "➚ ${percent.toStringAsFixed(2)}% (${raise.abs().toStringAsFixed(5)})";
    } else {
      color = Colors.yellow;
      result =
          "⬌ ${percent.toStringAsFixed(2)}% (${raise.abs().toStringAsFixed(5)})";
    }
    return Card(
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          Text(
            close.toStringAsFixed(5),
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
          Text(
            result,
            style: TextStyle(color: color, fontSize: 12),
          )
        ],
      ),
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
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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

  String searchValue = '';

  void addToStorage(String symbol) {
    if (!Common.isVip && listStockStorage.length >= 10) {
      Common.showAlertDialog(
          context, "Thông báo", "Bạn chỉ được thêm tối đa 10 cặp");
    } else {
      if (!listStockStorage.contains(symbol)) {
        listStockStorage.add(symbol);
        prefs.setStringList("stocks", listStockStorage);
        Navigator.of(context).pop();
        addDialog(context);
      } else {
        listStockStorage.remove(symbol);
        prefs.setStringList("stocks", listStockStorage);
        Navigator.of(context).pop();
        addDialog(context);
      }
    }
  }

  void addDialog(BuildContext context) {
    List<String> suggestions = [];
    for (FxSymbol symbol in stocks) {
      suggestions.add(symbol.T.toString());
    }
    Navigator.of(context).push(MaterialPageRoute<String>(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: EasySearchBar(
                searchBackgroundColor: Colors.deepOrangeAccent,
                backgroundColor: Colors.deepOrangeAccent,
                title: const Center(
                  child: Text(
                    'Cặp giá trị',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onSearch: (value) => setState(() => searchValue = value),
                onSuggestionTap: (data) {
                  addToStorage(data);
                },
                suggestions: suggestions),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(10),
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Phổ biến",
                    style: TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("USDCAD");
                        },
                        child: const Text(
                          "USD/CAD",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("EURUSD");
                        },
                        child: const Text(
                          "EUR/USD",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("AUDUSD");
                        },
                        child: const Text(
                          "AUD/USD",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("XAUUSD");
                        },
                        child: const Text(
                          "XAU/USD",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("USDRUB");
                        },
                        child: const Text(
                          "USD/RUB",
                          style: TextStyle(color: Colors.white),
                        ),
                      )),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white10),
                            shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                    side: BorderSide(color: Colors.white10)))),
                        onPressed: () {
                          addToStorage("USDCHF");
                        },
                        child: const Text(
                          "USD/CHF",
                          style: TextStyle(color: Colors.white),
                        ),
                      ))
                    ],
                  ),
                  Text(
                    "${stocks.length} cặp",
                    style: const TextStyle(
                        color: Colors.green, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Expanded(
                    child: SizedBox(
                      child: SingleChildScrollView(
                        child: Column(
                          children: stocks.map((stock) {
                            if (!listStockStorage
                                .contains(stock.T.toString())) {
                              return GestureDetector(
                                  onTap: () {
                                    addToStorage(stock.T.toString());
                                    setState(() {
                                      listStockStorage =
                                          prefs.getStringList("stocks")!;
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Divider(
                                            color: Colors.white24,
                                            height: 0,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          const SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    stock.T.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  double.parse(
                                                          stock.c.toString())
                                                      .toStringAsFixed(5),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              )),
                                              const Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Icons.add,
                                                  color: Colors.green,
                                                ),
                                              ))
                                            ],
                                          ),
                                        ],
                                      )));
                            } else {
                              return GestureDetector(
                                  onTap: () {
                                    addToStorage(stock.T.toString());
                                    setState(() {
                                      listStockStorage =
                                          prefs.getStringList("stocks")!;
                                    });
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(5),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          const Divider(
                                            color: Colors.white24,
                                            height: 0,
                                            thickness: 1,
                                            indent: 0,
                                            endIndent: 0,
                                          ),
                                          const SizedBox(height: 7),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Text(
                                                    stock.T.toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.white,
                                                        fontSize: 18),
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                  child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  double.parse(
                                                          stock.c.toString())
                                                      .toStringAsFixed(5),
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 18),
                                                ),
                                              )),
                                              const Expanded(
                                                  child: Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Icon(
                                                  Icons.remove,
                                                  color: Colors.red,
                                                ),
                                              ))
                                            ],
                                          ),
                                        ],
                                      )));
                            }
                          }).toList(),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
        fullscreenDialog: true));
  }
}

class MarketPage extends StatelessWidget {
  MarketPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MarketUI();
  }
}
