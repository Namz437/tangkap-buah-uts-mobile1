import 'package:flutter/material.dart';
// import 'package:flame/game.dart';
import 'package:mini_games/mainmenu.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    home: MainMenu(), 
    debugShowCheckedModeBanner: false, 
  ));
}
