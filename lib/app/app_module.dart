import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/modules/home/home_module.dart';

import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter.dart';
import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.factory<FShowDialog>((i) => (Widget child) async {
          return await Asuka.showDialog(builder: (context) => child);
        }),
    Bind.factory<FAlert>((i) => (String text) {
          AsukaSnackbar.alert("success").show();
        }),
    Bind.factory(
      (i) => Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/')),
      export: true,
    ),
    Bind.factory<IDialogAdapter>((i) => AsukaDialog(
          fShowDialog: i<FShowDialog>(),
          fAlert: i<FAlert>(),
        )),
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
