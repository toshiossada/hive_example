import 'package:hive_discovery/app/commons/base_mapper.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/infra/repositories/models/register_model.dart';

class RegisterMapper implements BaseMapper<RegisterEntity, RegisterModel> {
  @override
  RegisterEntity toEntity(RegisterModel model) {
    return RegisterEntity(
      id: model.id,
      name: model.name,
    );
  }

  @override
  RegisterModel toModel(RegisterEntity entity) {
    return RegisterModel(
      id: entity.id,
      name: entity.name,
    );
  }
}
