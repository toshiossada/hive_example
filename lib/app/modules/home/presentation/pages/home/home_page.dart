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
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('list');
            },
            icon: const Icon(Icons.list),
          ),
          IconButton(
            onPressed: () {
              Modular.to.pushNamed('listInfinity');
            },
            icon: const Icon(Icons.list_alt_outlined),
          ),
          IconButton(
            onPressed: controller.clear,
            icon: const Icon(Icons.clear),
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: ValueListenableBuilder(
            valueListenable: controller.loading,
            builder: (_, loading, __) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                            await controller.get();
                          },
                    child: const Text('Load Circular Progress Indicator'),
                  ),
                  ElevatedButton(
                    onPressed: loading
                        ? null
                        : () async {
                            await controller.getRegisterPerPage();
                          },
                    child: const Text('Load Percent Progress'),
                  ),
                  ValueListenableBuilder(
                      valueListenable: controller.percent,
                      builder: (_, percent, __) {
                        if (percent != null) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                LinearProgressIndicator(
                                  value: percent / 100,
                                  semanticsLabel: 'Linear progress indicator',
                                ),
                                Text('$percent%'),
                              ],
                            ),
                          );
                        }
                        return Visibility(
                          visible: loading,
                          child: const CircularProgressIndicator(),
                        );
                      }),
                ],
              );
            }),
      ),
    );
  }
}
