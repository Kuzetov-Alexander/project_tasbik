import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyFirstProvider extends ChangeNotifier {
  int counter = 0;
  MyFirstProvider() {
    getCounterFromPrefs();
  }
  Future<void> getCounterFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.containsKey('counter') ? counter = prefs.getInt('counter')! : null;
    notifyListeners();
  }

  Future<void> saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
  }

  void increment() {
    counter++;
    saveCounter();
    notifyListeners();
  }

  void decrement() {
    counter--;
    saveCounter();
    notifyListeners();
  }

  void reset() {
    counter = 0;
    saveCounter();
    notifyListeners();
  }
}
