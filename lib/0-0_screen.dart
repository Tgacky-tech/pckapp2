import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/transitionFromTask_provider.dart';
import 'dart:math' as math;

class Screen00 extends ConsumerStatefulWidget {
  const Screen00({Key? key}) : super(key: key);

  @override
  _Screen00State createState() => _Screen00State();
}

class _Screen00State extends ConsumerState<Screen00>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;
  bool _isAnimationRunning = false; // アニメーション実行中かを追跡

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 4.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _translateAnimation = Tween<double>(
      begin: 200.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    // アニメーションの開始条件をPostFrameCallback内に配置
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transitionFromTask = ref.read(transitionFromTaskProvider);
      if (transitionFromTask) {
        _isAnimationRunning = true; // アニメーションが開始されるのでフラグを立てる
        _controller.forward().then((_) {
          _isAnimationRunning = false; // アニメーションが終了したらリセット
        });
        ref.read(transitionFromTaskProvider.notifier).update((state) => false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final level = ref.watch(levelProvider);
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final error = ref.watch(errorProvider);

    // 各種ボタン
    final pushButton1 = MaterialButton(
      onPressed: () {
        if (1 <= error && error <= 4) {
          context.push('/5');
        } else {
          context.push('/1');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
        height: MediaQuery.of(context).size.width * 0.16,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nmail.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton2 = MaterialButton(
      onPressed: () {
        if (5 <= error && error <= 9) {
          context.push('/5');
        } else {
          context.push('/2');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
        height: MediaQuery.of(context).size.width * 0.16,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nsns.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton3 = MaterialButton(
      onPressed: () {
        if (10 <= error && error <= 14) {
          context.push('/5');
        } else {
          context.push('/3');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
        height: MediaQuery.of(context).size.width * 0.16,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nbrowser.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton4 = MaterialButton(
      onPressed: () {
        if (15 <= error && error <= 18) {
          context.push('/5');
        } else {
          context.push('/4');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.16,
        height: MediaQuery.of(context).size.width * 0.16,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nsettings.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

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
        context.push('/00');
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
        child: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/background.png'),
                fit: BoxFit.cover,
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 27 / 1.7,
                child: Stack(
                  children: [
                    // アニメーションを使用したテキスト
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: _isAnimationRunning
                              ? Offset(0, _translateAnimation.value)
                              : const Offset(0, 0),
                          child: ScaleTransition(
                            scale: _isAnimationRunning
                                ? _scaleAnimation
                                : const AlwaysStoppedAnimation(1.0),
                            child: Container(
                              alignment: Alignment.center,
                              // テキストの表示領域を親に合わせて調整
                              width: double.infinity,
                              height: 100, // 必要に応じて高さを調整
                              child: Text(
                                "0$level:00",
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 15, // フォントサイズを必要に応じて調整
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // 左端にWi-Fiアイコン
                    const Positioned(
                      left: 10,
                      child: Icon(
                        Icons.wifi,
                        color: Colors.black,
                      ),
                    ),
                    Positioned(
                        right: 10,
                        child: Row(
                          children:  [
                            Text(
                              "100%",
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
                        )),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 46,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          pushButton1,
                          const Text(
                            'メール',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton2,
                          const Text(
                            'sns',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton3,
                          const Text(
                            'ブラウザー',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton4,
                          const Text(
                            '設定',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ],
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
              )
            ],
          ),
        ),
      ),
    );
  }
}