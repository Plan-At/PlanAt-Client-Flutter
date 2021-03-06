import 'package:flutter/material.dart';

import '../util/CalendarEvent.dart';
import '../util/MySharedVariable.dart';

class MySettingPage extends StatefulWidget {
  const MySettingPage({Key? key}) : super(key: key);
  @override
  State<MySettingPage> createState() => _MySettingPageState();
}

class _MySettingPageState extends State<MySettingPage> {
  final MySharedVariable globalVar = MySharedVariable();

  final myTextFieldController = TextEditingController();
  String inputtedText = "Placeholder";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: Column(
              children: <Widget>[
                ElevatedButton(
                  child: const Text("Fetch CalendarEventData"),
                  onPressed: () {
                    CalendarEventDataHelper.singleEvent(httpClient: globalVar.apiClient).then((ret) {
                      setState(() {
                        globalVar.exampleCED = ret;
                        debugPrint(globalVar.exampleCED.display_name);
                      });
                    });
                  },
                ),
                Text(globalVar.exampleCED.display_name),
                FloatingActionButton(
                  onPressed: () {setState(() {
                    globalVar.incrementMyVariable();
                  });},
                  tooltip: 'Increment',
                  child: const Icon(Icons.add),
                ),
                Text('Shared number: ${globalVar.myVariable}'),
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
                Text(inputtedText),
                const Text('1\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('2\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('3\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('4\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('5\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('6\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('7\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
                const Text('8\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n!\n'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
