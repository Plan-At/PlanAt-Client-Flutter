import 'package:hive_flutter/hive_flutter.dart';

class MyDB {
  static final MyDB _instance = MyDB._internal();
  factory MyDB() => _instance;

  MyDB._internal() {
    _myVariable = 0;
  }

  int _myVariable = 0;
  //short getter for my variable
  int get myVariable => _myVariable;
  //short setter for my variable
  set myVariable(int value) => _myVariable = value;

  void incrementMyVariable() {
    print(_myVariable);
    _myVariable++;
    print('incremented');
  }
}