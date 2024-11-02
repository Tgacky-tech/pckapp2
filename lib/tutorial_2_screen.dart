import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

import 'package:pckapp2/providers/tutorial_provider.dart';

class tutorialScreen2 extends ConsumerStatefulWidget {
  const tutorialScreen2({Key? key}) : super(key: key);

  @override
  _screen2State createState() => _screen2State();
}

class _screen2State extends ConsumerState<tutorialScreen2>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  GlobalKey keyButton1 = GlobalKey();
  GlobalKey keyButton2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);

    List<TargetFocus> targets = [];

    targets.add(TargetFocus(
      identify: "Target",
      keyTarget: keyButton1,
      contents: [
        TargetContent(
          align: ContentAlign.top,
        ),
      ],
      shape: ShapeLightFocus.RRect,
      radius: 5,
    )
    );
    targets.add(TargetFocus(
      identify: "Target",
      keyTarget: keyButton2,
      contents: [
        TargetContent(
          align: ContentAlign.top,
          child: Text(
            "異変はなさそうです\nホーム画面に戻りましょう",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20
            ),
          ),
        ),
      ],
    )
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showTutorial(context, targets);
    });

    final pushButton6 = TextButton(
      onPressed: () {
        null;
      },
      child: const Text(
        '◁',
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );

    final pushButton7 = TextButton(
      key: keyButton2,
      onPressed: () {
        context.go('/tutorial');
        ref.read(tutorialProvider.notifier).setTutorial(2);
      },
      child: const Text(
        '〇',
        style: TextStyle(fontSize: 20),
      ),
    );

    final pushButton9 = TextButton(
      onPressed: null,
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
        child:  FittedBox(
            fit: BoxFit.scaleDown,child:SizedBox(
          key: keyButton1,
          width: MediaQuery.of(context).size.width * 0.95,
          height: MediaQuery.of(context).size.width * 1.8,
    child: SingleChildScrollView(child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Colors.black, width: 2),
            ),
            padding: EdgeInsets.all(4),
            child: SingleChildScrollView(child:Column(
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
                ),
                AspectRatio(
                  aspectRatio: 27 / 46,
                  child: Container(
                    child: SvgPicture.asset('images/LinkUp.svg'),
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
          ),
          ),
    ]
      ),
    );
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

