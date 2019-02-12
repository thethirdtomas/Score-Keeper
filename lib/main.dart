import 'package:flutter/material.dart';
import 'scorekeeper.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Score Keeper',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),

      routes: {
        '/': (context) =>ScoreKeeper()
      },
      initialRoute: '/',
    );
  }
}