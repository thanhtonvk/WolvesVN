import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MyLienHePage extends StatefulWidget {
  const MyLienHePage({super.key});

  @override
  State<StatefulWidget> createState() {
    return LienHeState();
  }
}

class LienHeState extends State<MyLienHePage> {
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
            "Liên hệ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.black,
        ),
        body: SafeArea(
          child: getContact(),
        ));
  }

  Future<void> sendMail() async {
    String title = '';
    String message = '';
    final Uri params = Uri(
      scheme: 'mailto',
      path: 'WolvesVNTeam@gmail.com',
      query: 'subject=$title&body=$message',
    );

    var url = params.toString();
    await launch(url);
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getContact() {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          const ListTile(
            leading: Icon(
              Icons.share_location_rounded,
              color: Colors.white,
            ),
            title: Text(
              "Địa chỉ",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              "Toà Nhà Gold Coast Số 1 Trần Hưng Đạo, TP.Nha Trang, Khánh Hoà",
              style: TextStyle(color: Colors.white),
            ),
          ),
          ListTile(
            leading: Icon(Icons.email, color: Colors.white),
            onTap: () {
              sendMail();
            },
            title: const Text(
              "Email",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("WolvesVNTeam@gmail.com",
                style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.phone, color: Colors.white),
            onTap: () {
              launch("tel://0969239222");
            },
            title: const Text(
              "Hotline",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("0969.239.222",
                style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.web, color: Colors.white),
            onTap: () {
              openBrowser('https://wolvesvn.com/');
            },
            title: const Text(
              "Website",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("https://wolvesvn.com/",
                style: TextStyle(color: Colors.white)),
          ),
          ListTile(
            leading: Icon(Icons.telegram, color: Colors.white),
            onTap: () {
              openBrowser('https://t.me/wolvesvn_chanel');
            },
            title: const Text(
              "Telegram",
              style:
                  TextStyle(color: Colors.orange, fontWeight: FontWeight.bold),
            ),
            subtitle: const Text("https://t.me/wolvesvn_chanel",
                style: TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
