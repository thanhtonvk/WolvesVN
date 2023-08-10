import 'package:dio/dio.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wolvesvn/models/sangiaodich.dart';
import 'package:wolvesvn/models/tintuc.dart';
import 'package:wolvesvn/models/video.dart';
import 'package:wolvesvn/services/api_service.dart';
import 'package:wolvesvn/ui/ea_page.dart';
import 'package:wolvesvn/ui/play_video.dart';

import '../../generated/common.dart';
import '../../models/wolves_news.dart';
import '../tin_tuc_wolves.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.black54,
          body: DefaultTabController(
            length: 5,
            child: Scaffold(
              backgroundColor: Colors.black54,
              appBar: AppBar(
                  backgroundColor: Colors.black54,
                  bottom: const TabBar(
                    tabs: [
                      Tab(
                        text: 'HOT',
                      ),
                      Tab(
                        text: 'Tin tức',
                      ),
                      Tab(
                        text: 'Wolves',
                      ),
                      Tab(
                        text: 'EA',
                      ),
                      Tab(
                        text: 'Video',
                      )
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
                  VipNews(),
                  NormalNews(),
                  WolvesNewsPage(),
                  SanGiaoDichPage(),
                  VideoPage()
                ],
              ),
            ),
          ),
        ));
  }
}

class VipNews extends StatelessWidget {
  FirebaseDatabase database = FirebaseDatabase.instance;

  VipNews({super.key});

  @override
  Widget build(BuildContext context) {
    if (Common.isVip) {
      return listNews();
    } else {
      return Container();
    }
  }

  Widget listNews() {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-MM-dd');
    String currentDate = dateFormat.format(today);
    if (Common.ACCOUNT.Email as String == 'WolvesVNteam@gmail.com') {
      currentDate = '2023-07-07';
    }

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
          return Row(
            children: [
              Expanded(
                  child: ListView.builder(
                itemCount: newsList.length,
                itemBuilder: (context, index) {
                  TinTuc news = newsList[index];
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
                },
              ))
            ],
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
    if (Common.ACCOUNT.Email as String == 'WolvesVNteam@gmail.com') {
      currentDate = '2023-07-07';
    }

    DatabaseReference ref = database.ref('News').child(currentDate);
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
          return ListView.builder(
            itemCount: newsList.length,
            itemBuilder: (context, index) {
              TinTuc news = newsList[index];
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
            },
          );
        }
        return Container();
      },
    );
  }
}

class WolvesNewsPage extends StatelessWidget {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  WolvesNewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: listWolvesNews(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the future to complete
          return const Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          // Show an error message if the future throws an error
          return Text('Error: ${snapshot.error}');
        } else {
          // Show the widget returned by the future
          return snapshot.data ??
              Container(); // Use a default value if data is null
        }
      },
    );
  }

  Future<Widget> listWolvesNews() async {
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
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: wolvesNewsList.length,
          itemBuilder: (context, index) {
            WolvesNews wolvesNews = wolvesNewsList[index];
            return GestureDetector(
              onTap: () {
                Common.wolvesNews = wolvesNews;
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const TinTucWolvesPage(),
                ));
              },
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        wolvesNews.Date.split('T')[0],
                        style: const TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                  Text(
                    wolvesNews.Titile,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                    textAlign: TextAlign.left,
                  ),
                  FittedBox(
                    fit: BoxFit.fill,
                    child: Image.network(
                      wolvesNews.Image,
                    ),
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
          },
        ))
      ],
    );
  }
}

class VideoPage extends StatelessWidget {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  VideoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: listVideo(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the future to complete
          return const Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          // Show an error message if the future throws an error
          return Text('Error: ${snapshot.error}');
        } else {
          // Show the widget returned by the future
          return snapshot.data ??
              Container(); // Use a default value if data is null
        }
      },
    );
  }

  Future<Widget> listVideo() async {
    List<Video> videoList = [];
    var res = apiServices.getVideos();
    await res.then(
      (value) {
        for (Video video in value) {
          videoList.add(video);
        }
      },
    ).onError(
      (error, stackTrace) {
        if (kDebugMode) {
          print(error);
        }
      },
    ).catchError((Object obj) {
      if (kDebugMode) {
        print('err');
      }
    });
    return Column(
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: videoList.length,
          itemBuilder: (context, index) {
            Video video = videoList[index];
            return GestureDetector(
              onTap: () {
                Common.video = video;
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyPlayVideo()),
                );
              },
              child: Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(video.Content,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
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
          },
        ))
      ],
    );
  }
}

class SanGiaoDichPage extends StatelessWidget {
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  SanGiaoDichPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: getSanGiaoDichs(),
      builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while waiting for the future to complete
          return const Center(
              child: SizedBox(
                  width: 50, height: 50, child: CircularProgressIndicator()));
        } else if (snapshot.hasError) {
          // Show an error message if the future throws an error
          return Text('Error: ${snapshot.error}');
        } else {
          // Show the widget returned by the future
          return snapshot.data ??
              Container(); // Use a default value if data is null
        }
      },
    );
  }

  Future<Widget> getSanGiaoDichs() async {
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
      children: [
        Expanded(
            child: ListView.builder(
          itemCount: sanGiaoDichList.length,
          itemBuilder: (context, index) {
            SanGiaoDich sanGiaoDich = sanGiaoDichList[index];
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
          },
        ))
      ],
    );
  }
}
