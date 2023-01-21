import 'package:flutter/foundation.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/commons/base_mapper.dart';
import 'package:hive_discovery/app/modules/home/domain/entities/register_entity.dart';
import 'package:hive_discovery/app/modules/home/domain/repositories/register_repository_interface.dart';
import 'package:hive_discovery/app/modules/home/register_isolate_module.dart';

import 'datasources/register_datasource_interface.dart';
import '../models/register_model.dart';

class RegisterRepository implements IRegisterRepository {
  final IRegisterDatasource datasource;
  final BaseMapper<RegisterEntity, RegisterModel> mapper;

  RegisterRepository({
    required this.datasource,
    required this.mapper,
  });

  @override
  Future<List<RegisterEntity>> getRegistersPerPage(int page) async {
    final result = await datasource.getRegisters();

    return result.map((e) => mapper.toEntity(e)).toList();
  }

  @override
  Future<List<RegisterEntity>> getRegisters() async {
    final result = await compute(_searchRegisters, {});

    return result.map((e) => mapper.toEntity(e)).toList();
  }

  static Future<List<RegisterModel>> _searchRegisters(_) async {
    Modular.init(RegisterIsolateModule());

    final datasource = Modular.get<IRegisterDatasource>();

    final data = <RegisterModel>[];
    for (var i = 0; i < 1000; i++) {
      final d = await datasource.getRegisters();
      data.addAll(d.map((e) => e.copyWith(id: i)));
      print('$i - ${data.length}');
    }

    return data;
  }
}
