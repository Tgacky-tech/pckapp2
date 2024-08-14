import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen5 extends StatelessWidget {
  const screen5({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('バッテリー'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}