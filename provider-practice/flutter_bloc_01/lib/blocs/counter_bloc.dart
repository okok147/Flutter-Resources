import 'package:flutter/material.dart';

class CounterBloc extends ChangeNotifier {
  int _counter = 10;
  int get counter => _counter;

  set counter(int val) {
    _counter = val;
    notifyListeners();
  }

  increment() {
    _counter ++;
    notifyListeners();
  }

  decrement() {
    _counter --;
    notifyListeners();
  }
}
