import 'package:hive/hive.dart';
import 'package:hive_discovery/app/modules/home/infra/models/register_model.dart';

part 'register_model_database.g.dart';

@HiveType(typeId: 1)
class RegisterModelDatabase extends HiveObject {
  @HiveField(0, defaultValue: 0)
  final int id;
  @HiveField(1, defaultValue: '')
  final String name;
  @HiveField(2, defaultValue: {})
  final Map<String, dynamic> fields;

  RegisterModelDatabase({
    required this.id,
    required this.name,
    required this.fields,
  });

  factory RegisterModelDatabase.fromModel(RegisterModel model) {
    return RegisterModelDatabase(
      id: model.id,
      name: model.name,
      fields: model.fields,
    );
  }
  RegisterModel toModel() {
    return RegisterModel(
      id: id,
      name: name,
      fields: fields,
    );
  }
}
