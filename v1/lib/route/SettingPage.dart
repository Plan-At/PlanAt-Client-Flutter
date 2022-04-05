import 'package:flutter/material.dart';

import '../util/MySharedVariable.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({Key? key}) : super(key: key);
  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  final MySharedVariable _MyVar = MySharedVariable();

  final myTextFieldController = TextEditingController();
  String inputtedText = "Placeholder";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting Page'),
      ),
      body: Center(
          child: Column(
            children: <Widget>[
              const Text(
                  "Here should be the setting page"
              ),
              FloatingActionButton(
                onPressed: () {setState(() {
                  _MyVar.incrementMyVariable();
                });},
                tooltip: 'Increment',
                child: const Icon(Icons.add),
              ),
              Text(
                  'Shared number: ${_MyVar.myVariable}'
              ),
              TextField(
                controller: myTextFieldController,
              ),
              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  setState(() {
                    inputtedText = myTextFieldController.text;
                  });
                },
              ),
              Text(inputtedText)
            ],
          )
      ),
    );
  }
}
