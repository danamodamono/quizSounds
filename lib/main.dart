import 'package:flutter/material.dart';
import 'package:honmadekka/screens/home_screen.dart';
import 'package:honmadekka/style.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'クイズ効果音',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          brightness: Brightness.dark,
          fontFamily: BoldFont,
      ),
      home: HomeScreen(),
    );
  }
}
