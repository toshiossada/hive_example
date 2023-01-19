import 'package:flutter_modular/flutter_modular.dart';

import '../../commons/base_mapper.dart';
import 'domain/entities/register_entity.dart';
import 'domain/repositories/register_repository_interface.dart';
import 'domain/usecases/get_register.dart';
import 'infra/datasources/external/register_datasource.dart';
import 'infra/datasources/internal/register_local_database.dart';
import 'infra/mappers/register_mapper.dart';
import 'infra/repositories/datasources/register_datasource_interface.dart';
import 'infra/repositories/datasources/register_local_database_interface.dart';
import 'infra/repositories/models/register_model.dart';
import 'infra/repositories/register_repository.dart';
import 'presentation/pages/home_controller.dart';
import 'presentation/pages/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => HomeController(i())),
        Bind.factory((i) => GetRegister(i())),
        Bind.factory<IRegisterRepository>((i) => RegisterRepository(
              datasource: i(),
              mapper: i(),
              registerLocalDatasource: i(),
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

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => HomePage(controller: Modular.get()),
        ),
      ];
}
