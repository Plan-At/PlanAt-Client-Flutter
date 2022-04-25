import 'package:flutter/material.dart';

class CalendarEventCard extends StatefulWidget {
  const CalendarEventCard({Key? key}) : super(key: key);

  @override
  State<CalendarEventCard> createState() => _CalendarEventCardState();
}

class _CalendarEventCardState extends State<CalendarEventCard>{
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
        },
        child: const SizedBox(
          width: 300,
          height: 100,
          child: Text('A card that can be tapped'),
        ),
      ),
    );
  }

}