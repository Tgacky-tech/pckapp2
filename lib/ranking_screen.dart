import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pckapp2/providers/topUsers_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/sharedPreferences_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pckapp2/providers/currentUserRank_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ユーザー名を取得するProviderを追加
final userNameProvider = FutureProvider<String?>((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? userId = prefs.getString('userId');
  if (userId != null) {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
    await FirebaseFirestore.instance.collection('users').doc(userId).get();

    if (userDoc.exists) {
      return userDoc.data()?['username'];
    }
  }
  return null; // ユーザーが見つからない場合はnullを返す
});

class ranking_screen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final topUsersAsyncValue = ref.watch(topUsersProvider);
    final asyncPrefs = ref.watch(sharedPreferencesProvider);
    final currentUserRank = ref.watch(currentUserRankProvider);
    final userNameAsyncValue = ref.watch(userNameProvider); // ユーザー名取得の状態を監視

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('ランキング',
        style: TextStyle(color: Colors.white),),
      ),
      body: Column(
        children: [
          Expanded(
            child: topUsersAsyncValue.when(
              data: (topUsers) {
                return ListView.builder(
                  itemCount: topUsers.length + 1, // +1で自己ベスト用のスペースを追加
                  itemBuilder: (context, index) {
                    if (index < topUsers.length) {
                      final user = topUsers[index];
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    _getRankWidget(index),
                                    SizedBox(width: 10),
                                    Text(
                                      user['username'],
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                  ],
                                ),
                                Text(
                                  'Time: ${formatTime(user['score'])}',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 13.0), // 左右に余白を追加
                            child: Divider(),
                          )
                        ],
                      );
                    } else {
                      // 自己ベストの表示部分
                      return asyncPrefs.when(
                        data: (prefs) {
                          final int counterValue =
                              prefs.getInt('counter_key') ?? 0;
                          final seconds = counterValue % 60;
                          final minutes = (counterValue ~/ 60) % 60;
                          final hours = counterValue ~/ 3600;
                          String _twoDigits(int n) =>
                              n.toString().padLeft(2, '0');
                          final btime =
                              '${_twoDigits(hours)}:${_twoDigits(minutes)}:${_twoDigits(seconds)}';

                          return counterValue > 0
                              ? Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0),
                            child: Container(
                              height: 30.0, // 必要に応じて高さを調整
                              alignment: Alignment.center,
                              child: Text(
                                '自己ベスト: $btime (順位: ${currentUserRank != -1 ? currentUserRank : "N/A"})',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.black),
                              ),
                            ),
                          )
                              : SizedBox.shrink(); // counterValueが0の場合は何も表示しない
                        },
                        loading: () =>
                            Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Text('Error: $error'),
                      );
                    }
                  },
                );
              },
              loading: () => Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
          // 自己ベストとユーザー名の間の余白を最小限にする
          SizedBox(height: 10), // 最小限の余白
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: userNameAsyncValue.when(
              data: (userName) => userName != null
                  ? Text(
                'ユーザー名: $userName',
                style: TextStyle(fontSize: 25),
              )
                  : Text('ユーザー名が見つかりません'),
              loading: () => CircularProgressIndicator(),
              error: (err, stack) => Text('ユーザー名取得エラー: $err'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getRankWidget(int index) {
    const double rankWidgetWidth = 40.0;
    if (index == 0) {
      return SizedBox(
        width: rankWidgetWidth,
        child: Icon(Icons.emoji_events, color: Colors.amber),
      );
    } else if (index == 1) {
      return SizedBox(
        width: rankWidgetWidth,
        child: Icon(Icons.emoji_events, color: Colors.grey),
      );
    } else if (index == 2) {
      return SizedBox(
        width: rankWidgetWidth,
        child: Icon(Icons.emoji_events, color: Colors.brown),
      );
    } else {
      return SizedBox(
        width: rankWidgetWidth,
        child: Text(
          '${index + 1}',
          style: TextStyle(fontSize: 20.0),
          textAlign: TextAlign.center,
        ),
      );
    }
  }

  String formatTime(int score) {
    final minutes = score ~/ 60;
    final seconds = score % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
