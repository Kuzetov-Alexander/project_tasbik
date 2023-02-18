// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'generate_class.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DhikrAdapter extends TypeAdapter<Dhikr> {
  @override
  final int typeId = 0;

  @override
  Dhikr read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Dhikr(
      title: fields[0] as String,
      counter: fields[1] as int,
      dateTime: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Dhikr obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.counter)
      ..writeByte(2)
      ..write(obj.dateTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DhikrAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
