import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolvesvn/models/doitac.dart';
import 'package:wolvesvn/ui/main_page.dart';

import '../../services/api_service.dart';

class MyDoiTac extends StatefulWidget {
  const MyDoiTac({super.key});

  @override
  State<StatefulWidget> createState() {
    return DoiTacState();
  }
}

class DoiTacState extends State<MyDoiTac> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        appBar: AppBar(
          leading: BackButton(
            onPressed: () => Navigator.pop(context),
            color: Colors.white,
          ),
          title: const Text(
            "Đối tác",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
            child: FutureBuilder<Widget>(
          future: getListDoiTac(),
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
        )));
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  Future<Widget> getListDoiTac() async {
    List<DoiTac> doiTacList = [];
    await apiServices.getDoiTacs().then(
      (value) {
        for (DoiTac doiTac in value) {
          doiTacList.add(doiTac);
        }
      },
    ).onError(
      (error, stackTrace) {
        print(error);
      },
    ).catchError((Object obj) {
      print(obj);
    });
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: doiTacList.length,
            itemBuilder: (context, index) {
              DoiTac doiTac = doiTacList[index];
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      openBrowser(doiTac.TrangWeb);
                    },
                    title: Text(
                      doiTac.TenDoiTac,
                      style: const TextStyle(
                          color: Colors.orange, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      doiTac.ThongTinKhac,
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                  const Divider(height: 0),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
