import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen02 extends StatelessWidget {
  const screen02({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('2:00'),
    );
    final pushButton1 = ElevatedButton(
      onPressed: () => context.push('/1'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
      child: const Text('メール'),
    );
    final pushButton2 = ElevatedButton(
      onPressed: () => context.push('/2'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
      child: const Text('SNS'),
    );
    final pushButton3 = ElevatedButton(
      onPressed: () => context.push('/3'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
      child: const Text('ブラウザ'),
    );
    final pushButton4 = ElevatedButton(
      onPressed: () => context.push('/4'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text('Wi-Fi'),
    );
    final pushButton5 = ElevatedButton(
      onPressed: () => context.push('/5'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text('バッテリー'),
    );
    final pushButton6 = ElevatedButton(
      onPressed: () => context.push('/menu'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text('メニュー'),
    );
    final pushButton7 = TextButton(
        onPressed: () => context.push('/03'),
        child: const Text('〇'),
    );
    final pushButton8 = TextButton(
      onPressed: () => context.push('/00'),
      child: const Text('✖'),
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
            pushButton5,
            pushButton6,
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  pushButton7,
                  pushButton8,
                ],
            ),
          ],
        ),
      ),
    );
  }
}
