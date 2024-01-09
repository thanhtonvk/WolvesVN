import 'package:flutter/material.dart';
import 'package:wolvesvn/models/account.dart';
import 'package:wolvesvn/models/sangiaodich.dart';
import 'package:wolvesvn/models/wolves_news.dart';

import '../models/gold.dart';
import '../models/san.dart';
import '../models/video.dart';

class Common {
  Common._();

  static late Gold gold;
  static late Video video;
  static late WolvesNews wolvesNews;
  static late SanGiaoDich sanGiaoDich;
  static bool isVip = false;

  static Color backgroundColor = Colors.black87;
  static late Account ACCOUNT;

  static String pip = '';
  static String trades = '';
  static String winRate = '';
  static String money = '';
  static late San san;
  static void showLoadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent user from dismissing the dialog
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(
                  color: Colors.orange,
                ),
                // Display a circular progress indicator
                const SizedBox(width: 16.0),
                Text(text),
                // Display a text message
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoadingDialog(BuildContext context) {
    Navigator.of(context).pop(); // Close the dialog
  }

  static void showAlertDialog(
      BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}
