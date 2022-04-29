import 'package:flutter/material.dart';

class MySubAppPage extends StatefulWidget {
  const MySubAppPage({Key? key}) : super(key: key);

  @override
  State<MySubAppPage> createState() => _MySubAppPageState();
}

class _MySubAppPageState extends State<MySubAppPage> {
  @override
  Widget build(BuildContext context) {
    return const Text("here should be the sub-app page");
  }
}