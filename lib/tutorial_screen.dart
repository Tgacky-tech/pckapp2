import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/0-0_screen.dart';
import 'package:pckapp2/providers/tutorial_provider.dart';
import 'package:pckapp2/tutorialError_screen.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/transitionFromTask_provider.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:pckapp2/animations/countdown_animation.dart';
import 'dart:math' as math;

class tutorial_screen extends ConsumerStatefulWidget {
  const tutorial_screen({Key? key}) : super(key: key);

  @override
  _ScreenTutorialState createState() => _ScreenTutorialState();
}

class _ScreenTutorialState extends ConsumerState<tutorial_screen>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;
  bool _isAnimationRunning = false;
  bool _isAnimationVisible = true;
  // bool _isCurrentScreen = false;

  void _onAnimationComplete() {
    setState(() {
      _isAnimationVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance!.addObserver(this);

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final transitionFromTask = ref.read(transitionFromTaskProvider);
      if (transitionFromTask) {
        _isAnimationRunning = true;
        _controller.forward().then((_) {
          _isAnimationRunning = false;
        });
        ref.read(transitionFromTaskProvider.notifier).update((state) => false);
      }
    });
  }

  @override
  void dispose() {
    // WidgetsBindingObserverを解除
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // アプリのライフサイクルの変化を監視
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // ライフサイクルの状態が変化した時に呼び出される
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

  GlobalKey keyButton0 = GlobalKey();
  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();
  GlobalKey keyButton3 = GlobalKey();
  GlobalKey keyButton4 = GlobalKey();
  GlobalKey keyButton5 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);
    int currentTutorial = ref.watch(tutorialProvider);

    List<TargetFocus> targets = _getTutorialTargets(currentTutorial);

    _showTutorial(context, targets);

    // 各種ボタン
    final pushButton1 = MaterialButton(
      key: keyButton0,
      onPressed: () {
        context.go('/tutorial1');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1475,
        height: MediaQuery.of(context).size.width * 0.1475,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nmail.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton2 = MaterialButton(
        key: keyButton1,
      onPressed: () {
        if (level == 0) {
          context.go('/tutorial2');
        } else {
          context.go('/tutorialError');
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1475,
        height: MediaQuery.of(context).size.width * 0.1475,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nsns.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton3 = MaterialButton(
      key: keyButton2,
      onPressed: () {
        context.go('/tutorial3');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1475,
        height: MediaQuery.of(context).size.width * 0.1475,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/nbrowser.png'),
              fit: BoxFit.cover,
            )),
      ),
    );

    final pushButton4 = MaterialButton(
      key: keyButton3,
      onPressed: () {
        context.go('/tutorial4');
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1475,
        height: MediaQuery.of(context).size.width * 0.1475,
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
        context.go('/menu');
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
        context.go('/tutorial');
      },
      child: const Text(
        '〇',
        style: TextStyle(fontSize: 20),
      ),
    );

    final pushButton9 = TextButton(
      key: keyButton4,
      onPressed: () => context.go('/tutorialTask'),
      child: const Text(
        '□',
        style: TextStyle(fontSize: 25),
      ),
    );

    return Scaffold(
      body:  Stack(
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
    ),Center(
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
            child: SingleChildScrollView(child:Container(
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
                                  height: 100, // 固定の高さを設定
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
                            children: [
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
                          ),
                        ),
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
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    pushButton1,
                                    const Text(
                                      'メール',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    pushButton2,
                                    const Text(
                                      'SNS',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    pushButton3,
                                    const Text(
                                      'ブラウザ',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Column(
                                  children: <Widget>[
                                    pushButton4,
                                    const Text(
                                      '設定',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      pushButton6,
                      pushButton7,
                      pushButton9,
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ),]),
    );
  }

  List<TargetFocus> _getTutorialTargets(int tutorialStep) {
    switch (tutorialStep) {
      case 0:
        return [
          TargetFocus(
            identify: "Button 0",
            keyTarget: keyButton0,
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Text(
                  "メールアプリを押して\n異変がないか確認しましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      case 1:
        return [
          TargetFocus(
            identify: "Button 1",
            keyTarget: keyButton1,
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Text(
                  "SNSアプリを押して\n異変がないか確認しましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      case 2:
        return [
          TargetFocus(
            identify: "Button 2",
            keyTarget: keyButton2,
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Text(
                  "ブラウザアプリを押して\n異変がないか確認しましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      case 3:
        return [
          TargetFocus(
            identify: "Button 3",
            keyTarget: keyButton3,
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Text(
                  "設定アプリを押して\n異変がないか確認しましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      case 4:
        return [
          TargetFocus(
            identify: "Button 4",
            keyTarget: keyButton4,
            contents: [
              TargetContent(
                align: ContentAlign.top,
                child: Text(
                  "今回は異変がないようです\nタスク管理画面に行き\n判断が正しいか確かめましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      case 5:
        return [
          TargetFocus(
            identify: "Button 5",
            keyTarget: keyButton5,
            contents: [
              TargetContent(
                align: ContentAlign.top,
                child: Text(
                  "時計が一時間進んでいます\nこれは先ほどの判断が正しかったということです",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
          TargetFocus(
            identify: "Button 0",
            keyTarget: keyButton0,
            contents: [
              TargetContent(
                align: ContentAlign.bottom,
                child: Text(
                  "メールアプリを押して\n異変がないか確認しましょう",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20
                  ),
                ),
              ),
            ],
          ),
        ];
      default:
        return [];
    }
  }

  void _showTutorial(BuildContext context, List<TargetFocus> targets) {
    TutorialCoachMark(
      targets: targets,
      colorShadow: Colors.black,
      textSkip: "SKIP",
      paddingFocus: 10,
    )..show(context: context);
  }
}