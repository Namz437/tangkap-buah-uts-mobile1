import 'dart:async';
import 'dart:math';

import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:mini_games/game.dart';
import 'package:mini_games/player.dart';

import 'constant.dart';

class Buah extends SpriteComponent
    with HasGameRef<CatchGame>, CollisionCallbacks {
  double speed = 350;
  Random random = Random();
  bool isCaught = false; // Menandakan apakah buah sudah tertangkap

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    Sprite apple = await gameRef.loadSprite(Global.appleImg);
    Sprite pear = await gameRef.loadSprite(Global.pearImg);
    Sprite cherry = await gameRef.loadSprite(Global.cherryImg);
    Sprite anggur = await gameRef.loadSprite(Global.anggurImg);
    Sprite banana = await gameRef.loadSprite(Global.bananaImg);
    Sprite jeruk = await gameRef.loadSprite(Global.jerukImg);
    Sprite mangga = await gameRef.loadSprite(Global.manggaImg);
    Sprite melon = await gameRef.loadSprite(Global.melonImg);
    Sprite nanas = await gameRef.loadSprite(Global.nanasImg);
    Sprite semangka = await gameRef.loadSprite(Global.semangkaImg);
    Sprite stroberi = await gameRef.loadSprite(Global.stroberiImg);

    List<Sprite> listBuah = [
      apple,
      pear,
      cherry,
      anggur,
      banana,
      jeruk,
      mangga,
      melon,
      nanas,
      semangka,
      stroberi
    ];
    sprite = listBuah[random.nextInt(listBuah.length)];
    width = 50;
    height = 50;
    position.x = random.nextInt((gameRef.size.x - 50).toInt()).toDouble();
    position.y = 10;
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Pastikan tidak ada update jika game sudah berakhir
    if ((gameRef as CatchGame).life <= 0) {
      return; // Jangan update buah jika game sudah berakhir
    }

    position.y += speed * dt;

    // Jika buah jatuh ke bawah tanpa tertangkap, kurangi nyawa
    if (position.y > gameRef.size.y && !isCaught) {
      FlameAudio.play('uh.mp3'); // Memutar suara 'uh.mp3' saat buah jatuh
      (gameRef as CatchGame).reduceLife(); // Panggil fungsi reduceLife untuk mengurangi nyawa
      removeFromParent(); // Hapus buah yang jatuh
      gameRef.add(Buah()); // Tambahkan buah baru
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);

    if (other is Player && !isCaught) {
      gameRef.score += 10; // Menambah skor ketika buah tertangkap
      FlameAudio.play('Catch.mp3');
      isCaught = true; // Menandakan buah sudah tertangkap
      position.y = gameRef.size.y + 20; // Menyembunyikan buah yang tertangkap di bawah layar
      gameRef.add(Buah()); // Menambahkan buah baru setelah tertangkap
    }
  }
}