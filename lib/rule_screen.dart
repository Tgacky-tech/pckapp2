import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(MaterialApp(
    home: rule_screen(),
  ));
}

class rule_screen extends StatelessWidget {
  const rule_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AspectRatio(
                aspectRatio: 27 / 46,
                child: Container(
                  child: SvgPicture.asset(
                      'images/ゲームの流れ.svg'
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 6,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(),
                      SizedBox(
                        child: ElevatedButton(
                            onPressed: () => context.push('/00'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.yellow,
                              fixedSize: const Size(200, 60)
                            ),
                            child: const Text('スタート')
                        ),
                      ),
                      Container(),
                    ],
                ),
              )
              // TextButton(
            ],
          ),
        ),
      ),
    );
  }
}