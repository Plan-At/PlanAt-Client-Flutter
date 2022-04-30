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
              /// The AlertDialog is something but occupying entire screen
              /// but if click or touch on anywhere will dismiss it
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
                    Text(widget.d.start_time.text+'~'+widget.d.end_time.text),
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
              Text(widget.d.start_time.text+'~'+widget.d.end_time.text),
              Text(widget.d.description),
            ],
          ),
        ),
      ),
    );
  }
}

class CalendarEventData {
  /// Although the variable name not met the dart naming convention,
  /// but just for match what's present in the REST API
  String display_name;
  String description;
  TimeObject start_time;
  TimeObject end_time;
  late int duration;

  CalendarEventData(this.display_name, this.description, this.start_time, this.end_time) {
    duration = end_time.timestamp - start_time.timestamp; /// this. keyword not necessary here
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

  static Future<CalendarEventData> singleEvent(http.Client httpClient) async {
    try {
      var response = await httpClient.get(
        /// Query parameter need be pass in separately, otherwise the question mark
        Uri.https(
          MyURL.mainAPIEndpoint, 
          'v1/universal/user/calendar/event',
          {"event_id": "1649358548151936"},
        ),
        /// Without "Accept" and "Content-Type" will have CORS error on Chrome
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
      httpClient.close();
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
  static Future<List<int>> privateIndex(http.Client httpClient) async {
    try {
      var response = await httpClient.get(
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
        debugPrint("status code: "+response.statusCode.toString());
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      debugPrint(utf8.decode(response.bodyBytes));
      /// If not specify type using .from() will always be List<dynamic>
      return List<int>.from(decodedResponse["event_id_list"]);
    } finally {
      httpClient.close();
    }
  }
}
