import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:wolvesvn/ui/ratings_page.dart';

import '../../generated/common.dart';
import '../../models/san.dart';
import '../../services/api_service.dart';

class ExchangesPage extends StatelessWidget {
  ExchangesPage({super.key});

  List<San> sanList = [];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.candlestick_chart_outlined,
                    color: Colors.orange,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Đánh giá Sàn",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              )),
          body: Container(
            color: Colors.black,
            child: FutureBuilder<Widget>(
              future: exchangesList(context),
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
          )),
    );
  }

  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  Future<Widget> exchangesList(BuildContext context) async {
    sanList = [];
    var res = apiServices.getSans();
    await res.then((value) {
      for (San san in value) {
        sanList.add(san);
      }
    }).onError((error, stackTrace) {
      if (kDebugMode) {
        print(error);
      }
    }).catchError((Object obj) {
      if (kDebugMode) {
        print(obj);
      }
    });
    return ListView.builder(
      itemCount: sanList.length,
      itemBuilder: (context, index) {
        return exchangesItem(index, context);
      },
    );
  }

  Widget exchangesItem(int index, BuildContext context) {
    San san = sanList[index];
    return GestureDetector(
      onTap: () {
        Common.san = san;
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RatingsPage()),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: SizedBox(
              height: 100,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(san.Image.toString())),
                  ),
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          san.Name.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                        Expanded(
                          child: Text(
                            san.Detail.toString(),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Chuyên gia",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.green),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                            "${san.ExpertPoint!.toDouble()}",
                          )
                        ],
                      ))
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Nhà đầu tư",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Colors.red),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${san.InvesterPoint!.toDouble()}",
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ))
                ],
              ),
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
      ),
    );
  }
}
