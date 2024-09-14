import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(
    home: CollectionScreen(),
  ));
}

class CollectionScreen extends StatelessWidget {
  const CollectionScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    ScrollController controller = ScrollController();
    return Scaffold(
      appBar: AppBar(
        title: Text('コレクション'),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'arrow_upward',
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
        ],
      ),
      body: GridView.count(
        crossAxisCount: 3,
        mainAxisSpacing: 10.0,
        // 主要軸(縦)の間隔
        crossAxisSpacing: 10.0,
        // 横軸の間隔
        childAspectRatio: 1 / 1,
        // アスペクト比
        children: <Widget>[
          _imageItem("異変1"),
          _imageItem("異変2"),
          _imageItem("異変3"),
          _imageItem("異変4"),
          _imageItem("異変5"),
          _imageItem("異変6"),
          _imageItem("異変7"),
          _imageItem("異変8"),
          _imageItem("異変9"),
          _imageItem("異変10"),
          _imageItem("異変11"),
          _imageItem("異変12"),
          _imageItem("異変13"),
          _imageItem("異変14"),
          _imageItem("異変15"),
          _imageItem("異変16"),
          _imageItem("異変17"),
          _imageItem("異変18"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
          _imageItem("name"),
        ],
      ),
    );
  }

  Widget _imageItem(String name) {
    var image = "images/" + name + ".png";
    return Container(
      child: Image.asset(image, fit: BoxFit.cover,),
    );
  }
}
