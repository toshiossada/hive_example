// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_model_database.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RegisterModelDatabaseAdapter extends TypeAdapter<RegisterModelDatabase> {
  @override
  final int typeId = 1;

  @override
  RegisterModelDatabase read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RegisterModelDatabase(
      id: fields[0] == null ? 0 : fields[0] as int,
      name: fields[1] == null ? '' : fields[1] as String,
      field:
          fields[2] == null ? {} : (fields[2] as Map).cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegisterModelDatabase obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.field);
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
