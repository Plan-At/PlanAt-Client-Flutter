import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class MyLoadingPage extends StatefulWidget {
  const MyLoadingPage({Key? key}) : super(key: key);

  @override
  State<MyLoadingPage> createState() => _MyLoadingPageState();
}

class _MyLoadingPageState extends State<MyLoadingPage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: http.get(Uri.parse("https://api-0.752628.xyz/tool/delay?sleep_time=3")),
        builder: (context, snapshot) {
          String message = "Here should be the loading screen for about 3 seconds";
          if (snapshot.connectionState == ConnectionState.done) {
            message = "finished";
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Loading Page'),
            ),
            body: Center(
                child: Column(
                  children: <Widget>[
                    Text(message),
                  ],
                )
            ),
          );
    });
  }
}