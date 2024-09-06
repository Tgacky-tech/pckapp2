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
    return Scaffold(
      appBar: appBar,
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
            ElevatedButton(
                onPressed: () {
                  stopwatchNotifier.start(); // 計測開始
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    fixedSize: const Size(200, 60)
                ),
                child: const Text('再開')
            ),
          ],
        ),
      ),
    );
  }
}