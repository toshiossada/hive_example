import 'dart:isolate';

import 'package:flutter/material.dart';

import '../../domain/usecases/get_register.dart';

class HomeController {
  final GetRegister getRegister;
  ValueNotifier<bool> loading = ValueNotifier(false);

  HomeController(this.getRegister);

  Future get() async {
    loading.value = true;
    // ReceivePort port = ReceivePort();

    // final isolate = await Isolate.spawn<List<dynamic>>(
    //   execIsolate,
    //   [port.sendPort],
    // );
    // port.listen((message) {
    //   print('$message%');
    //   if (message == 100) {
    //     isolate.kill(priority: Isolate.immediate);
    //     loading.value = false;
    //   }
    // });

    await getRegister();
    loading.value = false;
  }

  static execIsolate(List values) async {
    SendPort sendPort = values[0];

    for (var i = 0; i < 100; i++) {
      await Future.delayed(const Duration(microseconds: 500));
      sendPort.send(i + 1);
    }
  }
}
