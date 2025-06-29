import 'package:flutter/foundation.dart';
import 'package:tuple/tuple.dart';

class Counter with ChangeNotifier {
  int counter = 0;
  int selectorCounter = 0;
  Tuple2<int, int> tuple2 = const Tuple2(1, 2);

  void increment() {
    counter++;
    notifyListeners();
  }

  void incSelectorCounter() {
    selectorCounter++;
    notifyListeners();
  }

  // Create one function to decrement counter value
  void decrementCounter() {
    counter--;
    notifyListeners();
  }
}
