import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/modules/home/presentation/pages/list/list_page.dart';

import '../../commons/base_mapper.dart';
import 'domain/entities/register_entity.dart';
import 'domain/repositories/local_register_repository.dart';
import 'domain/repositories/register_repository_interface.dart';
import 'domain/usecases/get_register.dart';
import 'domain/usecases/register_local_database_usecase.dart';
import 'domain/usecases/search_local_database.dart';
import 'infra/datasources/external/register_datasource.dart';
import 'infra/datasources/internal/register_local_database.dart';
import 'infra/mappers/register_mapper.dart';
import 'infra/repositories/datasources/register_datasource_interface.dart';
import 'infra/repositories/datasources/register_local_database_interface.dart';
import 'infra/repositories/local_register_repository.dart';
import 'infra/repositories/models/register_model.dart';
import 'infra/repositories/register_repository.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/list/list_controller.dart';

class HomeModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.factory((i) => ListController(
              searchLocalDatabase: i(),
            )),
        Bind.factory((i) => HomeController(
              getRegister: i(),
              registerLocalDatabaseUsecase: i(),
            )),
        Bind.factory((i) => RegisterLocalDatabaseUsecase(
              localRepository: i(),
            )),
        Bind.factory((i) => SearchLocalDatabase(
              localRepository: i(),
            )),
        Bind.factory((i) => GetRegister(
              localRepository: i(),
              repository: i(),
            )),
        Bind.factory<ILocalRegisterRepository>((i) => LocalRegisterRepository(
              mapper: i(),
              registerLocalDatasource: i(),
            )),
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
        Bind.lazySingleton<IRegisterLocalDatasource>(
            (i) => RegisterLocalDatasource()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => HomePage(controller: Modular.get()),
        ),
        ChildRoute(
          '/list',
          child: (_, args) => ListPage(controller: Modular.get()),
        ),
      ];
}
