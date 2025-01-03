import 'package:flutter/material.dart';
import 'package:pckapp2/home_screen.dart';
import 'package:pckapp2/collection_screen.dart';
import 'package:pckapp2/ranking_screen.dart';
import 'package:pckapp2/rule_screen.dart';
import 'package:pckapp2/settings_screen.dart';
import 'package:pckapp2/0-0_screen.dart';
import 'package:pckapp2/1_screen.dart';
import 'package:pckapp2/2_screen.dart';
import 'package:pckapp2/3_screen.dart';
import 'package:pckapp2/4_screen.dart';
import 'package:pckapp2/5_screen.dart';
import 'package:pckapp2/6_screen.dart';
import 'package:pckapp2/7_screen.dart';
import 'package:pckapp2/8_screen.dart';
import 'package:pckapp2/9_screen.dart';
import 'package:pckapp2/10_screen.dart';
import 'package:pckapp2/11_screen.dart';
import 'package:pckapp2/12_screen.dart';
import 'package:pckapp2/menu_screen.dart';
import 'package:pckapp2/result_screen.dart';
import 'package:pckapp2/task_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:pckapp2/tutorialEnd_screen.dart';
import 'package:pckapp2/tutorialStart_screen.dart';
import 'package:pckapp2/tutorial_1_screen.dart';
import 'package:pckapp2/tutorial_2_screen.dart';
import 'package:pckapp2/tutorial_3_screen.dart';
import 'package:pckapp2/tutorial_4_screen.dart';
import 'package:pckapp2/tutorial_screen.dart';
import 'package:pckapp2/tutorialError_screen.dart';
import 'package:pckapp2/tutorialTask_screen.dart';
import 'firebase_options.dart';
import 'package:pckapp2/services/user_services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    ProviderScope(
        child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {

  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => home_screen(),
      ),
      GoRoute(
        path: '/ranking',
        builder: (context, state) => ranking_screen(),
      ),
      GoRoute(
        path: '/collection',
        builder: (context, state) => CollectionScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => settings_screen(),
      ),
      GoRoute(
        path: '/rule',
        builder: (context, state) => rule_screen(),
      ),
      GoRoute(
        path: '/tutorial',
        builder: (context, state) => tutorial_screen(),
      ),
      GoRoute(
        path: '/tutorialError',
        builder: (context, state) => tutorialError_screen(),
      ),
      GoRoute(
        path: '/tutorialTask',
        builder: (context, state) => TutorialTaskScreen(),
      ),
      GoRoute(
        path: '/tutorial1',
        builder: (context, state) => tutorialScreen1(),
      ),
      GoRoute(
        path: '/tutorial2',
        builder: (context, state) => tutorialScreen2(),
      ),
      GoRoute(
        path: '/tutorial3',
        builder: (context, state) => tutorialScreen3(),
      ),
      GoRoute(
        path: '/tutorial4',
        builder: (context, state) => tutorialScreen4(),
      ),
      GoRoute(
        path: '/tutorialStart',
        builder: (context, state) => tutorialStartScreen(),
      ),
      GoRoute(
        path: '/tutorialEnd',
        builder: (context, state) => tutorialEndScreen(),
      ),
      GoRoute(
        path: '/00',
        builder: (context, state) => Screen00(),
      ),
      GoRoute(
        path: '/1',
        builder: (context, state) => screen1(),
      ),
      GoRoute(
        path: '/2',
        builder: (context, state) => screen2(),
      ),
      GoRoute(
        path: '/3',
        builder: (context, state) => screen3(),
      ),
      GoRoute(
        path: '/4',
        builder: (context, state) => screen4(),
      ),
      GoRoute(
        path: '/5',
        builder: (context, state) => screen5(),
      ),
      GoRoute(
        path: '/6',
        builder: (context, state) => screen6(),
      ),
      GoRoute(
        path: '/7',
        builder: (context, state) => screen7(),
      ),
      GoRoute(
        path: '/8',
        builder: (context, state) => screen8(),
      ),
      GoRoute(
        path: '/9',
        builder: (context, state) => screen9(),
      ),
      GoRoute(
        path: '/10',
        builder: (context, state) => screen10(),
      ),
      GoRoute(
        path: '/11',
        builder: (context, state) => screen11(),
      ),
      GoRoute(
        path: '/12',
        builder: (context, state) => screen12(),
      ),
      GoRoute(
        path: '/menu',
        builder: (context, state) => menu_screen(),
      ),
      GoRoute(
        path: '/result',
        builder: (context, state) => result_screen(),
      ),
      GoRoute(
        path: '/task',
        builder: (context, state) => task_screen(),
      ),
    ],
  );

  @override
  void initState(){
    //アプリ起動時に一度だけ実行される

  }

  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      locale: const Locale('ja', 'JP'), // デフォルトを日本語に設定
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'), // 日本語
        Locale('en', 'US'), // 必要に応じて他の言語も追加
      ],
    );
  }
}