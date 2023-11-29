import 'package:ember_quest_flame/ember_quest.dart';
import 'package:ember_quest_flame/overlays/game_over_menu.dart';
import 'package:ember_quest_flame/overlays/main_menu.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  Flame.device.fullScreen();

  Flame.device.setLandscape();
  runApp(
    GameWidget<EmberQuestGame>.controlled(
      overlayBuilderMap: {
        'MainMenu': (_, game) => MainMenu(game: game),
        'GameOver': (_, game) => GameOver(game: game),
      },
      initialActiveOverlays: const ['MainMenu'],
      gameFactory: EmberQuestGame.new,
    ),
  );
}
