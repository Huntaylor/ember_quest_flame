import 'dart:ui';

import 'package:ember_quest_flame/actors/ember.dart';
import 'package:ember_quest_flame/actors/water_enemy.dart';
import 'package:ember_quest_flame/managers/segment_manager.dart';
import 'package:ember_quest_flame/objects/ground_block.dart';
import 'package:ember_quest_flame/objects/platfrom_block.dart';
import 'package:ember_quest_flame/objects/star.dart';
import 'package:ember_quest_flame/overlays/hud.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';

class EmberQuestGame extends FlameGame
    with HasCollisionDetection, HasKeyboardHandlerComponents {
  EmberQuestGame();

  int starsCollected = 0;
  int health = 3;

  late EmberPlayer _ember;
  double objectSpeed = 0.0;

  late double lastBlockXPosition = 0;
  late UniqueKey lastBlockKey;

  @override
  final world = World();

  late final CameraComponent cameraComponent;

  @override
  Color backgroundColor() {
    return const Color.fromARGB(255, 173, 223, 247);
  }

  @override
  void update(double dt) {
    if (health <= 0) {
      overlays.add('GameOver');
    }
    super.update(dt);
  }

  void initializeGame({required bool loadHud}) {
    cameraComponent.viewport.add(
      Hud(),
    );

    final segmentsToLoad = (size.x / 640).ceil();
    segmentsToLoad.clamp(0, segments.length);

    for (var i = 0; i <= segmentsToLoad; i++) {
      loadGameSegments(i, (640 * i).toDouble());
    }

    _ember = EmberPlayer(
      position: Vector2(
        128,
        canvasSize.y - 128,
      ),
    );
    world.add(_ember);

    if (loadHud) {
      add(Hud());
    }
  }

  @override
  Future<void> onLoad() async {
    await images.loadAll([
      'block.png',
      'ember.png',
      'ground.png',
      'heart_half.png',
      'heart.png',
      'star.png',
      'water_enemy.png',
    ]);

    cameraComponent = CameraComponent(world: world);
    cameraComponent.viewfinder.anchor = Anchor.topLeft;
    addAll([cameraComponent, world]);

    initializeGame(loadHud: true);
  }

  void loadGameSegments(int segmentIndex, double xPositionOffset) {
    for (final block in segments[segmentIndex]) {
      switch (block.blockType) {
        case GroundBlock:
          add(
            GroundBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case PlatformBlock:
          add(
            PlatformBlock(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case Star:
          add(
            Star(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
        case WaterEnemy:
          add(
            WaterEnemy(
              gridPosition: block.gridPosition,
              xOffset: xPositionOffset,
            ),
          );
          break;
      }
    }
  }

  void reset() {
    starsCollected = 0;
    health = 3;
    initializeGame(loadHud: false);
  }
}
