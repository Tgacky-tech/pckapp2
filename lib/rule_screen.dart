import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/level_provider.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:pckapp2/providers/error_provider.dart';
import 'package:pckapp2/providers/counterList_provider.dart';
import 'package:pckapp2/providers/tutorial_provider.dart';
import 'package:pckapp2/providers/difficulty_provider.dart';
import 'dart:math' as math;
import 'dart:ui' as ui;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pckapp2/services/user_services.dart';
import 'dart:async';

void main() {
  runApp(MaterialApp(
    home: rule_screen(),
  ));
}
class InfoButton extends StatelessWidget {
  void _showInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(Icons.info, color: Colors.black),
              SizedBox(width: 8),
              Text('Information'),
            ],
          ),
          content: Text('ハードモードは異変なし画面の種類が増え、異変の種類も通常より多いゲームモードです。'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('閉じる'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.info,
        size: 30,
        color: Colors.white,
      ),
      onPressed: () {
        _showInfoDialog(context);
      },
    );
  }
}
class CustomButton extends StatefulWidget {
  const CustomButton({Key? key}) : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラの設定
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // アニメーションの周期
    )
      ..repeat(reverse: true); // アニメーションを繰り返し、逆方向にも戻る設定

    // タイマーを使って定期的に再描画をトリガー
    _timer = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {}); // 再描画
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.9, // 横幅90%
      child: AspectRatio(
        aspectRatio: 7 / 5, // 縦横比5:7
        child: Stack(
          children: [
            // 画像を背景に表示（CustomPaintの前に描画）

            // グラデーションを描画（画像の上に描画）
            CustomPaint(
              painter: CustomButtonPainter(progress: _controller.value),
              child: Container(), // グラデーション用のコンテナ
            ),
            Align(
              alignment: Alignment(0.7, 0),
              child: Transform.rotate(
                angle: 0.2,// 右寄せ
              child: Container(
                height: MediaQuery.of(context).size.width * 0.9 * 0.8 * 5 / 7, // 親の高さの80%に設定
                child: SvgPicture.asset(
                  'images/main.svg',
                  fit: BoxFit.fitHeight, // 高さを親の80%に合わせる
                ),
              ),
              ),
            ),
            // 「ゲームをプレイ」のテキストをグラデーション範囲外の下に配置
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 0.05, // 下部に余白を追加
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0), // 左側に余白を追加
                child: Text(
                  'ゲームをプレイ',
                  style: TextStyle(
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.05, // 横幅の5%をフォントサイズに設定
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
      Positioned(
        top: MediaQuery.of(context).size.width * 0.05, // 上端からの余白
        left: MediaQuery.of(context).size.width * 0.05, // 左端からの余白
        child: Icon(
          Icons.videogame_asset, // アイコンを変更
          size: MediaQuery.of(context).size.width * 0.35, // アイコンのサイズ
          color: Colors.white, // アイコンの色
        ),
      ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonPainter extends CustomPainter {
  final double progress;

  CustomButtonPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // 背景用の白色ペイント
    final Paint backgroundPaint = Paint()..color = Colors.white;

    // 影用のペイント
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withOpacity(0.2) // 影の色（透明度を指定）
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // 影をぼかす

    // グラデーション用のペイント
    final Paint gradientPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height * 0.6),
        [
          Color.lerp(Colors.blue[50], Colors.blue[400], progress)!, // 薄い青から濃い青
          Color.lerp(Colors.blue[300], Colors.blue[100], progress)!, // 明るめの青
        ],
      );

    // ボタン全体の境界線（角丸）
    final Path buttonPath = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(20), // 角を丸く
      ));

    // グラデーション部分のパス（上は丸角、下は四角）
    final Path gradientPath = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.75),
        topLeft: Radius.circular(20),    // 上左角を丸く
        topRight: Radius.circular(20),   // 上右角を丸く
        bottomLeft: Radius.zero,         // 下左角を直角
        bottomRight: Radius.zero,        // 下右角を直角
      ));

    // 影を描画
    canvas.save();
    canvas.translate(5, 5); // 影を右下にオフセット
    canvas.drawPath(buttonPath, shadowPaint);
    canvas.restore();

    // 背景を白色で描画
    canvas.drawPath(buttonPath, backgroundPaint);

    // グラデーション部分の描画
    canvas.save();
    canvas.clipPath(gradientPath); // グラデーション部分だけをクリップ
    canvas.drawPath(gradientPath, gradientPaint); // グラデーション描画
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomButtonPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

class CustomButton2 extends StatefulWidget {
  const CustomButton2({Key? key}) : super(key: key);

  @override
  _CustomButtonState2 createState() => _CustomButtonState2();
}

