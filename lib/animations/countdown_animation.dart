import 'package:flutter/material.dart';

class CountdownAnimation extends StatefulWidget {
  final Function onComplete; // アニメーション完了時に呼ばれるコールバック

  const CountdownAnimation({Key? key, required this.onComplete}) : super(key: key);

  @override
  _CountdownAnimationState createState() => _CountdownAnimationState();
}

class _CountdownAnimationState extends State<CountdownAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<int> _countdownAnimation;

  final int _duration = 3; // カウントダウンの秒数
  final int _displayTimePerDigit = 1500; // 各数字の表示時間（ミリ秒）
  final int _startDelay = 500; // START表示までの遅延（ミリ秒）
  final int _animationDelay = 500; // アニメーション開始までの遅延（ミリ秒）

  @override
  void initState() {
    super.initState();

    // 各数字を表示するためのアニメーション時間を設定
    _controller = AnimationController(
      duration: Duration(milliseconds: (_duration * _displayTimePerDigit) + _startDelay),
      vsync: this,
    );

    // アニメーションの各ステップを作成
    _countdownAnimation = IntTween(begin: _duration, end: 0).animate(_controller);

    // アニメーション開始を遅らせる
    Future.delayed(Duration(milliseconds: _animationDelay), () {
      _controller.forward(); // アニメーションを開始
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // START表示までの遅延を追加
        Future.delayed(Duration(milliseconds: _startDelay), () {
          setState(() {
            // アニメーション完了時にコールバックを呼び出す
            widget.onComplete();
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _countdownAnimation,
        builder: (context, child) {
          String displayText;

          // 現在のカウントダウン値に応じて表示するテキストを決定
          if (_countdownAnimation.value > 0) {
            displayText = '${_countdownAnimation.value}';
          } else {
            displayText = "START";
          }

          return Text(
            displayText, // カウントダウンまたはSTARTを表示
            style: TextStyle(fontSize: 100, color: Colors.white), // フォントサイズを大きく
          );
        },
      ),
    );
  }
}
