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

class _CalendarEventCardState extends State<CalendarEventCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped');
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: const Text("Event Detail"),
                  content: Column(
                    children: [
                      Text(
                        widget.d.display_name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(widget.d.start_time.text +
                          '~' +
                          widget.d.end_time.text),
                      Text(widget.d.description),
                    ],
                  ),
                );
              });
        },
        child: SizedBox(
          width: 300,
          height: (widget.d.duration / 86400) * 630,
          child: Column(
            children: [
              Text(
                widget.d.display_name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.d.start_time.text + '~' + widget.d.end_time.text),
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
  late int duration;

  CalendarEventData(
      this.display_name, this.description, this.start_time, this.end_time) {
    duration = end_time.timestamp - start_time.timestamp;
  }
}

class CalendarEventDataGenerator {
  static CalendarEventData placeholder() {
    return CalendarEventData(
      "placeholder event",
      "describe the event here",
      TimeObject(
        "start",
        0,
        "",
        0,
      ),
      TimeObject(
        "end",
        7200,
        "",
        0,
      ),
    );
  }

  static Future<CalendarEventData> singleEvent() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(
          MyURL.mainAPIEndpoint, 
          'v1/universal/user/calendar/event',
          {"event_id": "1649358548151936"},
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "pa-token": "aaaaaaaa",
        },
      );
      if (response.statusCode != 200) {
        debugPrint("status code: " + response.statusCode.toString());
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      debugPrint(utf8.decode(response.bodyBytes));
      return CalendarEventData(
        decodedResponse["display_name"],
        decodedResponse["description"],
        TimeObject(
          decodedResponse["start_time"]["text"],
          decodedResponse["start_time"]["timestamp_int"],
          decodedResponse["start_time"]["timezone_name"],
          decodedResponse["start_time"]["timezone_offset"],
        ),
        TimeObject(
          decodedResponse["end_time"]["text"],
          decodedResponse["end_time"]["timestamp_int"],
          decodedResponse["end_time"]["timezone_name"],
          decodedResponse["end_time"]["timezone_offset"],
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

  TimeObject(
      this.text, this.timestamp, this.timezone_name, this.timezone_difference);
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

class CalendarEventList {
  static Future<List<int>> privateIndex() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(
          MyURL.mainAPIEndpoint, 
          'v1/private/user/calendar/event/index',
          {"person_id": "1234567890"},
        ),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "pa-token": "aaaaaaaa",
        },
      );
      if (response.statusCode != 200) {
        debugPrint("status code: " + response.statusCode.toString());
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      debugPrint(utf8.decode(response.bodyBytes));
      return List<int>.from(decodedResponse["event_id_list"]);
    } finally {
      client.close();
    }
  }
}
