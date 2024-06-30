import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../commons/adapters/http_client/dio/dio_adapter.dart';
import '../../commons/adapters/http_client/http_client_adapter.dart';
import '../../core_module.dart';
import 'domain/repositories/local_register_repository.dart';
import 'domain/repositories/register_repository_interface.dart';
import 'domain/usecases/clear_register.dart';
import 'domain/usecases/get_register.dart';
import 'domain/usecases/register_local_database_usecase.dart';
import 'domain/usecases/search_local_database.dart';
import 'infra/datasources/external/register_datasource.dart';
import 'infra/datasources/internal/register_local_database.dart';
import 'infra/repositories/datasources/register_datasource_interface.dart';
import 'infra/repositories/datasources/register_local_database_interface.dart';
import 'infra/repositories/local_register_repository.dart';
import 'infra/repositories/mappers/register_mapper.dart';
import 'infra/repositories/register_repository.dart';
import 'presentation/pages/animation/animation_page.dart';
import 'presentation/pages/home/home_controller.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/list/list_controller.dart';
import 'presentation/pages/list/list_page.dart';
import 'presentation/pages/list_infinity/list_infinity_controller.dart';
import 'presentation/pages/list_infinity/list_infinity_page.dart';

class HomeModule extends Module {
  @override
  List<Module> get imports => [CoreModule()];

  @override
  void binds(Injector i) {
    i.addInstance(Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/')));
    i.addInstance<IHttpClientAdapter>(DioAdapter(dio: i(), interceptors: []));
    i.add(ListControllerInfinityScroll.new);
    i.add(ListController.new);
    i.add(HomeController.new);
    i.add(RegisterLocalDatabaseUsecase.new);
    i.add(SearchLocalDatabase.new);
    i.add(GetRegister.new);
    i.add(ClearRegisters.new);
    i.addInstance<IRegisterDatasource>(RegisterDatasource(
      i.get<IHttpClientAdapter>(),
    ));
    i.addInstance<RegisterMapperType>(RegisterMapper());
    i.addLazySingleton<IRegisterLocalDatasource>(RegisterLocalDatasource.new);
    i.addInstance<ILocalRegisterRepository>(LocalRegisterRepository(
      mapper: i.get<RegisterMapperType>(),
      registerLocalDatasource: i.get<IRegisterLocalDatasource>(),
    ));
    i.addInstance<IRegisterRepository>(
      RegisterRepository(
          datasource: i.get<IRegisterDatasource>(),
          mapper: i.get<RegisterMapperType>()),
    );
  }

  @override
  void routes(RouteManager r) {
    r.child(
      '/',
      child: (_) => HomePage(controller: Modular.get()),
    );
    ChildRoute(
      '/animation',
      child: (_) => const AnimationPage(),
    );
    ChildRoute(
      '/list',
      child: (_) => ListPage(controller: Modular.get()),
    );
    ChildRoute(
      '/listInfinity',
      child: (_) => ListPageInfinityScroll(controller: Modular.get()),
    );
  }
}
