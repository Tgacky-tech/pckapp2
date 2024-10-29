import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class screen1 extends ConsumerStatefulWidget {
  const screen1({Key? key}) : super(key: key);

  @override
  _screen1State createState() => _screen1State();
}

class _screen1State extends ConsumerState<screen1>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  }

  @override
  void dispose() {
    // WidgetsBindingObserverを解除
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // アプリのライフサイクルの変化を監視
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // ライフサイクルの状態が変化した時に呼び出される
    final currentLocation =
        GoRouter.of(context).routerDelegate.currentConfiguration;
    // 現在のパスを取得
    if (state == AppLifecycleState.resumed) {
      // フォアグラウンド状態に戻った時の処理

      // バックグラウンド状態になったときの処理
      context.push('/menu');
    } else if (state == AppLifecycleState.paused) {
      // バックグラウンド状態に移行した時の処理
      final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
      stopwatchNotifier.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Stack(
        children: [
      Positioned.fill(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,// 横に並べる画像の数
        childAspectRatio: 1.4, // 正方形として表示
      ),
      itemBuilder: (context, index) {
        return FittedBox(
          fit: BoxFit.contain, // 画像全体が見えるように縮小
          child: Transform.rotate(
            angle: -0.1, // 画像を斜めにする角度（ラジアンで指定）
            child: Image.asset(
              'images/grey.png', // 使用する画像のパス
              fit: BoxFit.cover,
            ),
          ),
        );
      },
    ),
    ),
    Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 1.8,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black, width: 2),
            ),
            padding: EdgeInsets.all(4),
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
                    child: SvgPicture.asset('images/メール.svg'
                      ,fit: BoxFit.cover,),
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
    ]
      ),
    );
  }
}
