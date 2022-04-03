import 'package:flutter/material.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Row(
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Column (
              children: <Widget>[
                const Text(
                    "Here should be the profile page"
                ),
              ],
            ),
          ),
          Expanded(
              flex: 3,
              child: Column(
                children: <Widget>[
                  const Text(
                      "Here should be the profile page"
                  ),
                ],
              ),
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: <Widget>[
                const Text(
                    "Here should be the profile page"
                ),
              ],
            ),
          )
        ],
      )
    );
  }
}