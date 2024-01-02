// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task2.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class Task2Adapter extends TypeAdapter<Task2> {
  @override
  final int typeId = 2;

  @override
  Task2 read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Task2(
      title: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Task2 obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task2Adapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
