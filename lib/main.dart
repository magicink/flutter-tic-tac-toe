import 'package:flutter/material.dart';
import 'package:tic_tac_toe/GameBoard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: GameBoard(),
    );
  }
}
