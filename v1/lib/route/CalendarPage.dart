import 'package:flutter/material.dart';

import '../component/CalendarEventCard.dart';

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
                children: const [
                  Text("Day 1")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  Text("Day 2")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  Text("Day 3")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  Text("Day 4")
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: const [
                  Text("Day 5"),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 1,
          thickness: 1,
          indent: 0,
          endIndent: 0,
          color: Colors.black,
        ),
        SizedBox(
          height: 630,
          child: Row(
            children: [
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
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    CalendarEventCard(),
                    Spacer(flex: 1),
                    CalendarEventCard(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    CalendarEventCard(),
                    CalendarEventCard(),
                    Spacer(flex: 1),
                    CalendarEventCard(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    CalendarEventCard(),
                    SizedBox(height: 150),
                    CalendarEventCard(),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: const [
                    CalendarEventCard(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}