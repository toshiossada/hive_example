import 'dart:isolate';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:hive_discovery/app/modules/home/domain/usecases/clear_register.dart';

import '../../../domain/entities/register_entity.dart';
import '../../../domain/usecases/get_register.dart';
import '../../../domain/usecases/get_register_per_page.dart';
import '../../../domain/usecases/register_local_database_usecase.dart';
import '../../../register_isolate_module.dart';

class HomeController {
  final GetRegister getRegister;
  final RegisterLocalDatabaseUsecase registerLocalDatabaseUsecase;
  final ClearRegisters clearRegisters;
  ValueNotifier<bool> loading = ValueNotifier(false);
  ValueNotifier<double?> percent = ValueNotifier(null);

  HomeController({
    required this.getRegister,
    required this.registerLocalDatabaseUsecase,
    required this.clearRegisters,
  });

  Future clear() async {
    await clearRegisters();
  }

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
      if (message is List<RegisterEntity>) {
        debugPrint('DONE');
        isolate.kill(priority: Isolate.immediate);
        loading.value = false;
        percent.value = null;
        registerLocalDatabaseUsecase(message);
      } else {
        percent.value = (message * 100) / 500;
        debugPrint('${percent.value}%');
      }
    });
  }

  static execIsolate(List values) async {
    Modular.init(RegisterIsolateModule());
    SendPort sendPort = values[0];
    final getRegisterPerPage = Modular.get<GetRegisterPerPage>();
    final registers = <RegisterEntity>[];
    int i = 0;
    for (i = 0; i < 500; i++) {
      final result = await getRegisterPerPage(i);
      registers.addAll(result);
      sendPort.send(i + 1);
    }
    sendPort.send(registers);
  }
}
