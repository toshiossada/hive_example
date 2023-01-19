import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/commons/base_mapper.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/domain/repositories/register_repository_interface.dart';
import 'package:hive_discovery/app/modules/home/register_isolate_module.dart';

import 'datasources/register_datasource_interface.dart';
import 'datasources/register_local_database_interface.dart';
import 'models/register_model.dart';

class RegisterRepository implements IRegisterRepository {
  final IRegisterDatasource datasource;
  final IRegisterLocalDatasource registerLocalDatasource;
  final BaseMapper<RegisterEntity, RegisterModel> mapper;

  RegisterRepository({
    required this.datasource,
    required this.mapper,
    required this.registerLocalDatasource,
  });

  @override
  Future<List<RegisterEntity>> getRegisters() async {
//    final result = await datasource.getRegisters();
    final result = await compute(_searchRegisters, {});
    await registerLocalDatasource.add(result);

    return result.map((e) => mapper.toEntity(e)).toList();
  }

  static Future<List<RegisterModel>> _searchRegisters(_) async {
    Modular.init(RegisterIsolateModule());

    final datasource = Modular.get<IRegisterDatasource>();

    final data = <RegisterModel>[];
    for (var i = 0; i < 1000; i++) {
      final d = await datasource.getRegisters();
      data.addAll(d.map((e) => e.copyWith(id: i)));
    }

    return data;
  }
}
