import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'dart:math' as math;

class screen12 extends ConsumerStatefulWidget {
  const screen12({Key? key}) : super(key: key);

  @override
  _Screen12State createState() => _Screen12State();
}

class _Screen12State extends ConsumerState<screen12> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5), // アニメーションの期間
      vsync: this,
    )..forward(); // アニメーションを開始

    _animation = Tween<double>(begin: 100, end: 0).animate(_controller)
      ..addListener(() {
        setState(() {}); // アニメーションの進行に応じてUIを再構築
      });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);
    final error = ref.watch(errorProvider);

    final pushButton6 = TextButton(
      onPressed: () {
        stopwatchNotifier.stop();
        context.push('/menu');
      },
      child: const Text(
        '◁',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );

    final pushButton7 = TextButton(
      onPressed: () {
        context.go('/00');
      },
      child: const Text(
        '〇',
        style: TextStyle(fontSize: 20),
      ),
    );

    final pushButton9 = TextButton(
      onPressed: () => context.push('/task'),
      child: const Text(
        '□',
        style: TextStyle(fontSize: 25),
      ),
    );

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  fit: BoxFit.contain,
                  child: Transform.rotate(
                    angle: -0.1,
                    child: Image.asset(
                      'images/grey.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            ),
          ),
          Center(
            child: FittedBox(
          fit: BoxFit.scaleDown,child:SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 1.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                padding: EdgeInsets.all(4),
                child:SingleChildScrollView(child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 27 / 1.7,
                        child: Container(
                          color: Colors.white,
                          child: Stack(
                            children: [
                              Container(
                                alignment: Alignment.center,
                                child: Text(
                                  "0$level:00", // 時刻はアニメーションしない
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 10,
                                child: Icon(
                                  Icons.wifi,
                                  color: Colors.black,
                                ),
                              ),
                              Positioned(
                                right: 10,
                                child: Row(
                                  children: [
                                    Text(
                                      "${_animation.value.toStringAsFixed(0)}%",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                      ),
                                    ),
                                    Transform.rotate(
                                      angle: -math.pi / -2,
                                      child: Icon(
                                        Icons.battery_full,
                                        color: Colors.black,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 27 / 46,
                        child: Container(
                          child: SvgPicture.asset(
                            'images/battery.svg',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      AspectRatio(
                        aspectRatio: 27 / 4,
                        child: Container(
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              pushButton6,
                              pushButton7,
                              pushButton9,
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          ),),
        ],
      ),
    );
  }
}
