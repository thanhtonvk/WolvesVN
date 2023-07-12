import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wolvesvn/models/gold.dart';
import 'package:wolvesvn/models/signal.dart';
import 'package:wolvesvn/ui/xau_page.dart';

import '../../generated/common.dart';

class SignalPage extends StatelessWidget {
  const SignalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black54,
          appBar: AppBar(
              backgroundColor: Colors.black54,
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Tín hiệu',
                  ),
                  Tab(
                    text: 'Tín hiệu wolves',
                  ),
                  Tab(
                    text: 'XAU/GOLD',
                  ),
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
            children: [SignalVipPage(), WolvesSignalPage(), GoldPage()],
          ),
        ),
      ),
    );
  }
}

class GoldPage extends StatelessWidget {
  const GoldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: getGold(),
    );
  }

  Widget getGold() {
    List<Gold> goldList = [];
    FirebaseDatabase database = FirebaseDatabase.instance;
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    DatabaseReference reference = database.ref('Golds').child(currentDate);
    return StreamBuilder(
      stream: reference.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          goldList.clear();
          var dataSnapshot = snapshot.data!.snapshot.children;
          for (var val in dataSnapshot) {
            var value = val.value as Map<dynamic, dynamic>;
            Gold gold = Gold(value['BuyInto'], value['Content'], value['Date'],
                value['Id'], value['SoldOut'], value['Symbol']);
            goldList.add(gold);
          }
          goldList = goldList.reversed.toList();
          return Expanded(
              child: ListView.builder(
            itemCount: goldList.length,
            itemBuilder: (context, index) {
              Gold gold = goldList[index];
              return GestureDetector(
                onTap: () {
                  Common.gold = gold;
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => XAUPage()),
                  );
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          gold.Date!.split('T')[0],
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Column(children: [
                      Text(
                        gold.Symbol as String,
                        style: const TextStyle(
                            color: Colors.green, fontWeight: FontWeight.bold),
                      ),
                    ]),
                    const Divider(
                      color: Colors.white,
                      height: 10,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                    const SizedBox(
                      height: 20,
                    )
                  ],
                ),
              );
            },
          ));
        }
        return Container();
      },
    );
  }
}

class WolvesSignalPage extends StatelessWidget {
  const WolvesSignalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: wolvesSignal(),
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
            Signal signal = Signal(val["Content"], val["Date"], val["Id"], "",
                val["SL"], val["TP"]);
            signalList.add(signal);
          }
          signalList = signalList.reversed.toList();
          return Expanded(
              child: ListView.builder(
                  itemCount: signalList.length,
                  itemBuilder: (context, index) {
                    Signal signal = signalList[index];
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
                        const SizedBox(
                          height: 5,
                        ),
                        Center(
                          child: Text(
                            signal.Content as String,
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
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
                        const Divider(
                          color: Colors.white,
                          height: 10,
                          thickness: 1,
                          indent: 5,
                          endIndent: 5,
                        ),
                      ],
                    );
                  }));
        }
        return Container();
      },
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
        if (Common.isVip) {
          if (snapshot.hasData) {
            signalList.clear();
            var dataSnapshot = snapshot.data!.snapshot.children;
            for (var value in dataSnapshot) {
              var val = value.value as Map<dynamic, dynamic>;
              Signal signal = Signal(val["Content"], val["Date"], val["Id"],
                  val["Image"], val["SL"], val["TP"]);
              signalList.add(signal);
            }
            signalList = signalList.reversed.toList();
            return Expanded(
                child: ListView.builder(
              itemCount: signalList.length,
              itemBuilder: (context, index) {
                Signal signal = signalList[index];
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
                    FittedBox(
                      fit: BoxFit.fill,
                      child: Image.network(
                        signal.Image as String,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          signal.Content as String,
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
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
                    const Divider(
                      color: Colors.white,
                      height: 10,
                      thickness: 1,
                      indent: 5,
                      endIndent: 5,
                    ),
                  ],
                );
              },
            ));
          } else {
            return Container();
          }
        }

        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: wolvesSignal(),
    );
  }
}
