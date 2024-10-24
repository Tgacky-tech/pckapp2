import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'dart:math' as math;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MaterialApp(
    home: rule_screen(),
  ));
}

class rule_screen extends ConsumerWidget {
  const rule_screen({Key? key}) : super(key: key);
  Future<bool> isFirstTime() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('button_pressed') ?? true;
  }

  // 初回であることを記録する関数
  Future<void> setFirstTimeFlag() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('button_pressed', false);
  }

  // ボタンを押したときの処理
  void onButtonPressed(BuildContext context) async {
    if (await isFirstTime()) {
      // チュートリアル画面に遷移するコードを書く
      // 初回であることを記録
      await setFirstTimeFlag();
    } else {
      // 2回目以降なら「通常の画面」に遷移
      context.push('/00');
    }
  }
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final error = ref.watch(errorProvider);
    var random = math.Random();
    // final level = ref.watch(levelProvider);
    final valueProvider = StateProvider<int>((ref) {
      // 初期値を設定
      return 0;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('ゲーム開始'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 27 / 41,
                child: Container(
                  child: SvgPicture.asset(
                      'images/ゲームの流れ.svg'
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        height: MediaQuery.of(context).size.width * 0.13,
                        child:
                        OutlinedButton(
                          child: FittedBox(
                            fit: BoxFit.scaleDown, // ボタンに収まるように文字サイズを調整
                            child: Text(
                              'START',
                              style: TextStyle(
                                fontSize: 24, // 必要に応じて大きさを変更
                                color: Colors.white,
                                letterSpacing: 4.0,
                              ),
                            ),
                          ),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.blue, // 背景色をグレーに設定
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            side: const BorderSide(
                              color: Colors.blueGrey, // ボーダーの色
                              width: 3.0, // ボーダーの太さを指定
                            ),
                          ),
                          onPressed: () {
                            ref.read(errorProvider.notifier).state = random.nextInt(35) + 1;
                            stopwatchNotifier.reset(); // ストップウォッチリセット
                            stopwatchNotifier.start(); // 計測開始
                            onButtonPressed(context);
                          },
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

