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
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          debugPrint('Card tapped.');
          debugPrint(widget.d.display_name);
        },
        child: SizedBox(
          width: 300,
          height: 100,
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

  CalendarEventData(this.display_name, this.description);
}

class CalendarEventDataGenerator {
  static Future<CalendarEventData> singleEvent() async {
    var client = http.Client();
    try {
      var response = await client.get(
        Uri.https(MyURL.mainAPIEndpoint, 'v1/universal/user/calendar/event?event_id='),
        headers: {"person_id": "123456890", "token": "aaaaaaaa"},
      );
      var decodedResponse = jsonDecode(utf8.decode(response.bodyBytes)) as Map;
      var uri = Uri.parse(decodedResponse['uri'] as String);
      print(await client.get(uri));
    } finally {
    client.close();
    }

    return CalendarEventData("", "");
  }
}