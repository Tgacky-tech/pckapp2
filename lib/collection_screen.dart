// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'dart:math' as math;
//
// void main() {
//   runApp(MaterialApp(
//     home: CollectionScreen(),
//   ));
// }
//
// class CollectionScreen extends StatefulWidget {
//   const CollectionScreen({
//     Key? key,
//   }) : super(key: key);
//   @override
//   _CollectionScreenState createState() => _CollectionScreenState();
// }
//
// class _CollectionScreenState extends State<CollectionScreen> {
//   final ScrollController _scrollController = ScrollController();
// }
//
// @override
// void initState() {
//   _scrollController.addListener(() {
//     setState(() {});
//   });
//   super.initState();
// }
//
// @override
// void dispose() {
//   _scrollController.dispose();
//   super.dispose();
// }
//
// @override
// Widget build(BuildContext context) {
//   return Scaffold(
//       appBar: AppBar(
//         title: Text('コレクション'),
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: <Widget>[
//           FloatingActionButton(
//             heroTag: 'arrow_upward',
//             onPressed: () {
//               _scrollController.animateTo(
//                 0,
//                 duration: const Duration(milliseconds: 600),
//                 curve: Curves.easeInQuint,
//               );
//             },
//             child: const Icon(
//               Icons.arrow_upward,
//               color: Colors.white,
//             ),
//           ),
//         ],
//       )
//       body: GridView.count(
//       crossAxisCount: 3,
//       mainAxisSpacing: 10.0,  // 主要軸(縦)の間隔
//       crossAxisSpacing: 10.0, // 横軸の間隔
//       childAspectRatio: 1/1,  // アスペクト比
//       children: <Widget>[
//         _imageItem("異変1-1"),
//         _imageItem("異変1-2"),
//         _imageItem("異変1-3"),
//         _imageItem("異変1-4"),
//         _imageItem("異変2-1"),
//         _imageItem("異変2-2"),
//         _imageItem("異変2-3"),
//         _imageItem("異変2-4"),
//         _imageItem("異変2-5"),
//         _imageItem("異変3-1"),
//         _imageItem("異変3-2"),
//         _imageItem("異変3-3"),
//         _imageItem("異変3-4"),
//         _imageItem("異変3-5"),
//         _imageItem("異変4-1"),
//         _imageItem("異変4-2"),
//         _imageItem("異変4-3"),
//         _imageItem("異変4-4"),
//
//       ],
//   ),
//   );
// }
// Widget _imageItem(String name) {
//   var image = "images/ihen/" + name + ".png";
//   return Container(
//     child: Image.asset(image, fit: BoxFit.cover,),
//   );
// }
//
//
//