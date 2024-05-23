import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import '../generated/common.dart';
import '../services/api_service.dart';

void main() {
  runApp(const MyEAPage());
}

class MyEAPage extends StatefulWidget {
  const MyEAPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyEAPageState();
  }
}

class MyEAPageState extends State<MyEAPage> {
  String html = '''
   <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
      </head>
     <body>
     TonDZ
     </body>
 </html>
  
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          color: Colors.white,
        ),
        title: Text(
          Common.sanGiaoDich.Titile,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<Widget>(
        future: showWeb(),
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
      ),
    );
  }

  ApiServices apiServices =
      ApiServices(Dio(BaseOptions(contentType: 'application/json')));

  Future<Widget> showWeb() async {
    String htmlText = '';
    WebViewController controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.enableZoom(true);
    controller.setBackgroundColor(Colors.black);
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    var res = apiServices.getSanById(Common.sanGiaoDich.Id);
    await res.then((value) {
      htmlText = html.replaceAll("TonDZ", value.Content);
      controller.loadHtmlString(htmlText);
    }).onError((error, stackTrace) {
      print(error);
    }).catchError((Object obj) {
      print(obj);
    });
    return WebViewWidget(
      controller: controller,
    );
  }
}
