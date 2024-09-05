import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';

class screen3 extends StatelessWidget {
  const screen3({super.key});

  @override
  Widget build(BuildContext context) {
    final pushButton6 = TextButton(
      onPressed: () => context.push('/menu'),
      child: const Text('◁',
        style: TextStyle(
          fontSize: 25/*サイズ*/,
        ),),
    );
    final pushButton7 = TextButton(
      onPressed: (){
        Navigator.of(context).pop();
      },
      child: const Text('〇'),
    );
    final pushButton9 = TextButton(
      onPressed: () => context.push('/task'),
      child: const Text('□',
        style: TextStyle(
            fontSize: 25),),
    );
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
                      'images/newscreen.svg'
                  ),
                ),
              ),
              AspectRatio(
                aspectRatio: 27 / 4,
                child: Container(
                  color: Colors.blue,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      pushButton6,
                      pushButton7,
                      // pushButton8,
                      pushButton9,
                    ],
                  ),
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
