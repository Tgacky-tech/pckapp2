import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class result_screen extends StatelessWidget {
  const result_screen({super.key});

  @override
  Widget build(BuildContext context) {
    const message = Text('クリアおめでとう');
    final appBar = AppBar(
      backgroundColor: Colors.red,
      title: const Text('リザルト'),
    );
    return Scaffold(
      appBar: appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            message,
              ],
            ),
        ),
    );
  }
}
