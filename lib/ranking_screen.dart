import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pckapp2/providers/topUsers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

String formatTime(int totalSeconds) {
  // 時、分、秒を計算
  int hours = totalSeconds ~/ 3600;
  int minutes = (totalSeconds % 3600) ~/ 60;
  int seconds = totalSeconds % 60;

  // 2桁のゼロ埋めされた文字列を作成
  String hoursStr = hours.toString().padLeft(2, '0');
  String minutesStr = minutes.toString().padLeft(2, '0');
  String secondsStr = seconds.toString().padLeft(2, '0');

  return "$hoursStr:$minutesStr:$secondsStr";
}

class ranking_screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUsersAsyncValue = ref.watch(topUsersProvider);
    final appBar = AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('ランキング'),
    );
    return Scaffold(
      body: topUsersAsyncValue.when(
        data: (topUsers) {
          return ListView.builder(
            itemCount: topUsers.length,
            itemBuilder: (context, index) {
              final user = topUsers[index];
              return ListTile(
                title: Text(user['username']),
                subtitle: Text('Score: ${formatTime(user['score'])}'),
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}