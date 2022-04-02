import 'package:hive_flutter/hive_flutter.dart';

class MyDB {
  static final MyDB _instance = MyDB._internal();
  factory MyDB() => _instance;

  late final Box testBox;

  void init() async {
    testBox = await Hive.openBox('testBox');
  }

  MyDB._internal() {
    init();
    myVariable = 0;
  }

  int myVariable = 0;

  void incrementMyVariable() {
    myVariable++;
  }
}