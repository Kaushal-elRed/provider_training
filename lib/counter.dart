import 'package:flutter/foundation.dart';

class Counter with ChangeNotifier {
  int counter = 0;
  int selectorCounter = 0;

  void increment() {
    counter++;
    notifyListeners();
  }

  void incSelectorCounter() {
    selectorCounter++;
    notifyListeners();
  }
}
