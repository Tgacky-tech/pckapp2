import 'package:flutter/material.dart';

class swipeAnimation extends StatefulWidget {
  @override
  _swipeAnimationState createState() => _swipeAnimationState();
}

class _swipeAnimationState extends State<swipeAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller1;
  late Animation<double> _animation1;

  @override
  void initState() {
    super.initState();
    _controller1 = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation1 = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _controller1, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller1.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation1,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, _animation1.value),
            child: Opacity(
              opacity: 1.0 - (_animation1.value.abs() / 20),
              child: Icon(
                Icons.keyboard_arrow_up,
                size: 50,
                color: Colors.grey,
              ),
            ),
          );
        },
      ),
    );
  }
}