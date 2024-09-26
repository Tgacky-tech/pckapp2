import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'rule_screen.dart';
import 'collection_screen.dart';
import 'ranking_screen.dart';
import 'settings_screen.dart';

void main(){
  runApp(home_screen());
}
final pageIndexProvider = StateProvider<int>((ref) => 0);
class home_screen extends ConsumerWidget {
  const home_screen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pageIndex = ref.watch(pageIndexProvider);
    final pageController = PageController(initialPage: pageIndex);
    final appBar = AppBar(
      backgroundColor: Colors.white,
      title: const Text('iLiteracy'),
    );
    final pushButton1 = ElevatedButton(
        onPressed: () => context.push('/rule'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
        child: const Text('ゲーム')
    );
    final pushButton2 = ElevatedButton(
        onPressed: () => context.push('/ranking'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow),
        child: const Text('ランキング'),
    );
    final pushButton3 = ElevatedButton(
        onPressed: () => context.push('/collection'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
        child: const Text('コレクション'),
    );
    final pushButton4 = ElevatedButton(
        onPressed: () => context.push('/settings'),
        style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
        child: const Text('設定'),
    );
    final pages = [
      rule_screen(),
      collection_screen(),
      ranking_screen(),
      settings_screen(),
    ];
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          ref.read(pageIndexProvider.notifier).state = index;
        },
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[800], // 背景色を灰色に設定
        selectedItemColor: Colors.black, // 選択されたアイテムの色を白に設定
        unselectedItemColor: Colors.grey[600], // 未選択のアイテムの色を淡い灰色に設定
        currentIndex: pageIndex,
        onTap: (index) {
          ref.read(pageIndexProvider.notifier).state = index;
          pageController.jumpToPage(index);
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.videogame_asset),
            label: 'ゲーム',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.collections),
            label: 'コレクション',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'ランキング',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '設定',
          ),
        ],
      ),
    );
  }
}

