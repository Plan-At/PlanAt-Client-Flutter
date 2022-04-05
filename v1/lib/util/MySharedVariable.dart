class MySharedVariable {
  static final MySharedVariable _instance = MySharedVariable._internal();
  factory MySharedVariable() => _instance;

  MySharedVariable._internal() {
    myVariable = 0;
  }

  int myVariable = 0;

  void incrementMyVariable() {
    myVariable++;
  }
}