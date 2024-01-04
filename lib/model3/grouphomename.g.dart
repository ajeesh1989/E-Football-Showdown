// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'grouphomename.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GrouphomenameAdapter extends TypeAdapter<Grouphomename> {
  @override
  final int typeId = 3;

  @override
  Grouphomename read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Grouphomename(
      playernamegroup: fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Grouphomename obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.playernamegroup);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrouphomenameAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
