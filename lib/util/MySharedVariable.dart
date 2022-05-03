import 'package:flutter/material.dart';

import './CalendarEvent.dart';

import 'package:http/http.dart' as http;

class MySharedVariable {
  static final MySharedVariable _instance = MySharedVariable._internal();
  factory MySharedVariable() => _instance;

  /// All variables need have some placeholder content
  MySharedVariable._internal() {
    myVariable = 0;
    exampleCED = CalendarEventDataHelper.placeholder();
    calendarEventIndex = [];
    apiClient = http.Client();
    someCalendarEventCard = [];
    someCalendarEventData = [];
    inputedStartTime = TimeOfDay.now();
  }

  late int myVariable;
  late CalendarEventData exampleCED;
  late List<int> calendarEventIndex;
  late http.Client apiClient;
  late List<CalendarEventCard> someCalendarEventCard;
  late List<CalendarEventData> someCalendarEventData;
  late TimeOfDay inputedStartTime;

  void incrementMyVariable() {
    myVariable++;
  }
}