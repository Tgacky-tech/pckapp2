import 'package:flutter/material.dart';
import 'package:pckapp2/home_screen.dart';
import 'package:pckapp2/collection_screen.dart';
import 'package:pckapp2/ranking_screen.dart';
import 'package:pckapp2/rule_screen.dart';
import 'package:pckapp2/settings_screen.dart';
import 'package:pckapp2/0-1_screen.dart';
import 'package:pckapp2/0-2_screen.dart';
import 'package:pckapp2/0-3_screen.dart';
import 'package:pckapp2/1_screen.dart';
import 'package:pckapp2/2_screen.dart';
import 'package:pckapp2/3_screen.dart';
import 'package:pckapp2/4_screen.dart';
import 'package:pckapp2/5_screen.dart';
import 'package:pckapp2/menu_screen.dart';
import 'package:pckapp2/result_screen.dart';
import 'package:go_router/go_router.dart';

void main(){
  runApp(iLiteracy());
}

class iLiteracy extends StatelessWidget {
  iLiteracy({super.key});

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
          path: '/01',
          builder: (context, state) => screen01(),
        ),
        GoRoute(
          path: '/02',
          builder: (context, state) => screen02(),
        ),
        GoRoute(
          path: '/03',
          builder: (context, state) => screen03(),
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
      ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
