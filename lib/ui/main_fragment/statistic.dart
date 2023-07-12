import 'dart:math';

import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wolvesvn/models/tongpip.dart';

import '../../generated/common.dart';

class StatisticPage extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  StatisticPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black54,
        appBar: AppBar(
          backgroundColor: Colors.black54,
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.data_exploration,
                color: Colors.orange,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "Thống kê",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
        body: Container(
          color: Colors.black54,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(
                height: 20,
              ),
              Table(
                border: TableBorder.all(
                    color: Colors.black54, style: BorderStyle.none, width: 0),
                children: const [
                  TableRow(children: [
                    Column(
                      children: [
                        Text(
                          'PIPS',
                          style:
                              TextStyle(fontSize: 18, color: Colors.deepOrange),
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
                    color: Colors.black54, style: BorderStyle.none, width: 0),
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
              listPip(),
            ],
          ),
        ),
      ),
    );
  }

  Widget listPip() {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    DatabaseReference ref = database.ref('TongPIP').child(currentDate);
    List<TongPip> tongPips = [];
    return StreamBuilder(
      stream: ref.onValue,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          tongPips.clear();
          var dataSnapshot = snapshot.data!.snapshot.children;
          for (var val in dataSnapshot) {
            var value = val.value as Map<dynamic, dynamic>;
            TongPip tongPip = TongPip(
                value['Date'],
                value['Id'],
                value['Money'],
                value['PipCu'],
                value['PipMoi'],
                value['SL'],
                value['TP']);
            tongPips.add(tongPip);
          }
          tongPips = tongPips.reversed.toList();
          return Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              TongPip tongPip = tongPips[index];
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
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
                    height: 10,
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
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "TP: ${tongPip.TP}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "SL: ${tongPip.SL}",
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 18),
                                ),
                              ]),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "PIP MỚI: ${tongPip.PipMoi}",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                              ]),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "PIP CŨ: ${tongPip.PipCu}",
                                  style: const TextStyle(
                                      color: Colors.green, fontSize: 18),
                                ),
                              ]),
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
            },
            itemCount: tongPips.length,
          ));
        }
        return Container();
      },
    );
  }
}
