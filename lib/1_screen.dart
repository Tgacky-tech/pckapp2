import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class screen1 extends StatelessWidget {
  const screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
              child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AspectRatio(
                    aspectRatio: 27 / 2,
                    child: Container(
                      color: Colors.blue,
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 27 / 46,
                    child: Container(
                      child: SvgPicture.asset(
                        'images/メール.svg'
                    ),
                  ),
                  ),
                  AspectRatio(
                    aspectRatio: 27 / 4,
                    child: Container(
                      color: Colors.blue,
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
