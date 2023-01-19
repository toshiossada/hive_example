import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/modules/home/home_module.dart';

import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory(
      (i) => Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/')),
      export: true,
    ),
    Bind.factory<IHttpClientAdapter>(
      (i) => DioAdapter(dio: i(), interceptors: []),
      export: true,
    ),
    Bind.factory(
      (i) => Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/')),
    ),
    Bind.factory<IHttpClientAdapter>(
      (i) => DioAdapter(dio: i(), interceptors: []),
    ),
  ];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
      ];
}
