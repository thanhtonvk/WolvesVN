import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../generated/common.dart';
import '../services/api_service.dart';

class TinTucWolvesPage extends StatefulWidget {
  const TinTucWolvesPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return TinTucWolvesPageState();
  }
}

class TinTucWolvesPageState extends State<TinTucWolvesPage> {
  ApiServices apiServices =
  ApiServices(Dio(BaseOptions(contentType: 'application/json')));
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
          Common.wolvesNews.Titile,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          FutureBuilder<Widget>(
            future: showWeb(),
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
          ),
        ],
      ),
    );
  }

  Future<Widget> showWeb() async {
    var res = apiServices.getNewsById(Common.wolvesNews.Id);
    await res.then(
          (value) {
        Common.wolvesNews.Content = value.Content;
      },
    ).onError(
          (error, stackTrace) {
        print(error);
      },
    ).catchError((Object obj) {
      print('err');
    });
    String htmlText = html.replaceAll("TonDZ", Common.wolvesNews.Content);
    WebViewController controller = WebViewController();
    controller.setBackgroundColor(Colors.black12);
    controller.loadHtmlString(htmlText);
    controller.enableZoom(false);
    return Expanded(
        child: WebViewWidget(
          controller: controller,
        ));
  }
}
