import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen2 extends StatelessWidget {
  const screen2({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('SNS'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}
