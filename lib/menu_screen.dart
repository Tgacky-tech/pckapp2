import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';

class menu_screen extends ConsumerWidget {
  const menu_screen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('メニュー'),
    );
    return WillPopScope( // WillPopScopeを追加
        onWillPop: () async {
      // 戻るボタンが押されたときの処理
      return false; // 戻るボタンの動作をキャンセル
    },
    child:Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('メニュー'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                '経過時間: ${stopwatchNotifier.formattedElapsedTime}',
                style: TextStyle(fontSize: 35, color: Colors.black),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.13,
              child:
              OutlinedButton(
                child: FittedBox(
                  fit: BoxFit.scaleDown, // ボタンに収まるように文字サイズを調整
                  child: Text(
                    'RESTART',
                    style: TextStyle(
                      fontSize: 24, // 必要に応じて大きさを変更
                      color: Colors.white,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue, // 背景色をグレーに設定
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Colors.blueGrey, // ボーダーの色
                    width: 3.0, // ボーダーの太さを指定
                  ),
                ),
                onPressed: () {
                  stopwatchNotifier.start(); // 計測開始
                  Navigator.of(context).pop();
                },
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.6,
              height: MediaQuery.of(context).size.width * 0.13,
              child:
              OutlinedButton(
                child: FittedBox(
                  fit: BoxFit.scaleDown, // ボタンに収まるように文字サイズを調整
                  child: Text(
                    'ゲーム終了',
                    style: TextStyle(
                      fontSize: 24, // 必要に応じて大きさを変更
                      color: Colors.white,
                      letterSpacing: 4.0,
                    ),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.blue, // 背景色をグレーに設定
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  side: const BorderSide(
                    color: Colors.blueGrey, // ボーダーの色
                    width: 3.0, // ボーダーの太さを指定
                  ),
                ),
                onPressed: () {
                  stopwatchNotifier.reset(); // 計測開始
                  context.push('/home');
                },
              ),
            ),
            // ElevatedButton(
            //     onPressed: () {
            //       stopwatchNotifier.start(); // 計測開始
            //       Navigator.of(context).pop();
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.yellow,
            //         fixedSize: const Size(200, 60)
            //     ),
            //     child: const Text('再開')
            // ),
            // ElevatedButton(
            //     onPressed: () {
            //       stopwatchNotifier.reset(); // 計測開始
            //       context.push('/home');
            //     },
            //     style: ElevatedButton.styleFrom(
            //         backgroundColor: Colors.yellow,
            //         fixedSize: const Size(200, 60)
            //     ),
            //     child: const Text('終了')
            // ),
          ],
        ),
      ),
    ),
    );
  }
}