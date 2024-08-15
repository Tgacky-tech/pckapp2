import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class screen1 extends StatelessWidget {
  const screen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: AspectRatio(
            aspectRatio: 9/ 16,
              child: Container(
                color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // ボタンが押された時の処理
                    },
                    child: Text('メール一覧',
                      style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                    style:TextButton.styleFrom(foregroundColor: Colors.blue),
                  ),
                  Container(
                    width: 100,
                    height: 80,
                    child: SvgPicture.asset(
                      'images/受信.svg',
                      width: 400,
                    )
                  ),
                ],
              ),
          ),
          ),
        ),
      );
  }
}
