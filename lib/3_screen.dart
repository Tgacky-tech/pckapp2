import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen3 extends StatelessWidget {
  const screen3({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('ブラウザ'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}
