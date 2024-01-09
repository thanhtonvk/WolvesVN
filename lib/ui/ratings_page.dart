import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolvesvn/models/rating.dart';
import 'package:wolvesvn/services/api_service.dart';

import '../generated/common.dart';
import '../models/san.dart';

class RatingsPage extends StatefulWidget {
  const RatingsPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return RatingsState();
  }
}

class RatingsState extends State<RatingsPage> {
  San san = Common.san;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () {
              Navigator.pop(context);
            },
            color: Colors.white,
          ),
          backgroundColor: Colors.black,
          title: Text(
            "Sàn ${san.Name.toString()}",
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: Container(color: Colors.black, child: informationExchanges()));
  }

  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  Widget informationExchanges() {
    return Container(
      color: Colors.black,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: SizedBox(
                height: 80,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        child: Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            "Thông tin chi tiết sàn",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Padding(padding: EdgeInsets.only(bottom: 2.0)),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: GestureDetector(
                            child: Text(
                              san.Website.toString(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14.0,
                                color: Colors.blue,
                              ),
                            ),
                            onTap: () {
                              openBrowser(san.Website.toString());
                            },
                          )),
                        ],
                      ),
                    )),
                    AspectRatio(
                      aspectRatio: 1.0,
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(san.Image.toString())),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Năm thành lập",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 150,
                          child: Text(
                            san.Year.toString(),
                            style: const TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        maxLines: 3,
                        "Trụ sở",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 150,
                          child: Text(
                            san.Address.toString(),
                            style: const TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        maxLines: 3,
                        "Nền tảng giao dịch",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 150,
                          child: Text(
                            san.TradePlatform.toString(),
                            style: const TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Đòn bẩy tối đa",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                          width: 150,
                          child: Text(
                            san.Pushmax.toString(),
                            style: const TextStyle(color: Colors.white),
                          ))
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Sản phẩm giao dịch",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          maxLines: 4,
                          san.TradeProduct.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Hình thức nạp",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          maxLines: 10,
                          san.Method.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Giấy phép",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 150,
                        child: Text(
                          maxLines: 10,
                          san.License.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    san.Detail.toString(),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Đánh giá sàn",
                    style: TextStyle(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  FutureBuilder<Widget>(
                    future: reviewExchanges(),
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
            )
          ],
        ),
      ),
    );
  }

  List<Rating> ratingList = [];

  Future<Widget> reviewExchanges() async {
    ratingList = [];
    var res = apiServices.getRatings(san.Id!.toInt());
    await res.then((value) {
      for (Rating rating in value) {
        ratingList.add(rating);
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
    return Container(
      color: Colors.black,
      child: Column(
        children: ratingList.map((e) {
          return reviewItem(e);
        }).toList(),
      ),
    );
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget reviewItem(Rating e) {
    Rating rating = e;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              rating.Name.toString(),
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              "${rating.Date?.day.toString()}/${rating.Date?.month.toString()}/${rating.Date?.year.toString()}",
              style: const TextStyle(color: Colors.white),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          rating.Content.toString(),
          style: const TextStyle(color: Colors.white),
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
    );
  }
}