class _CustomButtonState2 extends State<CustomButton2> with SingleTickerProviderStateMixin {
  late AnimationController _controller2;
  late Timer _timer2;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラの設定
    _controller2 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // アニメーションの周期
    )
      ..repeat(reverse: true); // アニメーションを繰り返し、逆方向にも戻る設定

    // タイマーを使って定期的に再描画をトリガー
    _timer2 = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {}); // 再描画
    });
  }

  @override
  void dispose() {
    _controller2.dispose();
    _timer2.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.425, // 横幅90%
      child: AspectRatio(
        aspectRatio: 7 / 5, // 縦横比5:7
        child: Stack(
          children: [
            // 画像を背景に表示（CustomPaintの前に描画）

            // グラデーションを描画（画像の上に描画）
            CustomPaint(
              painter: CustomButtonPainter2(progress: _controller2.value),
              child: Container(), // グラデーション用のコンテナ
            ),
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 0.025, // 下部に余白を追加
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0), // 左側に余白を追加
                child: Text(
                  'チュートリアル',
                  style: TextStyle(
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03, // 横幅の5%をフォントサイズに設定
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.03, // 上端からの余白
              left: MediaQuery.of(context).size.width * 0.03, // 左端からの余白
              child: Icon(
                  Icons.lightbulb, // アイコンを変更
                size: MediaQuery.of(context).size.width * 0.2, // アイコンのサイズ
                color: Colors.white, // アイコンの色
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonPainter2 extends CustomPainter {
  final double progress;

  CustomButtonPainter2({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // 背景用の白色ペイント
    final Paint backgroundPaint2 = Paint()..color = Colors.white;

    // 影用のペイント
    final Paint shadowPaint2 = Paint()
      ..color = Colors.black.withOpacity(0.2) // 影の色（透明度を指定）
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // 影をぼかす

    // グラデーション用のペイント
    final Paint gradientPaint2 = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height * 0.6),
        [
          Color.lerp(Colors.green[50], Colors.green[400], progress)!, // 薄い青から濃い青
          Color.lerp(Colors.green[300], Colors.green[100], progress)!, // 明るめの青
        ],
      );

    // ボタン全体の境界線（角丸）
    final Path buttonPath2 = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(20), // 角を丸く
      ));

    // グラデーション部分のパス（上は丸角、下は四角）
    final Path gradientPath2 = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.75),
        topLeft: Radius.circular(20),    // 上左角を丸く
        topRight: Radius.circular(20),   // 上右角を丸く
        bottomLeft: Radius.zero,         // 下左角を直角
        bottomRight: Radius.zero,        // 下右角を直角
      ));

    // 影を描画
    canvas.save();
    canvas.translate(5, 5); // 影を右下にオフセット
    canvas.drawPath(buttonPath2, shadowPaint2);
    canvas.restore();

    // 背景を白色で描画
    canvas.drawPath(buttonPath2, backgroundPaint2);

    // グラデーション部分の描画
    canvas.save();
    canvas.clipPath(gradientPath2); // グラデーション部分だけをクリップ
    canvas.drawPath(gradientPath2, gradientPaint2); // グラデーション描画
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomButtonPainter2 oldDelegate) =>
      oldDelegate.progress != progress;
}
class CustomButton3 extends StatefulWidget {
  const CustomButton3({Key? key}) : super(key: key);

  @override
  _CustomButtonState3 createState() => _CustomButtonState3();
}

class _CustomButtonState3 extends State<CustomButton3> with SingleTickerProviderStateMixin {
  late AnimationController _controller3;
  late Timer _timer3;

