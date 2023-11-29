import 'package:ember_quest_flame/ember_quest.dart';
import 'package:flutter/material.dart';

class MainMenu extends StatelessWidget {
  final EmberQuestGame game;

  const MainMenu({super.key, required this.game});

  @override
  Widget build(BuildContext context) {
    const blackTextColor = Color.fromRGBO(0, 0, 0, 1.0);
    const whiteTextColor = Color.fromRGBO(255, 255, 255, 1.0);

    return Material(
      color: Colors.transparent,
      child: Center(
        child: IntrinsicHeight(
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: blackTextColor,
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  'Ember Quest',
                  style: TextStyle(
                    color: whiteTextColor,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  child: ElevatedButton(
                    onPressed: () {
                      game.overlays.remove('MainMenu');
                    },
                    child: const Text(
                      'Play',
                      style: TextStyle(
                        fontSize: 40,
                        color: blackTextColor,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Expanded(
                  child: Text(
                    'Use WASD or Arrow Keys for movement. \n Space bar to jump. \n Collect as many stars as you can and avoid enemies!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: whiteTextColor,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
