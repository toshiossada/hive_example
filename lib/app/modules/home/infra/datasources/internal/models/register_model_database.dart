import 'package:hive/hive.dart';
import 'package:hive_discovery/app/modules/home/infra/models/register_model.dart';

part 'register_model_database.g.dart';

@HiveType(typeId: 0)
class RegisterModelDatabase extends HiveObject {
  final int id;
  final String name;

  RegisterModelDatabase({
    this.id = 0,
    this.name = '',
  });

  factory RegisterModelDatabase.fromModel(RegisterModel model) {
    return RegisterModelDatabase(
      id: model.id,
      name: model.name,
    );
  }
  RegisterModel toModel() {
    return RegisterModel(
      id: id,
      name: name,
    );
  }
}
