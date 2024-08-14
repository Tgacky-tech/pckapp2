import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(
    home: ranking_screen(),
  ));
}

class ranking_screen extends StatelessWidget {
  const ranking_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('ランキング'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}