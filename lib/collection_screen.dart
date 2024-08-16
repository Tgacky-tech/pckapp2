import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math' as math;

void main() {
  runApp(MaterialApp(
    home: collection_screen(),
  ));
}

class collection_screen extends StatefulWidget {
  const collection_screen({
    Key? key,
  }) : super(key: key);
  @override
  _collection_screenState createState() => _collection_screenState();
}

class _collection_screenState extends State<collection_screen> {
  int _columnsCount = 2;
  final ScrollController _scrollController = ScrollController();
}

@override
void dispose() {
  _scrollController.dispose();
  super.dispose();
}

@override
Widget build(BuildContext context) {
  final appBar = AppBar(
    backgroundColor: Colors.blue,
    title: const Text('コレクション'),
  );
  return Scaffold(
    appBar: appBar(),
    floatingActionButton: Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FloatingActionButton(
          heroTag: 'grid_change',
          onPressed: () {
            if (_columnsCount = 2) {
              setState(() {
                _columnsCount++;
              });
            }
            else {
              setState(() {
                _columnsCount--;
              });
            }
          },
          child: const Icon(
            Icons.grid_change,
            color: Colors.white,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        FloatingActionButton(
          heroTag: 'arrow_upward',
          onPressed: () {
            _scrollController.animateTo(
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
    body: collection_screen.builder(
        controller: _scrollController,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: _columnsCount,
          CrossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => Container(
            color: Color(0xFF000000),// ここにぼかし具合を追加
            child: Text(
                index.toString(),
                style: TextStyle(
                    fontSize: 42,
                    color: Color(0xFFFFFFFF)
                )
            )
        )
    ),
  );
}
}

