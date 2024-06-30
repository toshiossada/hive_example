import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'commons/adapters/custom_alerts/asuka/asuka_dialog.dart';
import 'commons/adapters/custom_alerts/dialog_adapter.dart';
import 'commons/adapters/http_client/dio/dio_adapter.dart';
import 'commons/adapters/http_client/http_client_adapter.dart';

class CoreModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.addInstance(Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000/')));
    i.addInstance<IHttpClientAdapter>(DioAdapter(dio: i(), interceptors: []));
    i.add<FShowDialog>((i) => (Widget child) async {
          return await Asuka.showDialog(builder: (context) => child);
        });
    i.add<FAlert>((i) => (String text) {
          AsukaSnackbar.alert("success").show();
        });
    i.add<IDialogAdapter>(AsukaDialog.new);
  }
}
