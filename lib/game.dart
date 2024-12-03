import 'package:flutter/src/painting/text_style.dart';
import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mini_games/buah.dart';
import 'package:mini_games/player.dart';
import 'package:flutter/material.dart'; 
import 'constant.dart';
import 'package:mini_games/mainmenu.dart'; 

class CatchGame extends FlameGame with HasCollisionDetection {
  SpriteComponent bg = SpriteComponent();
  int score = 0;
  int life = 3; 
  int missedFruits = 0; 
  Player player = Player();
  late TextComponent scoreText;
  late List<SpriteComponent> lifeIcons; 
  late BuildContext context; 

  CatchGame(this.context); 

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    FlameAudio.bgm.initialize();
    FlameAudio.bgm.play('Game.mp3', volume: 0.5);

    bg..sprite = await loadSprite(Global.bg)..size = size;
    add(bg);
    add(Buah());
    add(player);

    scoreText = TextComponent(
      text: 'Score: $score',
      position: Vector2(20, 50),
      anchor: Anchor.topLeft,
      textRenderer: TextPaint(style: TextStyle(color: BasicPalette.black.color, fontSize: 30)),
    );
    add(scoreText);

    // Menambahkan gambar life di kanan atas
    lifeIcons = [];
    for (int i = 0; i < life; i++) {
      lifeIcons.add(
        SpriteComponent()
          ..sprite = await loadSprite(Global.lifeImg) 
          ..size = Vector2(30, 30)
          ..position = Vector2(size.x - (i + 1) * 40, 50), 
      );
      add(lifeIcons[i]);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';

    // Jika nyawa habis, tampilkan pesan Game Over dan kembali ke MainMenu
    if (life <= 0) {
      FlameAudio.bgm.stop();

      // Menampilkan pesan Game Over di tengah
      var gameOverText = TextComponent(
        text: 'Game Over',
        position: Vector2(size.x / 2 - 100, size.y / 2 - 50), // Menempatkan Game Over di tengah
        textRenderer: TextPaint(style: TextStyle(color: Colors.red, fontSize: 40)),
      );
      add(gameOverText);

      // Menampilkan score akhir di bawah Game Over, sejajar dengan Game Over
      var finalScoreText = TextComponent(
        text: 'Final Score: $score',
        position: Vector2(size.x / 2 - 100, size.y / 2 + 10), // Posisi di bawah Game Over
        textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 30)),
      );
      add(finalScoreText);

      // Navigasi kembali ke MainMenu
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
        );
      });
    }
  }

  // Fungsi untuk mengurangi nyawa
  void reduceLife() {
    if (life > 0) {
      life--;
      missedFruits++; 

      if (missedFruits <= 3 && lifeIcons.isNotEmpty) {
        // Menghapus life terakhir
        lifeIcons.last.removeFromParent();
        lifeIcons.removeLast(); 
      }

      if (missedFruits >= 3) {
        life = 0; // Game Over jika 3 buah terlewat
      }
    }

    // Jika nyawa habis, tampilkan pesan Game Over
    if (life <= 0) {
      FlameAudio.bgm.stop();

      // Menampilkan pesan Game Over di tengah
      var gameOverText = TextComponent(
        text: 'Game Over',
        position: Vector2(size.x / 2 - 100, size.y / 2 - 50), // Menempatkan Game Over di tengah
        textRenderer: TextPaint(style: TextStyle(color: Colors.red, fontSize: 40)),
      );
      add(gameOverText);

      // Menampilkan score akhir di bawah Game Over, sejajar dengan Game Over
      var finalScoreText = TextComponent(
        text: 'Final Score: $score',
        position: Vector2(size.x / 2 - 100, size.y / 2 + 10), // Posisi di bawah Game Over
        textRenderer: TextPaint(style: TextStyle(color: Colors.white, fontSize: 30)),
      );
      add(finalScoreText);

      // Navigasi kembali ke MainMenu
      Future.delayed(Duration(seconds: 5), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainMenu()),
        );
      });
    }
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
