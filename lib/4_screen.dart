import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class screen4 extends ConsumerWidget {
  const screen4({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);
    final pushButton6 = TextButton(
      onPressed: () {
        stopwatchNotifier.stop();
        context.push('/menu');
      },
      child: const Text(
        '◁',
        style: TextStyle(
          fontSize: 25 /*サイズ*/,
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
      body: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
            ),
            padding: EdgeInsets.all(8),
            child: Container(
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
                              "0" + "$level" + ":00",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          // 左端にWi-Fiアイコン
                          Positioned(
                            left: 10, // 左側の余白を調整
                            child: Icon(
                              Icons.wifi,
                              color: Colors.black, // アイコンの色を調整
                            ),
                          ),
                          Positioned(
                              right: 10,
                              child: Row(
                                children: [
                                  Text(
                                    "100%",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Transform.rotate(
                                    angle: -math.pi / -2, // バッテリーアイコンを45度傾ける
                                    child: Icon(
                                      Icons.battery_full,
                                      color: Colors.black, // アイコンの色を調整
                                      size: 24, // アイコンのサイズを調整
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 27 / 46,
                    child: Container(
                      child: SvgPicture.asset('images/wifi.svg'),
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
                          // pushButton8,
                          pushButton9,
                        ],
                      ),
                    ),
                  )
                  // TextButton(
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
