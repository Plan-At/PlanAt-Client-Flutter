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
    double calculatedHeight = (widget.d.duration / 86400) * 630;
    if (calculatedHeight < 100) {
      calculatedHeight = 100;
    }
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
                    Text("EventID: "+widget.d.event_id.toString()),
                    Text(widget.d.start_time.text+'~'+widget.d.end_time.text),
                    Text(widget.d.description),
                  ],
                ),
              );
            });
        },
        child: SizedBox(
          width: 300,
          height: calculatedHeight,
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
  int event_id;
  String display_name;
  String description;
  TimeObject start_time;
  TimeObject end_time;
  late int duration;

  CalendarEventData(this.event_id, this.display_name, this.description, this.start_time, this.end_time) {
    duration = end_time.timestamp - start_time.timestamp; /// this. keyword not necessary here
  }
}

class CalendarEventDataGenerator {
  static CalendarEventData placeholder() {
    return CalendarEventData(
      1234567890123456,
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

  /// using the curley bracket to activate named parameter
  static Future<CalendarEventData> singleEvent({required http.Client httpClient, String pa_token="aaaaaaaa", String event_id="1649358548151936"}) async {
    debugPrint("Fetching "+event_id);
    try {
      var response = await httpClient.get(
        /// Query parameter need be pass in separately, otherwise the question mark
        Uri.https(
          MyURL.mainAPIEndpoint, 
          'v1/universal/user/calendar/event',
          {"event_id": event_id},
        ),
        /// Without "Accept" and "Content-Type" will have CORS error on Chrome
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "pa-token": pa_token,
        },
      );
      if (response.statusCode != 200) {
        throw Exception("status code: " + response.statusCode.toString());
      }
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      debugPrint(utf8.decode(response.bodyBytes));
      /// WARNING: when did not actually get the event data from backend will error when getting value of these key
      return CalendarEventData(
        decodedResponse["event_id"],
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
      // httpClient.close();
    }
  }

  /// this still fetching all the data in synchronous order
  static Future<List<CalendarEventData>> multipleEvent({required http.Client httpClient, required List<String> event_id_list, String pa_token="aaaaaaaa"}) async {
    List<CalendarEventData> retList = [];
    for (String currentElement in event_id_list) {
      try {
        CalendarEventData currentRet = await singleEvent(httpClient: httpClient, event_id: currentElement);
        retList.add(currentRet);
      } catch (eee){
        debugPrint(eee.toString());
      }
    }
    return retList;
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
      // httpClient.close();
    }
  }
}
