import 'dart:async';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flame/palette.dart';
import 'package:mini_games/game.dart';
import 'package:flutter/material.dart';
import 'constant.dart';

class Player extends SpriteComponent with HasGameRef<CatchGame>, CollisionCallbacks {
  JoystickComponent joystick = JoystickComponent(
    knob: CircleComponent(
      radius: 20,
      paint: BasicPalette.black.withAlpha(200).paint(),
    ),
    background: CircleComponent(
      radius: 50,
      paint: BasicPalette.white.withAlpha(100).paint(),
    ),
    margin: EdgeInsets.only(right: 30, bottom: 60),
  );

  double speed = 400;

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await gameRef.loadSprite(Global.playerImg);
    width = 100;
    height = 60;
    position.x = gameRef.size.x / 2;
    position.y = gameRef.size.y - 100;
    anchor = Anchor.center;
    gameRef.add(joystick);
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);

    // Menggerakkan player sesuai dengan joystick
    position += joystick.relativeDelta * speed * dt;

    // Membatasi posisi pemain agar tidak keluar dari batas layar
    if (position.x < width / 2) {
      position.x = width / 2; // Batas kiri
    } else if (position.x > gameRef.size.x - width / 2) {
      position.x = gameRef.size.x - width / 2; // Batas kanan
    }

    if (position.y < height / 2) {
      position.y = height / 2; // Batas atas
    } else if (position.y > gameRef.size.y - height / 2) {
      position.y = gameRef.size.y - height / 2; // Batas bawah
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
  }
}
