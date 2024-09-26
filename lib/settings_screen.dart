import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(
    home: settings_screen(),
  ));
}

class settings_screen extends StatelessWidget {
  const settings_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final pushButton1 = ElevatedButton(
      onPressed: () => context.push('/rule'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text('ルール説明'),
    );
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
            onTap: () {
              // ルール説明画面へ遷移するコード
            },
          ),
          _buildSettingItem(
            icon: Icons.person,
            title: 'ユーザー名変更',
            onTap: () {
              // ユーザー名変更画面へ遷移するコード
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
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0), // ボタンを大きくする
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey), // 下線を追加
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30.0, // アイコンを大きくする
            ),
            SizedBox(width: 16.0),
            Text(
              title,
              style: TextStyle(fontSize: 20.0), // 文字を大きくする
            ),
          ],
        ),
      ),
    );
  }
}
