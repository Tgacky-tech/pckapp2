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
import 'package:pckapp2/menu_screen.dart';
import 'package:pckapp2/result_screen.dart';
import 'package:pckapp2/task_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pckapp2/providers/stopwatch_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:pckapp2/services/user_services.dart';

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
      builder: (context, state) => collection_screen(),
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
    final userService = UserService();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await userService.createUserIfNotExists();
    });
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}