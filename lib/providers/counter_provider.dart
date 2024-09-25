import 'package:flutter/material.dart';

class CounterProvider extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  void increment() {
    _value++;
    notifyListeners();
  }

  void decrement() {
    if (_value > 0) {
      _value--;
    }
    notifyListeners();
  }
}
