import 'package:flutter/material.dart';

import '../util/MyDB.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);
  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final MyDB _MyDB = MyDB();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Page'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              const Text(
                  "Here should be the profile page"
              ),
              Text(
                  '${_MyDB.myVariable}'
              ),
              FloatingActionButton(
                onPressed: () => setState(() {
                  _MyDB.incrementMyVariable();
                }),
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
            ],
          )
      ),
    );
  }
}