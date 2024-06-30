import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/commons/adapters/http_client/http_client_adapter.dart';
import 'package:hive_discovery/app/modules/home/infra/repositories/datasources/register_datasource_interface.dart';

import '../../core_module.dart';
import 'domain/repositories/register_repository_interface.dart';
import 'domain/usecases/get_register_per_page.dart';
import 'infra/datasources/external/register_datasource.dart';
import 'infra/repositories/mappers/register_mapper.dart';
import 'infra/repositories/register_repository.dart';

class RegisterIsolateModule extends Module {
  @override
  void binds(Injector i) {
    CoreModule().exportedBinds(i);

    i.addInstance<IRegisterDatasource>(RegisterDatasource(
      i.get<IHttpClientAdapter>(),
    ));
    i.addInstance<RegisterMapperType>(RegisterMapper());

    i.addInstance<IRegisterRepository>(
      RegisterRepository(
          datasource: i.get<IRegisterDatasource>(),
          mapper: i.get<RegisterMapperType>()),
    );
    i.add<GetRegisterPerPage>(GetRegisterPerPage.new);
  }
}
