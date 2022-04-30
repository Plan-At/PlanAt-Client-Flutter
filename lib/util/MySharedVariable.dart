import './CalendarEvent.dart';

import 'package:http/http.dart' as http;

class MySharedVariable {
  static final MySharedVariable _instance = MySharedVariable._internal();
  factory MySharedVariable() => _instance;

  /// All variables need have some placeholder content
  MySharedVariable._internal() {
    myVariable = 0;
    exampleCED = CalendarEventDataGenerator.placeholder();
    calendarEventIndex = [0];
    apiClient = http.Client();
  }

  late int myVariable;
  late CalendarEventData exampleCED;
  late List<int> calendarEventIndex;
  late http.Client apiClient;

  void incrementMyVariable() {
    myVariable++;
  }
}