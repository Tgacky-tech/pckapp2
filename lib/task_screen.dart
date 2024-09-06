import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:math' as math;
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pckapp2/rule_screen.dart';
import 'package:pckapp2/main.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/scrollPosition_provider.dart';
import 'package:pckapp2/providers/counter_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';

class task_screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final scrollPosition = ref.watch(scrollPositionProvider);
    final counter = ref.watch(counterProvider);
    final level = ref.watch(levelProvider);
    var random = math.Random();

    return Scaffold(
      body: Center(
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
                  if (scrollPosition <= 110) {
                    ref.read(levelProvider.notifier).state++;
                    final level = ref.read(levelProvider);
                    ref.read(scrollPositionProvider.notifier).state =
                        notification.metrics.pixels;
                    // ref.read(counterProvider.notifier).state++;
                    // final proceedPath = '/0${ref.read(counterProvider)}';
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      // context.push(proceedPath);
                      if (level > 8) {
                        ref.read(levelProvider.notifier).state = 0;
                        stopwatchNotifier.stop();
                        context.push('/result');
                      } else {
                        context.push('/00');
                      }
                      //Navigator.push(
                        //context,
                        //MaterialPageRoute(builder: (context) => rule_screen()),
                      //);
                    });
                    ref.read(errorProvider.notifier).state = random.nextInt(40);
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
                    height: MediaQuery.of(context).size.height * 1.05, // 高さを大きくしてスクロール可能にする
                    child: Center(
                      child: Column(
                      children:[
                        Container(
                          width: MediaQuery.of(context).size.width * 0.03,
                          height: MediaQuery.of(context).size.height * 0.03,
                        ),
                      Container(
                        // color: Colors.yellow,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: MediaQuery.of(context).size.height * 0.8,
                          child:MaterialButton(
                            onPressed: () {
                              ref.read(counterProvider.notifier).state = 0;
                              ref.read(levelProvider.notifier).state++;
                              final level = ref.read(levelProvider);
                              final backPath = '/0${ref.read(counterProvider)}';
                              // context.push(backPath);
                              if (level > 8) {
                                stopwatchNotifier.stop();
                                ref.read(levelProvider.notifier).state = 0;
                                context.push('/result');
                              } else {
                                context.push('/00');
                              }
                            },
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.78,
                              height: MediaQuery.of(context).size.width * 1.4,
                              child: Image.asset(
                                'images/mscreen.png',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                    ),
                        // Container(
                        //   width: MediaQuery.of(context).size.width * 0.8,
                        //   height: MediaQuery.of(context).size.height * 0.8,
                        // )
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
    );
    // final hasScrolled = ref.watch(scrollProvider);
    // return Scaffold(
    //   body: Center(
    //       child: AspectRatio(
    //           aspectRatio: 27 / 51.5,
    //       // child: Container(
    //       // decoration: const BoxDecoration(
    //       //     image: DecorationImage(
    //       //   image: AssetImage('images/background2.png'),
    //       //   fit: BoxFit.cover,
    //       // )),
    //       child: Column(
    //         mainAxisSize: MainAxisSize.min,
    //         children: <Widget>[
    //             SingleChildScrollView(
    //               child: Column(
    //                 children: [
    //                   // NotificationListenerでスクロールイベントをリッスン
    //                   NotificationListener<ScrollNotification>(
    //                     onNotification: (ScrollNotification notification) {
    //                       // スクロール位置をログに出力
    //                       print('Scroll position: ${notification.metrics.pixels}');
    //
    //                       // 任意の処理をここに追加
    //                       // 例えば、一定のスクロール位置に達した場合にアラートを表示するなど
    //                       if (notification.metrics.pixels > 100) {
    //                         // 例えば、100ピクセル以上スクロールしたときにアラートを表示
    //                         print('Scrolled more than 100 pixels!');
    //                         Navigator.push(
    //                           context,
    //                           MaterialPageRoute(builder: (context) => rule_screen()),
    //                         );
    //                       }
    //
    //                       // スクロールイベントを処理したことを示す
    //                       return false;
    //                     },
    //                     child: Container(
    //                       width: double.infinity,
    //                       height: 1000, // 高さを大きくしてスクロール可能にする
    //                       color: Colors.blueAccent,
    //                       child: Center(
    //                         child: Text(
    //                           'Scrollable Container',
    //                           style: TextStyle(fontSize: 24, color: Colors.white),
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   SizedBox(height: 20),
    //                   Container(
    //                     width: double.infinity,
    //                     height: 500, // 他のコンテンツを追加
    //                     color: Colors.green,
    //                     child: Center(
    //                       child: Text(
    //                         'Other Content',
    //                         style: TextStyle(fontSize: 24, color: Colors.white),
    //                       ),
    //                     ),
    //                   ),
    //                 ],
    //               ),
    //             ),
    //         ],
    //       ),
    //     ),
    //   ),
    //   );
    // );
  }
}

// class task_screen extends ConsumerWidget {
//   const task_screen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//
//     return Scaffold(
//       body: Center(
//         child: Container(
//           decoration: const BoxDecoration(
//               image: DecorationImage(
//                 image: AssetImage('images/background2.png'),
//                 fit: BoxFit.cover,
//               )),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               AspectRatio(
//                 aspectRatio: 27 / 51.5,
//                 child: Container(
//                 ),
//               ),
//               // TextButton(
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
