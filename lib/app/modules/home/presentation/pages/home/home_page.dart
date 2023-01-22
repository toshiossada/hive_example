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
            ElevatedButton(
              onPressed: () {
                Modular.to.pushNamed('listInfinity');
              },
              child: const Text('Filter With Infinity Scroll'),
            ),
            ElevatedButton(
              onPressed: () {
                controller.clear();
              },
              child: const Text('Clear'),
            ),
            ValueListenableBuilder(
                valueListenable: controller.loading,
                builder: (_, loading, __) {
                  return ValueListenableBuilder(
                      valueListenable: controller.percent,
                      builder: (_, percent, __) {
                        if (percent != null) {
                          return Text('$percent%');
                        }
                        return Visibility(
                          visible: loading,
                          child: const CircularProgressIndicator(),
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
