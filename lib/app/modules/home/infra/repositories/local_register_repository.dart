import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';

import '../../domain/repositories/local_register_repository.dart';
import 'datasources/register_local_database_interface.dart';
import 'register_repository.dart';

class LocalRegisterRepository implements ILocalRegisterRepository {
  final IRegisterLocalDatasource registerLocalDatasource;
  final RegisterMapperType mapper;

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
  Future<List<RegisterEntity>> get({
    int pageSize = 0,
    int currentPage = 1,
    Map<String, dynamic>? filter,
  }) async {
    final registers = await registerLocalDatasource.getWhere(
      pageSize: pageSize,
      currentPage: currentPage,
      filter: filter,
    );
    return registers.map((e) => mapper.toEntity(e)).toList();
  }

  @override
  Future clear() async {
    await registerLocalDatasource.clear();
  }
}
