import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';

class result_screen extends ConsumerWidget {
  const result_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'クリアおめでとう！',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'クリアタイム: ${stopwatchNotifier.formattedElapsedTime}',
              style: TextStyle(
                fontSize: 35,
              ),
            ),
            Text(
              '登場した異変一覧\nコレクションに保存されたよ！',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  context.push('/home');
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    fixedSize: const Size(200, 60)
                ),
                child: const Text('ホーム画面へ')
            ),
          ],
        ),
      ),
    );
  }
}
