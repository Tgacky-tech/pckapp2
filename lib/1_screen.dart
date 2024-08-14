import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen1 extends StatelessWidget {
  const screen1({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('メール'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}
