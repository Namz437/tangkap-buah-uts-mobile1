import 'package:flutter/material.dart';
import 'package:mini_games/game.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart'; // Untuk menambahkan suara
import 'package:mini_games/rules.dart';

class MainMenu extends StatelessWidget {
  // Fungsi untuk memainkan suara klik
  void _playClickSound() {
    FlameAudio.play('Click.wav'); // Memainkan suara klik
  }

  @override
  Widget build(BuildContext context) {
    // Memainkan suara latar belakang (background music) saat menu muncul
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlameAudio.bgm.play('Menu.mp3');  // Memainkan suara latar
    });

    return Scaffold(
      body: Stack(
        children: [
          // Background menu
          Positioned.fill(
            child: Image.asset(
              'assets/images/menu.jpg', 
              fit: BoxFit.cover,
            ),
          ),
          // Menampilkan GIF dev.gif di atas tombol Start
          Positioned(
            top: 100,  // Posisi di atas tombol
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/images/dev.gif',  // Menampilkan GIF dev
              width: 200,  // Ukuran GIF dev
              height: 200,
            ),
          ),
          // Menampilkan GIF game.gif di bawah dev.gif dengan sedikit jarak
          Positioned(
            top: 180,  // Posisi di bawah dev.gif
            left: 50,
            right: 50,
            child: Image.asset(
              'assets/images/game.gif',  // Menampilkan GIF game
              width: 200,  // Ukuran GIF game
              height: 200,
            ),
          ),
          // Tombol Start dengan gambar
          Positioned(
            bottom: 180,
            left: 50,
            right: 50,
            child: GestureDetector(
              onTap: () {
                _playClickSound(); // Memainkan suara klik
                // Navigasi ke halaman game
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => GameWidget(game: CatchGame())),
                );
              },
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Gambar tombol Start
                  Image.asset('assets/images/start.png', width: 200, height: 80),
                  // Teks di atas gambar tombol
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
          // Menambahkan gambar rules.png di pojok kanan bawah
          Positioned(
            bottom: 20,  // Posisi dari bawah
            right: 20,   // Posisi dari kanan
            child: GestureDetector(
              onTap: () {
                _playClickSound(); // Memainkan suara klik saat mengklik gambar rules
                // Navigasi ke halaman RulesPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RulesPage()),
                );
              },
              child: Image.asset(
                'assets/images/rules.png',
                width: 60,  // Ukuran gambar rules
                height: 60,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
