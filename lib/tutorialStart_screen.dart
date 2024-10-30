import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_overboard/flutter_overboard.dart';

class tutorialStartScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: OverBoard(
        pages: pages,
        showBullets: true,
        skipCallback: () {
          context.go('/tutorial');
        },
        finishCallback: () {
          context.go('/tutorial');
        }
      ),
    );
  }
  final pages = [
    PageModel(
      color: Colors.blue.shade300,
      imageAssetPath: 'images/icon.png',
      title: 'チュートリアル',
      body: 'ようこそ\nここではiLiteracyのチュートリアルを表示します',
    ),
    PageModel(
      color: Colors.blue.shade300,
      imageAssetPath: 'images/icon.png',
      title: 'iLiteracy',
      body: 'このゲームはインターネットリテラシーを身に付けることを目的としています',
    ),
    PageModel(
      color: Colors.blue.shade300,
      imageAssetPath: 'images/icon.png',
      title: 'iLiteracy',
      body: '模擬的なスマホ画面の中で配置されたアプリを見て行き\nインターネットリテラシーの観点から危険とみなされる内容を「異変」とします\nこれはそれら「異変」を見極めるゲームです',
    ),
    PageModel(
      color: Colors.green.shade300,
      imageAssetPath: 'images/ゲーム内画面tutorial.png',
      title: '遊び方',
      body: '上の画像がゲームの中の模擬的なスマホ画面です\n①はゲーム内の階層を表します\n「異変」を見極めることができれば階層が一つ進みます\n見極めを誤れば階層が0まで戻ってしまいます',
    ),
    PageModel(
      color: Colors.green.shade300,
      imageAssetPath: 'images/ゲーム内画面tutorial.png',
      title: '遊び方',
      body: '②は配置されたアプリです\nこれらをタップすると各アプリの画面へ行きます\nアプリの中で「異変」の有無を確かめましょう',
    ),
    PageModel(
      color: Colors.green.shade300,
      imageAssetPath: 'images/ゲーム内画面tutorial.png',
      title: '遊び方',
      body: '③のボタンをタップするとメニューに行きます\nタイムの確認やゲーム中断などができます',
    ),
    PageModel(
      color: Colors.green.shade300,
      imageAssetPath: 'images/ゲーム内画面tutorial.png',
      title: '遊び方',
      body: '④のボタンは各アプリの画面から上の画面へ戻る際に押すボタンです',
    ),
    PageModel(
      color: Colors.green.shade300,
      imageAssetPath: 'images/ゲーム内画面tutorial.png',
      title: '遊び方',
      body: 'すべてのアプリを見て異変の有無を判断しましょう\n判断出来たら⑤のボタンを押して判断が正しいか確かめましょう',
    ),
    PageModel(
      color: Colors.orange.shade300,
      imageAssetPath: 'images/タスク管理画面tutorial.png',
      title: 'タスク管理画面',
      body: '上の画像がタスク管理画面です\n先ほどのアプリの中に「異変」があると判断すれば①のようにタスクを上にスワイプして削除しましょう\n「異変」がないと判断すれば②のようにタスクをタップしましょう',
    ),
  ];
}


