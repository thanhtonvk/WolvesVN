import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../generated/common.dart';
import '../../services/api_service.dart';

class UpdateInformationPage extends StatefulWidget {
  const UpdateInformationPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return UpdateInformationState();
  }
}

class UpdateInformationState extends State<UpdateInformationPage> {
  TextEditingController edtFirstName = TextEditingController();
  TextEditingController edtLastName = TextEditingController();
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  void updateInformation() {
    String firstName = edtFirstName.text;
    String lastName = edtLastName.text;
    if (firstName.isNotEmpty && lastName.isNotEmpty) {
      Common.showLoadingDialog(context, "Đang cập nhật");
      Common.ACCOUNT.FirstName = firstName;
      Common.ACCOUNT.LastName = lastName;
      apiServices.updateAccount(Common.ACCOUNT).then(
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
          "Cập nhật thông tin cá nhân",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              controller: edtFirstName,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: 'Nhập tên',
                  hintStyle: const TextStyle(fontSize: 18),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  )),
            ),
            const SizedBox(
              height: 15,
            ),
            TextField(
              controller: edtLastName,
              style: const TextStyle(color: Colors.black),
              decoration: InputDecoration(
                  fillColor: Colors.grey.shade100,
                  filled: true,
                  hintText: "Nhập họ",
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
                    'Cập nhật thông tin',
                    style: TextStyle(fontSize: 25, color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
