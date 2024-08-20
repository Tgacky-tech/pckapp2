import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


class screen00 extends StatelessWidget {
  const screen00({super.key});

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.yellow,
      title: const Text('0:00'),
    );
    final pushButton1 = MaterialButton(
      onPressed: () => context.push('/1'),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/mail.png'),
              fit: BoxFit.cover,
            )),
    ),
    );
    final pushButton2 = MaterialButton(
      onPressed: () => context.push('/2'),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/sns.png'),
              fit: BoxFit.cover,
            )),
      ),
    );
    final pushButton3 = MaterialButton(
      onPressed: () => context.push('/3'),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/browsericon.png'),
              fit: BoxFit.cover,
            )),
      ),
    );
    final pushButton4 = MaterialButton(
      onPressed: () => context.push('/4'),
      child: Container(
        width: 70,
        height: 70,
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/settingsicon.png'),
              fit: BoxFit.cover,
            )),
      ),
    );
    // final pushButton5 = ElevatedButton(
    //   onPressed: () => context.push('/5'),
    //   style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
    //   child: const Text('バッテリー'),
    // );
    final pushButton6 = ElevatedButton(
      onPressed: () => context.push('/menu'),
      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
      child: const Text('メニュー'),
    );
    final pushButton7 = TextButton(
      onPressed: () => context.push('/01'),
      child: const Text('〇'),
    );
    final pushButton8 = TextButton(
      onPressed: () => context.push('/00'),
      child: const Text('✖'),
    );
    return Scaffold(
    body: Center(
    child: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/background.png'),
            fit: BoxFit.cover,
          )),
    child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
    AspectRatio(
    aspectRatio: 27 / 1.5,
    child: Container(
      color: Color(0xFF636363),
      child: Text(
        '00:00',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
    ),
    AspectRatio(
    aspectRatio: 27 / 46,
    child: Container(
      alignment: Alignment.topCenter,
      padding:EdgeInsets.symmetric(vertical: 10,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              pushButton1,
              Text(
                'メール',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              pushButton2,
              Text(
                'sns',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              pushButton3,
              Text(
                'ブラウザー',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              pushButton4,
              Text(
                '設定',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
        // children: <Widget>[
        //   pushButton1,
        //   pushButton2,
        //   pushButton3,
        //   pushButton4,
        //   // pushButton5,
        //
        // ],
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
          pushButton8,
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