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
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('設定'),
    );
    final pushButton1 = ElevatedButton(
      onPressed: () => context.push('/rule'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text('ルール説明'),
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pushButton1,
          ],
        ),
      ),
    );
  }
}
