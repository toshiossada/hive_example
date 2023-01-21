import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/app_module.dart';
import 'package:hive_discovery/app/modules/home/infra/repositories/datasources/register_datasource_interface.dart';

import '../../commons/base_mapper.dart';
import 'domain/entities/register_entity.dart';
import 'domain/repositories/register_repository_interface.dart';
import 'domain/usecases/get_register_per_page.dart';
import 'infra/datasources/external/register_datasource.dart';
import 'infra/datasources/internal/register_local_database.dart';
import 'infra/repositories/mappers/register_mapper.dart';
import 'infra/repositories/datasources/register_local_database_interface.dart';
import 'infra/models/register_model.dart';
import 'infra/repositories/register_repository.dart';

class RegisterIsolateModule extends Module {
  @override
  List<Module> get imports => [AppModule()];

  @override
  List<Bind> get binds => [
        Bind.factory((i) => GetRegisterPerPage(i())),
        Bind.factory<IRegisterRepository>((i) => RegisterRepository(
              datasource: i(),
              mapper: i(),
            )),
        Bind.factory<IRegisterDatasource>(
          (i) => RegisterDatasource(i()),
          export: true,
        ),
        Bind.factory<IRegisterDatasource>(
          (i) => RegisterDatasource(i()),
        ),
        Bind.factory<BaseMapper<RegisterEntity, RegisterModel>>(
            (i) => RegisterMapper()),
        Bind.factory<IRegisterLocalDatasource>(
            (i) => RegisterLocalDatasource()),
      ];
}
