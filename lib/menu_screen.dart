import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class menu_screen extends StatelessWidget {
  const menu_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('メニュー'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}