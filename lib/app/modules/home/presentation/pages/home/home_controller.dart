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

  final maxPage = 1000;
  Future getRegisterPerPage() async {
    loading.value = true;
    ReceivePort port = ReceivePort();

    final isolate = await Isolate.spawn<Map<String, dynamic>>(
      execIsolate,
      {
        'sendPort': port.sendPort,
        'maxPages': maxPage,
      },
    );

    port.listen((message) {
      if (message is List<RegisterEntity>) {
        debugPrint('DONE');
        isolate.kill(priority: Isolate.immediate);
        loading.value = false;
        percent.value = null;
        registerLocalDatabaseUsecase(message);
      } else {
        percent.value = (message * 100) / maxPage;
        debugPrint('${percent.value}%');
      }
    });
  }

  static execIsolate(Map<String, dynamic> values) async {
    Modular.init(RegisterIsolateModule());
    SendPort sendPort = values['sendPort'];
    int maxPages = values['maxPages'];
    final getRegisterPerPage = Modular.get<GetRegisterPerPage>();
    final registers = <RegisterEntity>[];

    for (int i = 0; i < maxPages; i++) {
      final result = await getRegisterPerPage(i);
      registers.addAll(result);
      sendPort.send(i + 1);
    }
    sendPort.send(registers);
  }
}
