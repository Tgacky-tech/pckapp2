import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'dart:math' as math;

class screen00 extends ConsumerWidget {
  const screen00({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final level = ref.watch(levelProvider);
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final error = ref.watch(errorProvider);
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
    // final pushButton5 = ElevatedButton(
    //   onPressed: () => context.push('/5'),
    //   style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
    //   child: const Text('バッテリー'),
    // );
    final pushButton6 = TextButton(
      onPressed: (){
        stopwatchNotifier.stop();
        context.push('/menu');
      },

      child: const Text('◁',
        style: TextStyle(
          fontSize: 25/*サイズ*/,
        ),),
    );

    final pushButton7 = TextButton(
      onPressed: () {
        context.push('/00');
      },
      child: const Text('〇',
        style: TextStyle(
            fontSize: 20),),
    );
    final pushButton9 = TextButton(
      onPressed: () => context.push('/task'),
      child: const Text('□',
        style: TextStyle(
            fontSize: 25),),
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
                        child:
                        Row(
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
                        )

                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 46,
                child: Container(
                  alignment: Alignment.topCenter,
                  padding:EdgeInsets.symmetric(vertical: 10,),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          pushButton1,
                          Text(
                            'メール',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton2,
                          Text(
                            'sns',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton3,
                          Text(
                            'ブラウザー',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          pushButton4,
                          Text(
                            '設定',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                    // children: <Widget>[
                    //   pushButton1,
                    //   pushButton2,
                    //   pushButton3,
                    //   pushButton4,
                    //   // pushButton5,
                    //
                    // ],
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
    );
  }
}