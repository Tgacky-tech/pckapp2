import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';

void main() {
  runApp(MaterialApp(
    home: rule_screen(),
  ));
}

class rule_screen extends ConsumerWidget {
  const rule_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 27 / 46,
                child: Container(
                  child: SvgPicture.asset(
                      'images/ゲームの流れ.svg'
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () {
                              stopwatchNotifier.reset(); // ストップウォッチリセット
                              stopwatchNotifier.start(); // 計測開始
                              context.push('/00');
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              fixedSize: const Size(200, 60)
                            ),
                            child: const Text('スタート')
                        ),
                      ),
                      Container(),
                    ],
                ),
              )
              // TextButton(
            ],
          ),
        ),
      ),
    );
  }
}

