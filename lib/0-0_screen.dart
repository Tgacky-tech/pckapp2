import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/transitionFromTask_provider.dart';
import 'dart:math' as math;
import 'dart:math';
import 'package:flutter_svg/flutter_svg.dart';

class Screen00 extends ConsumerStatefulWidget {
  const Screen00({Key? key}) : super(key: key);

  @override
  _Screen00State createState() => _Screen00State();
}

class _Screen00State extends ConsumerState<Screen00>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _translateAnimation;
  bool _isAnimationRunning = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

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
    _controller.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      context.push('/menu');
    } else if (state == AppLifecycleState.paused) {
      final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
      stopwatchNotifier.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);
    final error = ref.watch(errorProvider);

    final pushButton1 = _buildButton('images/nmail.png', () {
      if (1 <= error && error <= 4) {
        context.push('/5');
      } else {
        context.push('/1');
      }
    });

    final pushButton2 = _buildButton('images/nsns.png', () {
      if (5 <= error && error <= 9) {
        context.push('/5');
      } else {
        context.push('/2');
      }
    });

    final pushButton3 = _buildButton('images/nbrowser.png', () {
      if (10 <= error && error <= 14) {
        context.push('/5');
      } else {
        context.push('/3');
      }
    });

    final pushButton4 = _buildButton('images/nsettings.png', () {
      if (15 <= error && error <= 18) {
        context.push('/5');
      } else {
        context.push('/4');
      }
    });

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
    //       Positioned.fill(
    //         child: SvgPicture.asset('images/mainbackground.svg'
    //     ,fit: BoxFit.cover,),
    // ),
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
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      AspectRatio(
                        aspectRatio: 27 / 1.7,
                        child: Stack(
                          children: [
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
          // アニメーションを画面上部のAspectRatioの位置に表示する
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Positioned(
                top: MediaQuery.of(context).size.height * 0.094, // アニメーションの位置調整
                left: 0,
                right: 0,
                child: Transform.translate(
                  offset: _isAnimationRunning
                      ? Offset(0, _translateAnimation.value)
                      : const Offset(0, 0),
                  child: ScaleTransition(
                    scale: _isAnimationRunning
                        ? _scaleAnimation
                        : const AlwaysStoppedAnimation(1.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "0$level:00",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String imagePath, VoidCallback onPressed) {
    return MaterialButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.1475,
        height: MediaQuery.of(context).size.width * 0.1475,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
