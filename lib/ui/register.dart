import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wolvesvn/models/account.dart';
import 'package:wolvesvn/ui/inviter.dart';

import '../generated/common.dart';
import '../services/api_service.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<StatefulWidget> createState() {
    return RegisterState();
  }
}

class RegisterState extends State<Register> {
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtPassword = TextEditingController();
  TextEditingController edtPrePassword = TextEditingController();
  TextEditingController edtFirstName = TextEditingController();
  TextEditingController edtLastName = TextEditingController();
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Common.backgroundColor,
      appBar: AppBar(
        backgroundColor: Common.backgroundColor,
        title: null,
      ),
      body: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Image.asset(
                    "assets/images/logo.png",
                    width: 150,
                    height: 150,
                    fit: BoxFit.contain,
                    scale: 0.1,
                  ),
                  const Text(
                    "Bạn tốt - Tôi tốt - Chúng ta cùng tốt",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.orange),
                  )
                ],
              ),
            ),
            SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      child: Column(
                        children: [
                          const Text(
                            "Đăng ký tài khoản",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextField(
                            controller: edtEmail,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: 'Email',
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
                            controller: edtPassword,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Mật khẩu",
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
                            controller: edtPrePassword,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Nhập lại mật khẩu",
                                hintStyle: const TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextField(
                            controller: edtFirstName,
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
                            height: 15,
                          ),
                          TextField(
                            controller: edtLastName,
                            style: const TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade100,
                                filled: true,
                                hintText: "Nhập tên",
                                hintStyle: const TextStyle(fontSize: 18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                )),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                                onPressed: () {
                                  register();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange),
                                child: const Text(
                                  'Đăng ký',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.orange)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text(
                                "Trở lại",
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void register() {
    String email = edtEmail.text;
    String password = edtPassword.text;
    String prePassword = edtPrePassword.text;
    String firstName = edtFirstName.text;
    String lastName = edtLastName.text;
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        prePassword.isNotEmpty &&
        firstName.isNotEmpty &&
        lastName.isNotEmpty) {
      if (email.contains("@")) {
        if (password == prePassword) {
          Common.showLoadingDialog(context, "Đang đăng ký tài khoản");
          Account account = Account(
              Avatar: "",
              DateOfBirth: "2022/1/1",
              Email: email,
              FirstName: firstName,
              LastName: lastName,
              PhoneNumber: "",
              Password: password);
          apiServices
              .register(account)
              .then((value) => {
                    Common.hideLoadingDialog(context),
                    Common.showAlertDialog(
                        context,
                        "Đăng ký tài khoản thành công",
                        "Hãy kiểm tra mail để kích hoạt tài khoản, nếu không thấy hãy kiểm tra thư mục SPAM nhé <3"),
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => InviterPage(title: ''),
                    ))
                  })
              .onError((error, stackTrace) => {
                    print('err'),
                    Common.hideLoadingDialog(context),
                    Common.showAlertDialog(
                        context,
                        "Đăng ký tài khoản không thành công",
                        "Kiểm tra lại thông tin, có thể email đã được sử dụng")
                  })
              .catchError((Object obj) {
            Common.hideLoadingDialog(context);
            Common.showAlertDialog(
                context,
                "Đăng ký tài khoản không thành công",
                "Kiểm tra kết nối mạng nhé");
          });
        } else {
          Common.showAlertDialog(
              context, "Thông báo", "Mật khẩu nhập lại không khớp");
        }
      } else {
        Common.showAlertDialog(context, "Thông báo", "Email không hợp lệ");
      }
    } else {
      Common.showAlertDialog(
          context, "Thông báo", "Các thông tin không được bỏ trống");
    }
  }
}
