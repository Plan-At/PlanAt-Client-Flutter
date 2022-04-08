import 'dart:html';

import 'package:flutter/material.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: const [
            Text("Weekly"),
            Spacer(
              flex: 9,
            ),
            Text("Previous Week"),
            Spacer(
              flex: 1,
            ),
            Text("Next Week"),
          ],
        ),
        const Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.black,
        ),
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("here should be the calendar page")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("here should be the calendar page")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("here should be the calendar page")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("here should be the calendar page")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text("here should be the calendar page"),
                  Card(
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        debugPrint('Card tapped.');
                      },
                      child: const SizedBox(
                        // width: 300,
                        // height: 100,
                        child: Text('A card that can be tapped'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}