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
                    SelectableText(
                      widget.d.display_name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SelectableText("EventID: "+widget.d.event_id.toString()),
                    SelectableText(widget.d.start_time.text+'~'+widget.d.end_time.text),
                    SelectableText(widget.d.description),
                  ],
                ),
              );
            });
        },
      ),
    );
  }
}

class CalendarEventData {
  /// Although the variable name not met the dart naming convention,
  /// but just for match what's present in the REST API
  int structure_version;
  int event_id;
  String display_name;
  String description;
  TimeObject start_time;
  TimeObject end_time;
  late int duration;

  CalendarEventData(this.structure_version, this.event_id, this.display_name, this.description, this.start_time, this.end_time) {
    duration = end_time.timestamp - start_time.timestamp; /// this. keyword not necessary here
  }
}

class CalendarEventDataHelper {
  static CalendarEventData placeholder() {
    return CalendarEventData(
      4,
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
  static Future<CalendarEventData> singleEvent({required http.Client httpClient, String pa_token="aaaaaaaa", String event_id="1651367706238774"}) async {
    debugPrint("Fetching "+event_id);
    try {
      var response = await httpClient.get(
        /// Query parameter need be pass in separately, otherwise the question mark
        Uri.https(
          MyURL.mainAPIEndpoint, 
          'v2/calendar/event/get',
          {"event_id_list": event_id},
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
      /// Also should check the schema version
      if (decodedResponse["structure_version"] == 4){
        return CalendarEventData(
          decodedResponse["structure_version"],
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
      }
      else{
        throw Exception("");
      }
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

  static Future<List<CalendarEventData>> newMultipleEvent({required http.Client httpClient, String pa_token="aaaaaaaa", required List<String> event_id_list}) async {
    try {
      debugPrint("Fetching event(s) "+event_id_list.toString());
      var response = await httpClient.get(
        /// Query parameter need be pass in separately, otherwise the question mark
        Uri.https(
          MyURL.mainAPIEndpoint,
          'v2/calendar/event/get',
          {"event_id_list": event_id_list},
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
      // var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      // Iterable decodedResponse = json.decode(utf8.decode(response.bodyBytes));
      // debugPrint(decodedResponse.toString());
      debugPrint(utf8.decode(response.bodyBytes));
      /// WARNING: when did not actually get the event data from backend will error when getting value of these key
      /// Also should check the schema version
      // List<CalendarEventData> returnList = [];
      // for (var eachResponse in decodedResponse){
      //   if (eachResponse["structure_version"] == 4){
      //     returnList.add(CalendarEventData(
      //       eachResponse["structure_version"],
      //       eachResponse["event_id"],
      //       eachResponse["display_name"],
      //       eachResponse["description"],
      //       TimeObject(
      //         eachResponse["start_time"]["text"],
      //         eachResponse["start_time"]["timestamp_int"],
      //         eachResponse["start_time"]["timezone_name"],
      //         eachResponse["start_time"]["timezone_offset"],
      //       ),
      //       TimeObject(
      //         eachResponse["end_time"]["text"],
      //         eachResponse["end_time"]["timestamp_int"],
      //         eachResponse["end_time"]["timezone_name"],
      //         eachResponse["end_time"]["timezone_offset"],
      //       ),
      //     ));
      //   }
      //   else{
      //     throw Exception("");
      //   }
      // }
      Iterable<CalendarEventData> returnList = (json.decode(response.body) as List).map((eachResponse) {
        if (eachResponse["structure_version"] == 4) {
          return CalendarEventData(
            eachResponse["structure_version"],
            eachResponse["event_id"],
            eachResponse["display_name"],
            eachResponse["description"],
            TimeObject(
              eachResponse["start_time"]["text"],
              eachResponse["start_time"]["timestamp_int"],
              eachResponse["start_time"]["timezone_name"],
              eachResponse["start_time"]["timezone_offset"],
            ),
            TimeObject(
              eachResponse["end_time"]["text"],
              eachResponse["end_time"]["timestamp_int"],
              eachResponse["end_time"]["timezone_name"],
              eachResponse["end_time"]["timezone_offset"],
            ),
          );
        }
        else{
          throw Exception("");
        }
      });
      return List.from(returnList);
    } finally {}
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
          'v2/calendar/event/index',
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
