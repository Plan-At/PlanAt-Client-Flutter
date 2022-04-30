import 'package:flutter/material.dart';

import '../util/MySharedVariable.dart';
import '../util/MyWidget.dart';
import '../util/CalendarEvent.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key, this.daysToShow=5}) : super(key: key);

  final int daysToShow;

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  final MySharedVariable globalVar = MySharedVariable();

  @override
  Widget build(BuildContext context) {
    List<Widget> dayNameList = [];

    List<Widget> dayMainList = [];

    List<Widget> dayContentList = [
      CalendarEventCard(
        d: globalVar.exampleCED,
      ),
    ];

    for (var currentDay = 1; currentDay <= widget.daysToShow; currentDay++) {
      dayNameList.add(
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Text("Day "+currentDay.toString()),
              ],
            ),
          )
      );
      dayMainList.add(
        Expanded(
          flex: 1,
          child: Column(
            children: dayContentList,
          ),
        )
      );
    }

    return Column(
      children: [
        Row(
          children: [
            const Text("Weekly View"),
            const Spacer(flex: 49,),
            IconButton(
              icon: const Icon(Icons.post_add_rounded),
              onPressed: () {setState(() {
                debugPrint("trying to add new event");
              });},
            ),
            const Spacer(flex: 1),
            IconButton(
              icon: const Icon(Icons.navigate_before_rounded),
              onPressed: () {
                debugPrint("pressed to previous week");
              },
            ),
            const Spacer(flex: 1),
            IconButton(
              icon: const Icon(Icons.navigate_next_rounded),
              onPressed: () {
                debugPrint("pressed to next week");
              },
            ),
          ],
        ),
        MyStyle.blackDivider,
        Row(
          children: dayNameList,
        ),
        MyStyle.blackDivider,
        SizedBox(
          height: 630,
          child: Row(
            children: dayMainList,
          ),
        ),
      ],
    );
  }
}