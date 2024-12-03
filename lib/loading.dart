import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mini_games/mainmenu.dart';

class LoadingScreen extends StatelessWidget {
  void _navigateToMainMenu(BuildContext context) {
    Timer(Duration(seconds: 8), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainMenu()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _navigateToMainMenu(context);

    return Scaffold(
      backgroundColor: Colors.white, 
      body: Center(
        child: Image.asset(
          'assets/images/loading.gif', 
          width: 200, 
          height: 200, 
        ),
      ),
    );
  }
}
