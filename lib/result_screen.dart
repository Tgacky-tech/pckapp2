import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/sharedPreferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pckapp2/providers/counterList_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';

class result_screen extends ConsumerWidget {
  const result_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final asyncPrefs = ref.watch(sharedPreferencesProvider);
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final  counterList = ref.watch(counterListProvider);
    final error = ref.watch(errorProvider);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            asyncPrefs.when(
              data: (prefs) {
                // SharedPreferencesから整数値を取得し変数に格納
                // SharedPreferences.setMockInitialValues({});
                final int counterValue = prefs.getInt('counter_key') ?? 0;
                final seconds = counterValue % 60;
                final minutes = seconds ~/ 60;
                final hours = minutes ~/ 60;
                String _twoDigits(int n) => n.toString().padLeft(2, '0');
                final btime =
                    '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'クリアおめでとう！',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'クリアタイム: ${stopwatchNotifier.formattedElapsedTime}\n自己ベスト: $btime',
                        style: TextStyle(fontSize: 35, color: Colors.black),
                      ),
                    ),
                    FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        '登場した異変一覧'
                            // '\nコレクションに保存されたよ！'
                            '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                        ),
                      ),
                    ),
                    FittedBox(
                      //fit: BoxFit.fitWidth,
                      child:  Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: counterList.length,
                        itemBuilder: (context, index) {
                          final number = counterList[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                GestureDetector(
                                  // onTap: () {
                                  //   showDialog(
                                  //       context: context,
                                  //       builder: (BuildContext context) {
                                  //         return Dialog(
                                  //           child: Align(
                                  //             alignment: Alignment.center,
                                  //             child: Column(
                                  //               mainAxisSize: MainAxisSize.min,
                                  //               children: [
                                  //                 Padding(
                                  //                   padding: const EdgeInsets.all(8.0),
                                  //                   child: Text('No.$number',
                                  //                     style: TextStyle(fontSize: 24),
                                  //                   ),
                                  //                 ),
                                  //                 SvgPicture.asset(
                                  //                   "images/異変$number" + "s.svg",
                                  //                   fit: BoxFit.cover,
                                  //                 ),
                                  //               ],
                                  //             ),
                                  //           ),
                                  //         );
                                  //       },
                                  //   );
                                  // },
                                  child:Center(
                                  child: Stack(
                                    children: [
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.8,
                                        child: AspectRatio(
                                          aspectRatio: 4 / 1,
                                          child: ClipRect(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: FractionallySizedBox(
                                                widthFactor: 1.0,
                                                heightFactor: 1,
                                                child: SvgPicture.asset(
                                                  "images/異変$number" + "s.svg",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: Container(
                                          color: Colors.black54,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            'No.$number',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                ),
                          );
                        }),
                      ),
                    ),
                    SizedBox(height: 20),
                    OutlinedButton(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          'ホーム画面へ',
                          style: TextStyle(
                            fontSize: 24,
                            color: Colors.white,
                            letterSpacing: 4.0,
                          ),
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        side: const BorderSide(
                          color: Colors.blueGrey,
                          width: 3.0,
                        ),
                      ),
                      onPressed: () async{
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        String? userId = prefs.getString('userId');
                        int etime = stopwatchNotifier.ElapsedTime;
                        final int ctime = prefs.getInt('counter_key') ?? 0;
                        if (ctime == 0 || etime < ctime) {
                          await firestore
                              .collection('users')
                              .doc(userId)
                              .update({
                            'score': etime,
                          });
                          await prefs.setInt('counter_key', etime);
                        }
                        ;
                        context.go('/home');
                      },
                    ),
                  ],
                );
              },
              loading: () => CircularProgressIndicator(),
              error: (error, stack) => Text(
                'Error: $error',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
