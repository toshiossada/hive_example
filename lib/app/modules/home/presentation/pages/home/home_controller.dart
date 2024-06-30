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
    try {
      loading.value = true;
      await getRegister();
    } finally {
      loading.value = false;
    }
  }

  final maxPage = 22;
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
      onData(message, isolate);
    });
  }

  Future<void> onDone(List<RegisterEntity> data) async {
    await registerLocalDatabaseUsecase(data);
    loading.value = false;
    percent.value = null;
    debugPrint('DONE');
  }

  Future<void> onData(dynamic message, Isolate isolate) async {
    try {
      if (message is List<RegisterEntity>) {
        await onDone(message);
        isolate.kill(priority: Isolate.immediate);
      } else {
        percent.value = (message * 100) / maxPage;
        debugPrint('${percent.value}%');
      }
    } finally {
      loading.value = false;
    }
  }

  static execIsolate(Map<String, dynamic> values) async {
    Modular.init(RegisterIsolateModule());
    final getRegisterPerPage = Modular.get<GetRegisterPerPage>();

    SendPort sendPort = values['sendPort'];
    int maxPages = values['maxPages'];
    final registers = <RegisterEntity>[];

    for (int i = 0; i < maxPages; i++) {
      final result = await getRegisterPerPage(i);
      registers.addAll(result);
      sendPort.send(i + 1);
    }
    sendPort.send(registers);
  }
}
