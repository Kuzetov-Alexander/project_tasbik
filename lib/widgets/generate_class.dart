import 'package:hive/hive.dart';

part 'generate_class.g.dart';

@HiveType(typeId: 50)
class Dhikr {
  Dhikr({required this.title, required this.counter, required this.dateTime});

  @HiveField(0)
  String title;

  @HiveField(1)
  int counter;

  @HiveField(2)
  DateTime dateTime;

  void updateDataDhikr() {}

  void removeDhikr() {}
}
