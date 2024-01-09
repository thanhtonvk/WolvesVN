import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wolvesvn/ui/general_ui/doi_mat_khau.dart';
import 'package:wolvesvn/ui/general_ui/doi_tac.dart';
import 'package:wolvesvn/ui/general_ui/lien_he.dart';
import 'package:wolvesvn/ui/general_ui/update_infomation.dart';

import '../../generated/common.dart';
import '../../services/api_service.dart';
import '../login.dart';

class GeneralPage extends StatelessWidget {
  GeneralPage({super.key});

  @override
  Widget build(BuildContext context) {
    String logo = '';
    if (Common.isVip) {
      logo = 'assets/images/logo-vip.png';
    } else {
      logo = 'assets/images/logo.png';
    }
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
              color: Colors.black87,
          child: Column(
            children: [
              Row(
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
              ),
              const Divider(
                color: Colors.white,
                height: 10,
                thickness: 1,
                indent: 5,
                endIndent: 5,
              ),
              const SizedBox(height: 20),
              generalWidget(context)
            ],
          ),
        )));
  }

  Widget generalWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateInformationPage()),
                    );
                  },
                  child: const Text(
                    'Cập nhật thông tin',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyDoiTac()));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Đối tác',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyLienHePage()),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Liên hệ',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DoiMatKhauPage()),
                    );
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    block(context);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Xoá tài khoản',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    openBrowser('http://wolves-vn.ddns.net/');
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Trang web',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 45,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => Login(),
                    ));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  child: const Text(
                    'Đăng xuất',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  void block(BuildContext context) {
    Common.showAlertDialog(context, "Cảnh báo", "Tài khoản của bạn sẽ bị xoá");
    apiServices.blockAccount(Common.ACCOUNT.Id!).then(
      (value) {
        Common.showAlertDialog(
            context, "Thông báo", "Tài khoản của bạn đã bị xoá, hãy đăng xuất");
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Login(),
        ));
      },
    ).onError((error, stackTrace) {
      Common.showAlertDialog(context, "Thông báo", "Có lỗi xảy ra");
    }).catchError((Object obj) {
      Common.showAlertDialog(context, "Thông báo", "Có lỗi xảy ra");
    });
  }

  Future<void> openBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(url, forceSafariVC: false);
    } else {
      throw 'Could not launch $url';
    }
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
}
