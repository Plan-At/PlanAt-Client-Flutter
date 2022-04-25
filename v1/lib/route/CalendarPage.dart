import 'package:flutter/material.dart';

import '../util/MyWidget.dart';
import '../component/CalendarEventCard.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key, this.daysToShow=5}) : super(key: key);

  final int daysToShow;

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> dayNameList = [];
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
    }

    List<Widget> dayContentList = [];
    for (var currentDay = 1; currentDay <= widget.daysToShow; currentDay++) {
      dayContentList.add(
        Expanded(
          flex: 1,
          child: Column(
            children: const [
              CalendarEventCard(
                title: "a",
              ),
              CalendarEventCard(),
              CalendarEventCard(),
              CalendarEventCard(),
            ],
          ),
        )
      );
    }

    return Column(
      children: [
        Row(
          children: [
            const Text("Weekly View"),
            const Spacer(
              flex: 49,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_before_rounded),
              onPressed: () {
                print("preesed to previous week");
              },
            ),
            const Spacer(
              flex: 1,
            ),
            IconButton(
              icon: const Icon(Icons.navigate_next_rounded),
              onPressed: () {
                print("preesed to next week");
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
            children: dayContentList,
          ),
        ),
      ],
    );
  }
}