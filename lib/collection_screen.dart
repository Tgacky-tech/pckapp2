import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MaterialApp(
    home: collection_screen(),
  ));
}

class collection_screen extends StatelessWidget {
  const collection_screen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.blue,
      title: const Text('コレクション'),
    );
    return Scaffold(
      appBar: appBar,
    );
  }
}