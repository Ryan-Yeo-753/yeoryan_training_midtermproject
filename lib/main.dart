import 'dart:core';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:toggle_switch/toggle_switch.dart';

import 'dashboard.dart';
import 'login.dart';

void main() {
  runApp(ProviderScope(child: Bank()));
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return Home();
      },
      routes: [
        GoRoute(
          path: 'bank',
          builder: (BuildContext context, GoRouterState state) {
            return Home();
          }
        ),
        GoRoute(
          path: 'create_account',
          builder: (BuildContext context, GoRouterState state) {
            return CreateAccount();
          },
        ),
        GoRoute(
          path: 'login',
          builder: (BuildContext context, GoRouterState state) {
            return LogIn();
          },
        ),
        GoRoute(
          path: 'dashboard',
          builder: (BuildContext context, GoRouterState state) {
            return Dashboard();
          },
        ),
      ],
    ),
  ],
);

class Bank extends StatelessWidget {
  const Bank({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: ThemeData.light(useMaterial3: true),
      dark: ThemeData.dark(useMaterial3: true),
      initial: AdaptiveThemeMode.light,
      builder: (theme, darkTheme) => MaterialApp.router(
        darkTheme: darkTheme,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xfff0dada)),
        ),
        routerConfig: _router,
      )
    );
  }
}

class Home extends StatefulWidget {

  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          ToggleSwitch(
            totalSwitches: 2,
            activeBgColors: [[Colors.white], [Colors.black]],
            activeFgColor: Colors.pinkAccent,
            inactiveBgColor: Colors.grey,
            inactiveFgColor: Colors.blueGrey,
            labels: const ['Light', 'Dark'],
            initialLabelIndex: 0,
            onToggle: (index) {
              index == 0 ?
              AdaptiveTheme.of(context).setLight() :
              AdaptiveTheme.of(context).setDark();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.red,
                border: Border.all(color: Colors.black, width: 4),
              ),
              width: 450,
              height: 100,
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      'Welcome to the bank!',
                      style: TextStyle(
                        fontWeight: (FontWeight.bold),
                        fontSize: 35,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 50),
            ElevatedButton(
              onPressed: () => context.push('/login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.all(20),
                fixedSize: Size(250, 50),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                side: BorderSide(color: Colors.black, width: 2),
                shape: StadiumBorder(),
              ),
              child: Text('Log In'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => context.push('/create_account'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.black,
                backgroundColor: Colors.redAccent,
                padding: EdgeInsets.all(20),
                fixedSize: Size(250, 50),
                textStyle: TextStyle(fontWeight: FontWeight.bold),
                side: BorderSide(color: Colors.black, width: 2),
                shape: StadiumBorder(),
              ),
              child: Text('Create an Account'),
            ),
          ],
        ),
      ),
    );
  }
}