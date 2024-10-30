import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class tutorialEndScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
          pages: pages,
          showBullets: true,
          skipCallback: () {
            context.go('/home');
          },
          finishCallback: () {
            context.go('/home');
          }
      ),
    );
  }
  final pages = [
    PageModel(
      color: Colors.blue.shade300,
      imageAssetPath: 'images/icon.png',
      title: 'チュートリアルは\n以上です',
      body: '',
    ),

  ];
}