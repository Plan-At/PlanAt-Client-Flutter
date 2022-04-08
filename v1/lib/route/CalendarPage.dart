import 'dart:html';

import 'package:flutter/material.dart';

class MyCalendarPage extends StatefulWidget {
  const MyCalendarPage({Key? key}) : super(key: key);

  @override
  State<MyCalendarPage> createState() => _MyCalendarPageState();
}

class _MyCalendarPageState extends State<MyCalendarPage> {
  static Card example_card = Card(
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
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Text("Weekly"),
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
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  example_card,
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  example_card,
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  example_card,
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  example_card,
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  example_card,
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}