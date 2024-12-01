import 'dart:ui';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/palette.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mini_games/buah.dart';
import 'package:mini_games/player.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'constant.dart';

class CatchGame extends FlameGame with HasCollisionDetection {
  SpriteComponent bg = SpriteComponent();
  int score = 0;
  int life = 3; // Nyawa
  int missedFruits = 0; // Menghitung buah yang terlewat
  Player player = Player();  late TextComponent scoreText;
  late List<SpriteComponent> lifeIcons; // Daftar ikon nyawa

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
          ..sprite = await loadSprite(Global.lifeImg) // Gambar ikon life
          ..size = Vector2(30, 30)
          ..position = Vector2(size.x - (i + 1) * 40, 50), // Posisi di kanan atas
      );
      add(lifeIcons[i]);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);
    scoreText.text = 'Score: $score';

    // Jika nyawa habis, tampilkan pesan Game Over
    if (life <= 0) {
      FlameAudio.bgm.stop();
      add(TextComponent(
          text: 'Game Over', position: Vector2(size.x / 2 - 50, size.y / 2)));
    }
  }

  // Fungsi untuk mengurangi nyawa
  void reduceLife() {
    if (life > 0) {
      life--;
      missedFruits++; // Menambah jumlah buah yang terlewat

      if (missedFruits <= 3 && lifeIcons.isNotEmpty) {
        // Menghapus life terakhir
        lifeIcons.last.removeFromParent();
        lifeIcons.removeLast(); // Hapus ikon life terakhir dari daftar
      }

      if (missedFruits >= 3) {
        life = 0; // Game Over jika 3 buah terlewat
      }
    }

    // Jika nyawa habis, tampilkan pesan Game Over
    if (life <= 0) {
      FlameAudio.bgm.stop();
      add(TextComponent(
          text: 'Game Over', position: Vector2(size.x / 2 - 50, size.y / 2)));
    }
  }
  

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }
}
