import './CalendarEvent.dart';

class MySharedVariable {
  static final MySharedVariable _instance = MySharedVariable._internal();
  factory MySharedVariable() => _instance;

  MySharedVariable._internal() {
    myVariable = 0;
    exampleCED = CalendarEventDataGenerator.placeholder();
    calendarEventIndex = [0];
  }

  late int myVariable;
  late CalendarEventData exampleCED;
  late List<int> calendarEventIndex;

  void incrementMyVariable() {
    myVariable++;
  }
}