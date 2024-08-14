import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class screen4 extends StatelessWidget {
  const screen4({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.grey,
      title: const Text('Wi-Fi'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}