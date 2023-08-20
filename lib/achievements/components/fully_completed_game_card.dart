import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:flutter/material.dart';

class FullyCompletedGameCard extends StatelessWidget {
  const FullyCompletedGameCard({
    super.key,
    required this.game,
    required this.largeText,
  });

  final Game game;
  final bool largeText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);

    var textSize = theme.displaySmall!.copyWith(color: Colors.white);
    if (largeText) {
      textSize = theme.displayLarge!.copyWith(color: Colors.white);
    }

    final achievementCount = game.achievements.length;
    var achievementText = "This game has $achievementCount achievement";
    if (achievementCount > 1) {
      achievementText = "This game has $achievementCount achievements";
    }

    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          child: Image.network(
            game.imageUrl(),
            fit: BoxFit.cover,
            height: media.size.height,
            width: media.size.width,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Image.network(game.logoUrl()),
        ),
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            achievementText,
            style: textSize,
          ),
        )
      ],
    );
  }
}
