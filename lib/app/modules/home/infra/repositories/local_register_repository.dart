import 'package:hive_discovery/app/commons/base_mapper.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';

import '../../domain/repositories/local_register_repository.dart';
import 'datasources/register_local_database_interface.dart';
import '../models/register_model.dart';

class LocalRegisterRepository implements ILocalRegisterRepository {
  final IRegisterLocalDatasource registerLocalDatasource;
  final BaseMapper<RegisterEntity, RegisterModel> mapper;

  LocalRegisterRepository({
    required this.mapper,
    required this.registerLocalDatasource,
  });

  @override
  Future registerLocal(List<RegisterEntity> registers) async {
    final result = registers.map((e) => mapper.toModel(e)).toList();
    await registerLocalDatasource.add(result);
  }

  @override
  Future<List<RegisterEntity>> get() async {
    final registers = await registerLocalDatasource.get();
    return registers.map((e) => mapper.toEntity(e)).toList();
  }
}
