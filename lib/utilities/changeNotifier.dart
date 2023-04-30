import 'package:flutter/material.dart';

class MyGlobalValue extends ChangeNotifier {
  int _value = 0;

  int get value => _value;

  set value(int newValue) {
    _value = newValue;
    notifyListeners(); // Notifie les écouteurs que la valeur a changé
  }
}
