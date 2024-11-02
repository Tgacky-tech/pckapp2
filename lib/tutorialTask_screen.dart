import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pckapp2/providers/tutorial_provider.dart';
import 'package:pckapp2/rule_screen.dart';
import 'package:pckapp2/main.dart';
import 'package:pckapp2/swipeAnimation.dart';
import 'package:pckapp2/tapAnimation.dart';
import 'package:pckapp2/tutorial_screen.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/scrollPosition_provider.dart';
import 'package:pckapp2/providers/counter_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/counterList_provider.dart';
  import 'package:pckapp2/providers/transitionFromTask_provider.dart';

class TutorialTaskScreen extends ConsumerStatefulWidget {
  const TutorialTaskScreen({Key? key}) : super(key: key);

  @override
  _TutorialTaskScreenState createState() => _TutorialTaskScreenState();
}

class _TutorialTaskScreenState extends ConsumerState<TutorialTaskScreen> {
  @override
  Widget build(BuildContext context) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final scrollPosition = ref.watch(scrollPositionProvider);
    final counter = ref.watch(counterProvider);
    final level = ref.watch(levelProvider);
    final error = ref.watch(errorProvider);
    final counterList = ref.watch(counterListProvider);
    var random = math.Random();
    int n = 0;

    return Stack(children: [
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
      Scaffold(
        body: Center(
          child: Stack(alignment: Alignment.center, children: [
            // Center(
            // child:level == 0 ? swipeAnimation() : tapAnimation(),
            // ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
              height: MediaQuery.of(context).size.width * 1.8,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: Colors.black, width: 2),
                ),
                padding: EdgeInsets.all(4),
                child: AspectRatio(
                  aspectRatio: 27 / 51.5,
                  child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                      if (notification is ScrollUpdateNotification) {
                        // スクロール位置をプロバイダーに更新
                        ref.read(scrollPositionProvider.notifier).state =
                            notification.metrics.pixels;

                        // スクロール位置が100ピクセルを超えたときに画面遷移を実行
                        if (notification.metrics.pixels > 110) {
                          // 遷移が実行済みでない場合にのみ遷移を実行
                          if (scrollPosition <= 110 && n == 0) {
                            n++;
                            if (level == 1) {
                              ref.read(levelProvider.notifier).state++;
                              final level = ref.read(levelProvider);
                              ref.read(scrollPositionProvider.notifier).state =
                                  notification.metrics.pixels;
                              // ref.read(counterProvider.notifier).state++;
                              // final proceedPath = '/0${ref.read(counterProvider)}';
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                // context.push(proceedPath);
                                ref.read(levelProvider.notifier).state = 0;
                                context.go('/tutorialEnd');
                              });
                            }
                          }
                        }
                      }
                      return false; // 他のウィジェットにも通知を伝える
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            decoration: const BoxDecoration(
                                image: DecorationImage(
                              image: AssetImage('images/background2.png'),
                              fit: BoxFit.cover,
                            )),
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 1.05,
                            child: Center(
                              child: Column(
                                children: [
                                  // Container(
                                  //   width: MediaQuery.of(context).size.width * 0.03,
                                  //   height: MediaQuery.of(context).size.height * 0.03,
                                  // ),
                                  Container(
                                    // color: Colors.yellow,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    height: MediaQuery.of(context).size.height *
                                        0.8,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.8,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.8,
                                      child: MaterialButton(
                                        onPressed: () {
                                          if (level == 0) {
                                            ref
                                                .read(levelProvider.notifier)
                                                .state++;
                                            final level =
                                                ref.read(levelProvider);
                                            // ref.read(counterProvider.notifier).state++;
                                            // final proceedPath = '/0${ref.read(counterProvider)}';
                                            WidgetsBinding.instance
                                                .addPostFrameCallback((_) {
                                              // context.push(proceedPath);
                                              context.go('/tutorial');
                                              ref
                                                  .read(
                                                      tutorialProvider.notifier)
                                                  .setTutorial(5);
                                            });
                                          }
                                        },
                                        child: Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.78,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              1.4,
                                          child: Image.asset(
                                            'images/mscreen.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
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
          ]),
        ),
      ),
      // MaterialButton(
      //   onPressed: () {
      //     if(level == 0){
      //       ref.read(levelProvider.notifier).state++;
      //       final level = ref.read(levelProvider);
      //       // ref.read(counterProvider.notifier).state++;
      //       // final proceedPath = '/0${ref.read(counterProvider)}';
      //       WidgetsBinding.instance.addPostFrameCallback((_) {
      //         // context.push(proceedPath);
      //         context.go('/tutorial');
      //         ref.read(tutorialProvider.notifier).setTutorial(0);
      //       });
      //     }
      //   },
      Center(
        child: level == 0
            ? MaterialButton(
                onPressed: () {
                  if (level == 0) {
                    ref.read(levelProvider.notifier).state++;
                    final level = ref.read(levelProvider);
                    // ref.read(counterProvider.notifier).state++;
                    // final proceedPath = '/0${ref.read(counterProvider)}';
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // context.push(proceedPath);
                      context.go('/tutorial');
                      ref.read(tutorialProvider.notifier).setTutorial(0);
                    });
                  }
                },
                child: tapAnimation()
              )
            : swipeAnimation(),
      ),
      // ),
    ]);
  }
}
