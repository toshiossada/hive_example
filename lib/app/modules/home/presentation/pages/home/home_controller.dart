import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../domain/entities/register_entity.dart';
import '../../../domain/usecases/get_register.dart';
import '../../../domain/usecases/get_register_per_page.dart';
import '../../../domain/usecases/register_local_database_usecase.dart';
import '../../../register_isolate_module.dart';

class HomeController {
  final GetRegister getRegister;
  final RegisterLocalDatabaseUsecase registerLocalDatabaseUsecase;
  ValueNotifier<bool> loading = ValueNotifier(false);

  HomeController({
    required this.getRegister,
    required this.registerLocalDatabaseUsecase,
  });

  Future get() async {
    loading.value = true;
    await getRegister();
    loading.value = false;
  }

  Future getRegisterPerPage() async {
    loading.value = true;
    ReceivePort port = ReceivePort();

    final isolate = await Isolate.spawn<List<dynamic>>(
      execIsolate,
      [port.sendPort],
    );

    port.listen((message) {
      print('$message%');
      if (message is List<RegisterEntity>) {
        isolate.kill(priority: Isolate.immediate);
        loading.value = false;
        registerLocalDatabaseUsecase(message);
      }
    });
  }

  static execIsolate(List values) async {
    Modular.init(RegisterIsolateModule());
    SendPort sendPort = values[0];
    final getRegisterPerPage = Modular.get<GetRegisterPerPage>();
    final registers = <RegisterEntity>[];
    for (var i = 0; i < 5; i++) {
      final result = await getRegisterPerPage(i);
      registers.addAll(result);
      sendPort.send(i + 1);
    }

    sendPort.send(registers);
  }
}


//GetRegisterPerPage