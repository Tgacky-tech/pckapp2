import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main(){
  runApp(home_screen());
}

class home_screen extends StatelessWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.white,
      title: const Text('iLiteracy'),
    );
    final pushButton1 = ElevatedButton(
        onPressed: () => context.push('/0'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text('ゲーム')
    );
    final pushButton2 = ElevatedButton(
        onPressed: () => context.push('/ranking'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        child: const Text('ランキング'),
    );
    final pushButton3 = ElevatedButton(
        onPressed: () => context.push('/collection'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: const Text('コレクション'),
    );
    final pushButton4 = ElevatedButton(
        onPressed: () => context.push('/settings'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        child: const Text('設定'),
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            pushButton1,
            pushButton2,
            pushButton3,
            pushButton4,
          ],
        ),
      ),
    );
  }
}

