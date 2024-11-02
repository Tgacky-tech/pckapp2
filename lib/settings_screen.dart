import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pckapp2/providers/tutorial_provider.dart';

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
        backgroundColor: Colors.blue,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('設定',
            style: TextStyle(color: Colors.white),),
      ),
      body: ListView(
        children: [
          // _buildSettingItem(
          //   icon: Icons.info,
          //   title: 'ルール説明',
          //   onTap: () async {},
          // ),
          _buildSettingItem(
            icon: Icons.person,
            title: 'ユーザー名変更',
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return ChangeUsernameDialog();
                },
              );

            },
          ),
          _buildSettingItem(
            icon: Icons.sports_esports,
            title: 'チュートリアル',
            onTap: () {
              ref.read(tutorialProvider.notifier).setTutorial(0);
              context.push('/tutorialStart');

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
        padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
        child: Column(
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  size: 30.0,
                ),
                const SizedBox(width: 16.0),
                Text(
                  title,
                  style: const TextStyle(fontSize: 20.0),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            const Divider(color: Colors.grey),
          ],
        ),
      ),
    );
  }
}

class ChangeUsernameDialog extends StatefulWidget {
  @override
  _ChangeUsernameDialogState createState() => _ChangeUsernameDialogState();
}

class _ChangeUsernameDialogState extends State<ChangeUsernameDialog> {
  final TextEditingController _usernameController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isLoading = false;

  Future<void> _changeUsername() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');

    if (userId != null && _usernameController.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      await _firestore.collection('users').doc(userId).update({
        'username': _usernameController.text,
      });

      setState(() {
        _isLoading = false;
      });

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'ユーザー名を変更',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: '新しいユーザー名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _changeUsername,
              child: const Text('変更する'),
            ),
          ],
        ),
      ),
    );
  }
}