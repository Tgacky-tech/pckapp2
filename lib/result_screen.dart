import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider =
    FutureProvider<SharedPreferences>((ref) async {
      // SharedPreferences.setMockInitialValues({});
  return SharedPreferences.getInstance();
});

class result_screen extends ConsumerWidget {
  const result_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final asyncPrefs = ref.watch(sharedPreferencesProvider);
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
                final btime = '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';
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
                '登場した異変一覧\nコレクションに保存されたよ！',
                textAlign: TextAlign.center,
                style: TextStyle(
                fontSize: 30,
                ),
                    ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () async {
                          SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                          int etime = stopwatchNotifier.ElapsedTime;
                          final int ctime = prefs.getInt('counter_key') ?? 0;
                          if (ctime ==0||etime < ctime) {
                            await prefs.setInt('counter_key', etime);
                          }
                          ;
                          context.push('/home');
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellow,
                            fixedSize: const Size(200, 60)),
                        child: const Text('ホーム画面へ')),
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
