import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(
    home: rule_screen(),
  ));
}

class rule_screen extends StatelessWidget {
  const rule_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('ルール説明'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}