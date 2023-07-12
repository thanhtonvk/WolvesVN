import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/common.dart';
import '../../services/api_service.dart';

class DoiMatKhauPage extends StatefulWidget {
  const DoiMatKhauPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return DoiMatKhauState();
  }
}

class DoiMatKhauState extends State<DoiMatKhauPage> {
  TextEditingController edtOldPassword = TextEditingController();
  TextEditingController edtNewPassword = TextEditingController();
  ApiServices apiServices =
  ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  void updateInformation() {
    String oldPassword = edtOldPassword.text;
    String newPassword = edtNewPassword.text;
    if (oldPassword.isNotEmpty && newPassword.isNotEmpty) {
      Common.showLoadingDialog(context, "Đang cập nhật");

      apiServices
          .changePassword(
          Common.ACCOUNT.Email as String, oldPassword, newPassword)
          .then(
            (value) {
          Common.hideLoadingDialog(context);
          Common.showAlertDialog(context, "Thông báo", "Thành công");
        },
      ).onError(
            (error, stackTrace) {
          Common.hideLoadingDialog(context);
          Common.showAlertDialog(context, "Thông báo", "Thất bại");
        },
      ).catchError((Object obj) {
        Common.hideLoadingDialog(context);
        Common.showAlertDialog(context, "Thông báo", "Thất bại, lỗi kết nối");
      });
    } else {
      Common.showAlertDialog(
          context, "Thông báo", "Thông tin không được bỏ trống");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.black,
        title: const Text(
          "Đổi mật khẩu",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              obscureText: true,
              controller: edtOldPassword,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Nhập mật khẩu cũ',
                  hintStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              obscureText: true,
              controller: edtNewPassword,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Nhập mật khẩu mới",
                  hintStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                  onPressed: () {
                    updateInformation();
                  },
                  style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text(
                    'Đổi mật khẩu',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
