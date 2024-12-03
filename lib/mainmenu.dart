import 'package:firebase_auth/firebase_auth.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mini_games/game.dart';
import 'package:mini_games/rules.dart';
import 'login.dart'; 

class MainMenu extends StatelessWidget {
  void _playClickSound() {
    FlameAudio.play('Click.wav');
  }

  @override
  Widget build(BuildContext context) {
    // bg menu musik
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlameAudio.bgm.play('Menu.mp3');
    });

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 100,
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/images/dev.gif',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            top: 180,
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/images/game.gif',
              width: 200,
              height: 200,
            ),
          ),
          Positioned(
            bottom: 320,
            left: 50,
            right: 50,
            child: GestureDetector(
              onTap: () {
                _playClickSound();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      body: GameWidget(game: CatchGame(context)),
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/start.png', width: 200, height: 80),
                  Positioned(
                    child: Text(
                      'START GAME',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 220,
            left: 50,
            right: 50,
            child: GestureDetector(
              onTap: () {
                _playClickSound();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Scaffold(
                      appBar: AppBar(title: Text('Top Score')),
                      body: Center(
                        child: Text(
                          'Halaman Top Score belum dibuat.',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset('assets/images/start.png', width: 200, height: 80),
                  Positioned(
                    child: Text(
                      'TOP SCORE',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _playClickSound();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RulesPage()),
                );
              },
              child: Image.asset(
                'assets/images/rules.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
          // Tombol Back di kiri bawah
          Positioned(
            bottom: 20,
            left: 20,
            child: GestureDetector(
              onTap: () async {
                _playClickSound();
                // Trigger logout melalui FirebaseAuth
                await FirebaseAuth.instance.signOut();
                // Setelah logout, matikan musik
                FlameAudio.bgm.stop();
                // Setelah logout, arahkan ke halaman login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()), // Ganti dengan halaman login Anda
                );
              },
              child: Image.asset(
                'assets/images/back.png',
                width: 60,
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
