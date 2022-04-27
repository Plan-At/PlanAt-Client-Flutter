import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import './MyConstant.dart';

class CalendarEventCard extends StatefulWidget {
  const CalendarEventCard({Key? key, required this.d}) : super(key: key);

  final CalendarEventData d;

  @override
  State<CalendarEventCard> createState() => _CalendarEventCardState();
}

class _CalendarEventCardState extends State<CalendarEventCard>{
  @override
  Widget build(BuildContext context) {
    int duration = widget.d.start_time.timestamp - widget.d.end_time.timestamp;


    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
          debugPrint(widget.d.display_name);
        },
        child: SizedBox(
          width: 300,
          height: (duration/86400)*630,
          child: Column(
            children: [
              Text(
                widget.d.display_name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.d.description),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarEventData {
  String display_name;
  String description;
  TimeObject start_time;
  TimeObject end_time;

  CalendarEventData(this.display_name, this.description, this.start_time, this.end_time);
}

class CalendarEventDataGenerator {
  static Future<CalendarEventData> singleEvent() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(MyURL.mainAPIEndpoint, 'v1/universal/user/calendar/event?event_id=1651091827454060'),
        headers: {"person_id": "123456890", "token": "aaaaaaaa"},
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      return CalendarEventData(
        decodedResponse["display_name"],
        decodedResponse["description"],
        TimeObject(
          decodedResponse["start_time"]["text"],
          decodedResponse["start_time"]["timestamp"],
          decodedResponse["start_time"]["timezone_name"],
          decodedResponse["start_time"]["timezone_difference"],
        ),
        TimeObject(
          decodedResponse["end_time"]["text"],
          decodedResponse["end_time"]["timestamp"],
          decodedResponse["end_time"]["timezone_name"],
          decodedResponse["end_time"]["timezone_difference"],
        ),
      );
    } finally {
      client.close();
    }
  }
}

class TimeObject {
  String text;
  int timestamp;
  String timezone_name;
  int timezone_difference;

  TimeObject(this.text, this.timestamp, this.timezone_name, this.timezone_difference);
}

class TagObject {
  String tag_id;
  String name;

  TagObject(this.tag_id, this.name);
}

class TypeObject {
  String type_id;
  String name;

  TypeObject(this.type_id, this.name);
}