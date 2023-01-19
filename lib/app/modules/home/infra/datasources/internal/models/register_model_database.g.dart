// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterModelDatabaseAdapter extends TypeAdapter<RegisterModelDatabase> {
  @override
  final int typeId = 0;

  @override
  RegisterModelDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterModelDatabase();
  }

  @override
  void write(BinaryWriter writer, RegisterModelDatabase obj) {
    writer.writeByte(0);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RegisterModelDatabaseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
