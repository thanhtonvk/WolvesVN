import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const UpdateInformationPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.person_outline,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Cá nhân",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyDoiTac()));
                      },
                      icon: const Icon(
                        Icons.handshake_outlined,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Đối tác",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyLienHePage()),
                        );
                      },
                      icon: const Icon(
                        Icons.call_outlined,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Liên hệ",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DoiMatKhauPage()),
                        );
                      },
                      icon: const Icon(
                        Icons.lock_open,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Mật khẩu",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        block(context);
                      },
                      icon: const Icon(
                        Icons.no_accounts_outlined,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Xóa tài khoản",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: SizedBox(
                    height: 96,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.white10),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      side:
                                          BorderSide(color: Colors.white12)))),
                      onPressed: () {
                        openBrowser('http://app.wolvesvn.com/');
                      },
                      icon: const Icon(
                        Icons.webhook,
                        color: Colors.white,
                        size: 48,
                      ),
                      label: const Text(
                        "Trang web",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white10),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            side: BorderSide(color: Colors.white12)))),
                onPressed: () {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => Login(),
                  ));
                },
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                  size: 24,
                ),
                label: const Text(
                  "Đăng xuất",
                  style: TextStyle(color: Colors.white),
                ),
              ),
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
    Uri _url = Uri.parse(url);
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
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
