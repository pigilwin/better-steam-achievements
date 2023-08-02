import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:flutter/material.dart';

class FullyCompletedGameCard extends StatelessWidget {
  const FullyCompletedGameCard({super.key, required this.game});

  final Game game;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final largeWhiteText = theme.displayLarge!.copyWith(color: Colors.white);

    final achievementCount = game.achievements.length;

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
          child: Text(
            "${game.name} with $achievementCount achievements",
            style: largeWhiteText,
          ),
        ),
      ],
    );
  }
}
