import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wolvesvn/generated/common.dart';
import 'package:wolvesvn/services/api_service.dart';
import 'package:wolvesvn/ui/main_page.dart';
import 'package:wolvesvn/ui/register.dart';

import '../models/account.dart';
import '../models/vip.dart';

void main() {
  runApp(Login());
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginState();
  }
}

class LoginState extends State<Login> {
  TextEditingController edtEmail = TextEditingController();
  TextEditingController edtPassword = TextEditingController();
  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  void setEmailPassword(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("email", email);
    prefs.setString("password", password);
  }

  void getEmailPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    edtEmail.text = prefs.getString("email")!;
    edtPassword.text = prefs.getString("password")!;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEmailPassword();
  }

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
                            "Đăng nhập",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white),
                          ),
                          const SizedBox(
                            height: 20,
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
                            height: 10,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 60,
                            child: ElevatedButton(
                                onPressed: () {
                                  login();
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.orange),
                                child: const Text(
                                  'Đăng nhập',
                                  style: TextStyle(
                                      fontSize: 25, color: Colors.white),
                                )),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  forgotPassword();
                                },
                                child: const Text(
                                  'Quên mật khẩu',
                                  style: TextStyle(
                                      fontSize: 15, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.orange)),
                              onPressed: () {
                                navToRegister();
                              },
                              child: const Text(
                                "Đăng ký tài khoản",
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

  void navToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const Register()),
    );
  }

  void forgotPassword() {
    String email = edtEmail.text;
    if (email.isNotEmpty) {
      Common.showLoadingDialog(context, "Vui lòng chờ...");
      Future future = apiServices.forgotAccount(email);
      future
          .then((value) => {
                Common.hideLoadingDialog(context),
                Common.showAlertDialog(context, "Thông báo",
                    "Chúng tôi đã gửi thông báo về Email của bạn, vui lòng kiểm tra để đổi mật khẩu")
              })
          .onError((error, stackTrace) => {
                print(error.toString()),
                Common.hideLoadingDialog(context),
                Common.showAlertDialog(context, "Thông báo",
                    "Có lỗi xảy ra, vui lòng kiểm tra lại")
              })
          .catchError((Object obj) {
        Common.hideLoadingDialog(context);
        Common.showAlertDialog(
            context, "Thông báo", "Có lỗi xảy ra, vui lòng kiểm tra lại");
      });
    }
  }

  bool isVip(List<String> expertDate, List<String> currentDate) {
    int expertYear = int.parse(expertDate[0]);
    int expertMonth = int.parse(expertDate[1]);
    int expertDay = int.parse(expertDate[2]);

    int currentYear = int.parse(currentDate[0]);
    int currentMonth = int.parse(currentDate[1]);
    int currentDay = int.parse(currentDate[2]);
    if (expertYear > currentYear) {
      return true;
    } else if (expertYear < currentYear) {
      return false;
    } else {
      if (expertMonth > currentMonth) {
        return true;
      } else if (expertMonth < currentMonth) {
        return false;
      } else {
        if (expertDay >= currentDay) {
          return true;
        } else {
          return false;
        }
      }
    }
  }

  void checkVip() async {
    var today = DateTime.now();
    var dateFormat = DateFormat('yyyy-M-d');
    String currentDate = dateFormat.format(today);
    List<String> current = currentDate.split('-');
    apiServices.getVip(Common.ACCOUNT.Id as int).then(
      (value) {
        for (Vip vip in value) {
          String stringDate = vip.End.split('T')[0];
          List<String> expert = stringDate.split('-');
          Common.isVip = isVip(expert, current);
        }
      },
    ).onError(
      (error, stackTrace) {
        Common.isVip = false;
      },
    ).catchError((Object obj) {
      Common.isVip = false;
    });
  }

  void login() {
    String email = edtEmail.text;
    String password = edtPassword.text;
    if (email.isNotEmpty && password.isNotEmpty) {
      Common.showLoadingDialog(context, "Đang đăng nhập");
      Future<List<Account>> future = apiServices.login(email, password);
      future
          .then((value) => {
                Common.ACCOUNT = value[0],
                Common.hideLoadingDialog(context),
                if (Common.ACCOUNT.IsActive == true)
                  {
                    checkVip(),
                    setEmailPassword(email, password),
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => MainPage(),
                    ))
                  }
                else
                  {
                    Common.showAlertDialog(context, "Thông báo",
                        "Tài khoản chưa được kích hoạt hoặc đã bị xoá")
                  },
              })
          .onError((error, stackTrace) => {
                Common.hideLoadingDialog(context),
                Common.showAlertDialog(context, "Thông báo", "Không thể đăng nhập, vui lòng kiểm tra lại")
              })
          .catchError((Object obj) {
        Common.hideLoadingDialog(context);
        Common.showAlertDialog(
            context, "Thông báo", "Tài khoản hoặc mật khẩu không chính xác");
      });
    }
  }
}
