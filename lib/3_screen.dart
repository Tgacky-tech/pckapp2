import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class screen3 extends ConsumerWidget {
  const screen3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final level = ref.watch(levelProvider);
    final pushButton6 = TextButton(
      onPressed: (){
        stopwatchNotifier.stop();
        context.push('/menu');
      },

      child: const Text('◁',
        style: TextStyle(
          fontSize: 25/*サイズ*/,
        ),),
    );

    final pushButton7 = TextButton(
      onPressed: () {
        context.push('/00');
      },
      child: const Text('〇',
        style: TextStyle(
            fontSize: 20),),
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
                  color: Color(0xFF636363),
                  child: Text(
                    "0"+"$level"+":00",
                    // 'Elapsed Time: ${stopwatchNotifier.formattedElapsedTime}',
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
                  child: SvgPicture.asset(
                      'images/newsscreen.svg'
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
