import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pckapp2/providers/topUsers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ranking_screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUsersAsyncValue = ref.watch(topUsersProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('ランキング'),
      ),
      body: topUsersAsyncValue.when(
        data: (topUsers) {
          return ListView.builder(
            itemCount: topUsers.length,
            itemBuilder: (context, index) {
              final user = topUsers[index];
              return Column(
                children: [
                  ListTile(
                    leading: _getRankWidget(index), // 順位に応じたウィジェットを表示
                    title: Text(
                      user['username'],
                      style: TextStyle(fontSize: 20.0), // 文字サイズを大きくする
                    ),
                    subtitle: Text(
                      'Score: ${formatTime(user['score'])}',
                      style: TextStyle(fontSize: 18.0), // スコアの文字サイズを設定
                    ),
                  ),
                  Divider(), // 下線を引く
                ],
              );
            },
          );
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  // 順位を取得する関数
  Widget _getRankWidget(int index) {
    Color bronze = Color(0xCD7F32);
    if (index == 0) {
      return Icon(Icons.emoji_events, color: Colors.amber); // 1位
    } else if (index == 1) {
      return Icon(Icons.emoji_events, color: Colors.grey); // 2位
    } else if (index == 2) {
      return Icon(Icons.emoji_events, color: Colors.brown); // 3位
    } else {
      return Text(
        '${index + 1}', // 4位以下は順位の数字を表示
        style: TextStyle(fontSize: 20.0), // 数字のサイズを設定
      );
    }
  }

  // スコアをフォーマットする関数
  String formatTime(int score) {
    final minutes = score ~/ 60;
    final seconds = score % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
      // body: topUsersAsyncValue.when(
      //   data: (topUsers) {
      //     return ListView.builder(
      //       itemCount: topUsers.length,
      //       itemBuilder: (context, index) {
      //         final user = topUsers[index];
      //
      //         // ランキングアイコンを決定
      //         Icon rankingIcon;
      //         if (index == 0) {
      //           rankingIcon = Icon(Icons.emoji_events, color: Colors.amber); // 1位
      //         } else if (index == 1) {
      //           rankingIcon = Icon(Icons.emoji_events, color: Colors.grey); // 2位
      //         } else if (index == 2) {
      //           rankingIcon = Icon(Icons.emoji_events, color: Colors.brown); // 3位
      //         } else {
      //           rankingIcon = Icon(Icons.star, color: Colors.blueGrey); // それ以外
      //         }
      //
      //         return ListTile(
      //           leading: rankingIcon, // アイコンを追加
      //           title: Text(user['username']),
      //           subtitle: Text('Score: ${formatTime(user['score'])}'),
      //         );
      //       },
      //     );
      //   },
      //   loading: () => Center(child: CircularProgressIndicator()),
      //   error: (err, stack) => Center(child: Text('Error: $err')),
      // ),
      // body: topUsersAsyncValue.when(
      //   data: (topUsers) {
      //     return ListView.builder(
      //       itemCount: topUsers.length,
      //       itemBuilder: (context, index) {
      //         final user = topUsers[index];
      //         return ListTile(
      //           title: Text(user['username']),
      //           subtitle: Text('Score: ${formatTime(user['score'])}'),
      //         );
      //       },
      //     );
      //   },
      //   loading: () => Center(child: CircularProgressIndicator()),
      //   error: (err, stack) => Center(child: Text('Error: $err')),
      // ),
