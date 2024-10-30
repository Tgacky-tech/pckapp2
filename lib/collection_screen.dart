import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

void main() {
  runApp(MaterialApp(
    home: CollectionScreen(),
  ));
}

class CollectionScreen extends StatefulWidget {
  const CollectionScreen({Key? key}) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
  List<int> unlockedItems = []; // Unlockされた異変のリスト

  @override
  void initState() {
    super.initState();
    _loadUnlockedItems(); // 異変の状態を読み込む
  }

  Future<void> _loadUnlockedItems() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString('unlockedItems');

    if (jsonString != null) {
      List<dynamic> jsonList = json.decode(jsonString);
      unlockedItems = jsonList.map((item) => item as int).toList();
      setState(() {}); // 状態を更新してUIを再描画
    }
  }

  Widget _dialog(String ihenNumber, String description) {
    int number = int.parse(ihenNumber);
    bool isUnlocked = unlockedItems.contains(number);

    return GestureDetector(
      onTap: isUnlocked ? () {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('異変$ihenNumber'),
            content: Text(description),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('閉じる'),
              ),
            ],
          ),
        );
      } : null, // タップ不可にする
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey), // 境界線を追加
          borderRadius: BorderRadius.circular(8.0), // 角を丸くする
        ),
        child: isUnlocked
            ? _imageItem('異変$ihenNumber') // 開放されている異変の画像を表示
            : _lockedItem(), // 未開放の異変用のウィジェットを表示
      ),
    );
  }
  Widget _lockedItem() {
    return Center(
      child: Text(
        '未開放',
        style: TextStyle(
          fontSize: 24,
          color: Colors.red, // 色を赤に設定
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  // 画像アイテムのウィジェット
  Widget _imageItem(String name) {
    var image = "images/$name.svg";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
          color: Colors.grey[700],
          child: Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          height: MediaQuery.of(context).size.width * 0.4,
          child: SvgPicture.asset(image, fit: BoxFit.cover),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 6,
        shadowColor: Colors.grey.withOpacity(0.4),
        title: const Text('コレクション'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'arrow_upward',
        backgroundColor: Colors.blue,
        onPressed: () {
          controller.animateTo(
            0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInQuint,
          );
        },
        child: const Icon(
          Icons.arrow_upward,
          color: Colors.white,
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio: 1.4,
              ),
              itemBuilder: (context, index) {
                return FittedBox(
                  fit: BoxFit.contain,
                  child: Image.asset(
                    'images/grey.png',
                    fit: BoxFit.cover,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GridView.count(
              controller: controller,
              crossAxisCount: 2,
              mainAxisSpacing: 10.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.2,
              children: <Widget>[
                Center(
                  child: Text(
                    'mail',
                    style: TextStyle(
                      fontSize: 50,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.green,
                    ),
                  ),
                ),
                Image.asset('images/nmail.png'),
                _dialog('1', '焦らせるような文面でも、安易にリンクを開いてはいけません。URLを開いてしまうと、ウイルスがインストールされる可能性があります。'),
                _dialog('2', '迷惑メールは安易に開いてはいけません。メールアプリの送信元を拒否する設定を活用しましょう。'),
                // 他の異変も同様に処理...
              ],
            ),
          ),
        ],
      ),
    );
  }
}
