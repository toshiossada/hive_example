// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'calc.dart';
import 'widgets/stagge_animation_widget.dart';

class AnimationPage extends StatefulWidget {
  const AnimationPage({super.key});

  @override
  State<AnimationPage> createState() => _AnimationPageState();
}

class _AnimationPageState extends State<AnimationPage>
    with TickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        duration: const Duration(milliseconds: 250), vsync: this);

    _playAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _playAnimation() async {
    _controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 10.0; // 1.0 is normal animation speed.
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staggered Animation'),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  print('####################################################');
                  print('Start SEM isolate: ${DateTime.now()}');
                  print('Fibonacci SEM -> ${Calc.fibonacci(42)}');
                  print('Finish SEM isolate: ${DateTime.now()}');
                },
                child: const Text('Calc Fibonacci'),
              ),
              ElevatedButton(
                onPressed: () async {
                  print('####################################################');
                  print('Start COM isolate: ${DateTime.now()}');
                  print(
                    'Fibonacci COM isolate-> ${await Calc.isolateFibonacci(42)}',
                  );
                  print('Finish COM isolate: ${DateTime.now()}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: const Text('Calc Fibonacci Isolate'),
              )
            ],
          ),
          const SizedBox(height: 100),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              _playAnimation();
            },
            child: Center(
              child: Container(
                width: 300.0,
                height: 300.0,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.1),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
                child: StaggerAnimation(controller: _controller.view),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
