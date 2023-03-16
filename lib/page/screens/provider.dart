import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasbix/generated/generate_class.dart';

class IntProvider extends ChangeNotifier {
  int counter = 0;
  List<Dhikr> listDhikr = [];
  final player = AudioPlayer();

  bool switcher = true;

  late Box<Dhikr> box;

  IntProvider() {
    getCounterFromPrefs();
  }

  void deleteDhikr(int index) {
    box.deleteAt(index);
    getObjectFromHive();
    notifyListeners();
  }

  Future<void> getCounterFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    box = await Hive.openBox('myBox');
    listDhikr = box.values.toList();
    prefs.containsKey('counter') ? counter = prefs.getInt('counter')! : null;

    notifyListeners();
  }

  void addDhikrInHive(String title) {
    var box = Hive.box<Dhikr>('myBox');
    var id = DateTime.now().millisecondsSinceEpoch;

    getCounterFromPrefs();
    box.put(id.toString(),
        Dhikr(title: title, counter: counter, dateTime: DateTime.now()));
    notifyListeners();
  }

  Future<List<Dhikr>> getObjectFromHive() async {
    listDhikr = box.values.toList();
    notifyListeners();
    return listDhikr;
  }

  Future<void> saveCounter() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('counter', counter);
    notifyListeners();
  }

  void increment() {
    counter++;
    saveCounter();
    notifyListeners();
  }

  void decrement() {
    if (counter > 0) {
      counter--;
    }
    saveCounter();
    notifyListeners();
  }

  void reset() {
    counter = 0;
    saveCounter();
    notifyListeners();
  }

  void toSwitch() {
    switcher = !switcher;
    notifyListeners();
  }
}
