// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'year.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class YearAdapter extends TypeAdapter<Year> {
  @override
  final int typeId = 0;

  @override
  Year read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Year(
      year: fields[0] as int,
      exams: (fields[1] as List?)?.cast<Exam>(),
    );
  }

  @override
  void write(BinaryWriter writer, Year obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.year)
      ..writeByte(1)
      ..write(obj.exams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is YearAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
