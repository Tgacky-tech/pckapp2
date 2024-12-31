import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'dart:math' as math;

class screen10 extends ConsumerWidget {
  const screen10({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          fontSize: 25, // サイズ
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
                crossAxisCount: 4, // 横に並べる画像の数
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
            child: FittedBox(
          fit: BoxFit.scaleDown,child:SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 1.78,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black, width: 5),
                ),
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
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Stack(
                        // alignment: Alignment.center, // スタック内で中央に配置
                        children: [
                          AspectRatio(
                            aspectRatio: 27 / 46,
                            child: Container(
                              child: SvgPicture.asset(
                                'images/message.svg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          // 1秒後にフェードインする画像
                          DelayedFadeInImage(),
                        ],
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

class DelayedFadeInImage extends StatefulWidget {
  @override
  _DelayedFadeInImageState createState() => _DelayedFadeInImageState();
}

class _DelayedFadeInImageState extends State<DelayedFadeInImage> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    // 1秒後にアニメーションを開始
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isVisible = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: Duration(seconds: 1), // フェードインにかかる時間
      child: SvgPicture.asset(
        'images/21.svg', // フェードインさせる画像のパス
        fit: BoxFit.cover,
        width: MediaQuery.of(context).size.width * 0.95, // 画像の幅
        // height: 100, // 画像の高さ
      ),
    );
  }
}
