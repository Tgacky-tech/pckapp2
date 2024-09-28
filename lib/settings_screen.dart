import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MaterialApp(
        home: settings_screen(),
      ),
    ),
  );
}

class settings_screen extends ConsumerWidget {
  const settings_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('設定'),
      ),
      body: ListView(
        children: [
          _buildSettingItem(
            icon: Icons.info,
            title: 'ルール説明',
            onTap: () async {
              // final prefs = await SharedPreferences.getInstance();
              // await prefs.setInt('counter_key', 0);
            },
          ),
          _buildSettingItem(
            icon: Icons.person,
            title: 'ユーザー名変更',
            onTap: () {
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // ボタンを大きくする
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30.0, // アイコンを大きくする
                ),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20.0), // 文字を大きくする
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(color: Colors.grey), // 下線を追加
          ],
        ),
      ),
    );
  }
}