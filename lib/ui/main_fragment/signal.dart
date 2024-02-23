import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wolvesvn/models/signal.dart';

import '../../generated/common.dart';
import '../../models/tongpip.dart';
import '../../services/api_service.dart';

class SignalPage extends StatelessWidget {
  const SignalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.black,
      debugShowCheckedModeBanner: false,
      home: Container(
        color: Colors.black,
        child: DefaultTabController(
          length: 3,
          child: Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
                backgroundColor: Colors.black,
                bottom: const TabBar(
                  tabs: [
                    Tab(
                      text: 'Tín hiệu',
                    ),
                    Tab(
                      text: 'Tín hiệu wolves',
                    ),
                    Tab(
                      text: 'Thống kê',
                    )
                  ],
                ),
                title: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.wifi_tethering_outlined,
                      color: Colors.orange,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Tín hiệu",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )),
            body: TabBarView(
              children: [SignalVipPage(), WolvesSignalPage(), StatisticPage()],
            ),
          ),
        ),
      ),
    );
  }
}

class WolvesSignalPage extends StatelessWidget {
  const WolvesSignalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: wolvesSignal(),
      ),
    );
  }

  Widget wolvesSignal() {
    List<Signal> signalList = [];
    FirebaseDatabase database = FirebaseDatabase.instance;
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    DatabaseReference ref = database.ref('TinHieuPost').child(currentDate);
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          signalList.clear();
          var dataSnapshot = snapshot.data!.snapshot.children;
          for (var value in dataSnapshot) {
            var val = value.value as Map<dynamic, dynamic>;
            Signal signal = Signal(val["Content"], val["Date"], val["Id"], val["Image"],
              val["SL"], val["TP"],);
            signalList.add(signal);
          }
          signalList = signalList.reversed.toList();
          return Column(
            children: signalList.map((signal) {
              return Container(
                margin: const EdgeInsets.only(
                    left: 20, right: 20, top: 10, bottom: 10),
                child: Column(
                  children: [
                    itemSignal(signal),
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
            }).toList(),
          );
        }
        return Container();
      },
    );
  }

  Widget itemSignal(Signal signal) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              signal.Date!.split('T')[0],
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            signal.Content as String,
            style: const TextStyle(
                color: Colors.green, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Image.network(signal.Image.toString(), fit: BoxFit.fitWidth),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "TP: ${signal.TP}",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "SL: ${signal.SL}",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
      ],
    );
  }
}

class SignalVipPage extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  SignalVipPage({super.key});

  Widget wolvesSignal() {
    List<Signal> signalList = [];
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd');
    String currentDate = dateFormat.format(today);

    DatabaseReference ref = database.ref('BanLenh').child(currentDate);
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          signalList.clear();
          var dataSnapshot = snapshot.data!.snapshot.children;
          for (var value in dataSnapshot) {
            var val = value.value as Map<dynamic, dynamic>;

            List date = val["Date"].split("T")[0].split('-');
            String finalDate = '${date[2]} - ${date[1]} - ${date[0]}';
            Signal signal = Signal(val["Content"], finalDate, val["Id"],
                val["Image"], val["SL"], val["TP"]);
            signalList.add(signal);
          }
          signalList = signalList.reversed.toList();
          return Column(
            children: signalList.map((signal) {
              return Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    itemSignal(signal),
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
            }).toList(),
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget itemSignal(Signal signal) {
    String background = '';
    if (signal.Content.toString().contains("SELL")) {
      background = "assets/images/background_signal.png";
    } else {
      background = "assets/images/background_signal_wolves.png";
    }
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(background), fit: BoxFit.fitWidth),
      ),
      child: SizedBox(
        height: 200,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Date: ${signal.Date.toString()}",
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              signal.Content.toString(),
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        "TP : ${signal.TP.toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )),
                Expanded(child: Container()),
              ],
            ),
            Row(
              children: [
                Expanded(child: Container()),
                Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(left: 15),
                      child: Text(
                        "SL : ${signal.SL.toString()}",
                        style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    )),
                Expanded(child: Container()),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black87,
      child: SingleChildScrollView(
        child: wolvesSignal(),
      ),
    );
  }
}

class StatisticPage extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black54,
          body: SingleChildScrollView(
            child: Container(
              color: Colors.black54,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black54,
                        style: BorderStyle.none,
                        width: 0),
                    children: const [
                      TableRow(children: [
                        Column(
                          children: [
                            Text(
                              'PIPS',
                              style: TextStyle(
                                  fontSize: 18, color: Colors.deepOrange),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text('TRADES',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.deepOrange))
                          ],
                        ),
                        Column(
                          children: [
                            Text('WIN RATE',
                                style: TextStyle(
                                    fontSize: 18, color: Colors.deepOrange))
                          ],
                        ),
                      ])
                    ],
                  ),
                  Table(
                    border: TableBorder.all(
                        color: Colors.black54,
                        style: BorderStyle.none,
                        width: 0),
                    children: [
                      TableRow(children: [
                        Column(
                          children: [
                            Text(
                              Common.pip,
                              style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(Common.trades,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green))
                          ],
                        ),
                        Column(
                          children: [
                            Text(Common.winRate,
                                style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green))
                          ],
                        ),
                      ])
                    ],
                  ),
                  const Divider(
                    color: Colors.white,
                    height: 10,
                    thickness: 1,
                    indent: 5,
                    endIndent: 5,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FutureBuilder<Widget>(
                    future: listPip(),
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
                ],
              ),
            ),
          )),
    );
  }

  ApiServices apiServices =
  ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  Future<Widget> listPip() async {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    DatabaseReference ref = database.ref('TongPIP').child(currentDate);
    List<TongPip> tongPips = [];

    var res = apiServices.getTongPips();
    await res.then((value) {
      for (TongPip tongPip in value) {
        tongPips.add(tongPip);
      }
    }).onError((error, stackTrace) {
      print(error);
    }).catchError((Object obj) {
      print(obj);
    });

    return Column(
        children: tongPips.map((tongPip) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    tongPip.Date.split('T')[0],
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Text(
                  tongPip.Money,
                  style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              ]),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "TP : ${tongPip.TP}",
                        style: const TextStyle(color: Colors.green, fontSize: 18),
                      ),
                      Text(
                        "SL : ${tongPip.SL}",
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      )
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "PIP TP : ${tongPip.PipMoi}",
                        style: const TextStyle(color: Colors.green, fontSize: 18),
                      ),
                      Text(
                        "PIP SL : ${tongPip.PipCu}",
                        style: const TextStyle(color: Colors.red, fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
              const Divider(
                color: Colors.white,
                height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
            ],
          );
        }).toList());
  }
}