  @override
  void initState() {
    super.initState();

    // アニメーションコントローラの設定
    _controller3 = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3), // アニメーションの周期
    )
      ..repeat(reverse: true); // アニメーションを繰り返し、逆方向にも戻る設定

    // タイマーを使って定期的に再描画をトリガー
    _timer3 = Timer.periodic(const Duration(milliseconds: 16), (timer) {
      setState(() {}); // 再描画
    });
  }

  @override
  void dispose() {
    _controller3.dispose();
    _timer3.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery
          .of(context)
          .size
          .width * 0.425, // 横幅90%
      child: AspectRatio(
        aspectRatio: 7 / 5, // 縦横比5:7
        child: Stack(
          children: [
            // 画像を背景に表示（CustomPaintの前に描画）

            // グラデーションを描画（画像の上に描画）
            CustomPaint(
              painter: CustomButtonPainter3(progress: _controller3.value),
              child: Container(), // グラデーション用のコンテナ
            ),
            Positioned(
              bottom: MediaQuery
                  .of(context)
                  .size
                  .width * 0.025, // 下部に余白を追加
              left: 0,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0), // 左側に余白を追加
                child: Text(
                  'ハードモード',
                  style: TextStyle(
                    fontSize: MediaQuery
                        .of(context)
                        .size
                        .width * 0.03, // 横幅の5%をフォントサイズに設定
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.03, // 上端からの余白
              left: MediaQuery.of(context).size.width * 0.03, // 左端からの余白
              child: Icon(
                Icons.dangerous, // アイコンを変更
                size: MediaQuery.of(context).size.width * 0.2, // アイコンのサイズ
                color: Colors.white, // アイコンの色
              ),
            ),
            Positioned(
              top: MediaQuery.of(context).size.width * 0,// 下部に余白を追加
              right: 0,
              child: InfoButton(),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomButtonPainter3 extends CustomPainter {
  final double progress;

  CustomButtonPainter3({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    // 背景用の白色ペイント
    final Paint backgroundPaint3 = Paint()..color = Colors.white;

    // 影用のペイント
    final Paint shadowPaint3 = Paint()
      ..color = Colors.black.withOpacity(0.2) // 影の色（透明度を指定）
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 10); // 影をぼかす

    // グラデーション用のペイント
    final Paint gradientPaint3 = Paint()
      ..shader = ui.Gradient.linear(
        Offset(0, 0),
        Offset(size.width, size.height * 0.6),
        [
          Color.lerp(Colors.red[50], Colors.red[400], progress)!, // 薄い青から濃い青
          Color.lerp(Colors.red[300], Colors.red[100], progress)!, // 明るめの青
        ],
      );

    // ボタン全体の境界線（角丸）
    final Path buttonPath3 = Path()
      ..addRRect(RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        Radius.circular(20), // 角を丸く
      ));

    // グラデーション部分のパス（上は丸角、下は四角）
    final Path gradientPath3 = Path()
      ..addRRect(RRect.fromRectAndCorners(
        Rect.fromLTWH(0, 0, size.width, size.height * 0.75),
        topLeft: Radius.circular(20),    // 上左角を丸く
        topRight: Radius.circular(20),   // 上右角を丸く
        bottomLeft: Radius.zero,         // 下左角を直角
        bottomRight: Radius.zero,        // 下右角を直角
      ));

    // 影を描画
    canvas.save();
    canvas.translate(5, 5); // 影を右下にオフセット
    canvas.drawPath(buttonPath3, shadowPaint3);
    canvas.restore();

    // 背景を白色で描画
    canvas.drawPath(buttonPath3, backgroundPaint3);

    // グラデーション部分の描画
    canvas.save();
    canvas.clipPath(gradientPath3); // グラデーション部分だけをクリップ
    canvas.drawPath(gradientPath3, gradientPaint3); // グラデーション描画
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomButtonPainter3 oldDelegate) =>
      oldDelegate.progress != progress;
}

class rule_screen extends ConsumerWidget {
  const rule_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userService = UserService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      print('snlanjgaejoaegjgae');
      await userService.createUserIfNotExists();
    });
    final stopwatchNotifier = ref.watch(stopwatchProvider.notifier);
    final error = ref.watch(errorProvider);
    var random = math.Random();
    final level = ref.watch(levelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text(
          'ホーム画面',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                AspectRatio(
                  aspectRatio: 3.1 / 1,
                  child: Container(
                    child: SvgPicture.asset('images/firstbackground.svg'),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                 ElevatedButton(
                    child: CustomButton(),
                   style: ElevatedButton.styleFrom(
                     backgroundColor: Colors.transparent, // 背景色を透明にする
                     foregroundColor: Colors.black, // テキストの色を黒にする
                     shadowColor: Colors.transparent, // 影を透明にする
                     side: BorderSide.none, // 枠線をなくす
                     elevation: 0, // 影をなくす
                     padding: EdgeInsets.zero, // パディングをゼロにする
                   ),
                    onPressed: () {
                      ref.read(difficultyProvider.notifier).state = 0;
                      ref.read(levelProvider.notifier).state = 0;
                      ref.read(counterListProvider.notifier).state = [];
                      ref.read(errorProvider.notifier).state = random.nextInt(35) + 1;
                      ref
                          .read(counterListProvider.notifier)
                          .addRandomNumber(ref.read(errorProvider));
                      stopwatchNotifier.reset();
                      stopwatchNotifier.start();
                      context.go('/00');
                    },
                  ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: CustomButton2(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // 背景色を透明にする
                        foregroundColor: Colors.black, // テキストの色を黒にする
                        shadowColor: Colors.transparent, // 影を透明にする
                        side: BorderSide.none, // 枠線をなくす
                        elevation: 0, // 影をなくす
                        padding: EdgeInsets.zero, // パディングをゼロにする
                      ),
                      onPressed: () {
                        ref.read(tutorialProvider.notifier).setTutorial(0);
                        ref.read(levelProvider.notifier).state = 0;
                        context.push('/tutorialStart');
                      },
                    ),
                    ElevatedButton(
                      child: CustomButton3(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent, // 背景色を透明にする
                        foregroundColor: Colors.black, // テキストの色を黒にする
                        shadowColor: Colors.transparent, // 影を透明にする
                        side: BorderSide.none, // 枠線をなくす
                        elevation: 0, // 影をなくす
                        padding: EdgeInsets.zero, // パディングをゼロにする
                      ),
                      onPressed: () {
                        ref.read(levelProvider.notifier).state = 0;
                        ref.read(difficultyProvider.notifier).state = 1;
                        ref.read(counterListProvider.notifier).state = [];
                        ref.read(errorProvider.notifier).state = random.nextInt(67) + 1;
                        ref
                            .read(counterListProvider.notifier)
                            .addRandomNumber(ref.read(errorProvider));
                        stopwatchNotifier.reset();
                        stopwatchNotifier.start();
                        context.go('/00');
                      },
                    ),
                  ],
                ),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.6,
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: <Widget>[
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.7,
                //         height: MediaQuery.of(context).size.height * 0.1,
                //         child: OutlinedButton(
                //           child: FittedBox(
                //             fit: BoxFit.scaleDown,
                //             child: Text(
                //               'チュートリアル',
                //               style: TextStyle(
                //                 fontSize: 36,
                //                 color: Colors.white,
                //                 letterSpacing: 6.0,
                //               ),
                //             ),
                //           ),
                //           style: OutlinedButton.styleFrom(
                //             backgroundColor: Colors.blue,
                //             foregroundColor: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(
                //               color: Colors.blueGrey,
                //               width: 4.5,
                //             ),
                //           ),
                //           onPressed: () {
                //             ref.read(tutorialProvider.notifier).setTutorial(0);
                //             ref.read(levelProvider.notifier).state = 0;
                //             context.push('/tutorialStart');
                //           },
                //         ),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.7,
                //         height: MediaQuery.of(context).size.height * 0.1,
                //         child: OutlinedButton(
                //           child: FittedBox(
                //             fit: BoxFit.scaleDown,
                //             child: Text(
                //               'NORMALモード',
                //               style: TextStyle(
                //                 fontSize: 36,
                //                 color: Colors.white,
                //                 letterSpacing: 6.0,
                //               ),
                //             ),
                //           ),
                //           style: OutlinedButton.styleFrom(
                //             backgroundColor: Colors.blue,
                //             foregroundColor: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(
                //               color: Colors.blueGrey,
                //               width: 4.5,
                //             ),
                //           ),
                //           onPressed: () {
                //             ref.read(difficultyProvider.notifier).state = 0;
                //             ref.read(levelProvider.notifier).state = 0;
                //             ref.read(counterListProvider.notifier).state = [];
                //             ref.read(errorProvider.notifier).state = random.nextInt(35) + 1;
                //             ref
                //                 .read(counterListProvider.notifier)
                //                 .addRandomNumber(ref.read(errorProvider));
                //             stopwatchNotifier.reset();
                //             stopwatchNotifier.start();
                //             context.go('/00');
                //           },
                //         ),
                //       ),
                //       SizedBox(
                //         width: MediaQuery.of(context).size.width * 0.7,
                //         height: MediaQuery.of(context).size.height * 0.1,
                //         child: OutlinedButton(
                //           child: FittedBox(
                //             fit: BoxFit.scaleDown,
                //             child: Text(
                //               'HARDモード',
                //               style: TextStyle(
                //                 fontSize: 36,
                //                 color: Colors.white,
                //                 letterSpacing: 6.0,
                //               ),
                //             ),
                //           ),
                //           style: OutlinedButton.styleFrom(
                //             backgroundColor: Colors.blue,
                //             foregroundColor: Colors.white,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             side: const BorderSide(
                //               color: Colors.blueGrey,
                //               width: 4.5,
                //             ),
                //           ),
                //           onPressed: () {
                //             ref.read(levelProvider.notifier).state = 0;
                //             ref.read(difficultyProvider.notifier).state = 1;
                //             ref.read(counterListProvider.notifier).state = [];
                //             ref.read(errorProvider.notifier).state = random.nextInt(67) + 1;
                //             ref
                //                 .read(counterListProvider.notifier)
                //                 .addRandomNumber(ref.read(errorProvider));
                //             stopwatchNotifier.reset();
                //             stopwatchNotifier.start();
                //             context.go('/00');
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
