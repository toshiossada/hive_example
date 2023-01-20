import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'home_controller.dart';

class HomePage extends StatefulWidget {
  final HomeController controller;
  const HomePage({super.key, required this.controller});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController get controller => widget.controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                await controller.get();
              },
              child: const Text('Load'),
            ),
            ElevatedButton(
              onPressed: () async {
                await controller.getRegisterPerPage();
              },
              child: const Text('Load Per Page'),
            ),
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed('list');
              },
              child: const Text('Filter'),
            ),
            ValueListenableBuilder(
                valueListenable: controller.loading,
                builder: (context, value, child) {
                  return Visibility(
                    visible: value,
                    child: const CircularProgressIndicator(),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
