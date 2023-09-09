import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:flutter/material.dart';

class IncompleteGameCard extends StatelessWidget {
  const IncompleteGameCard({
    super.key,
    required this.game,
    required this.largeText,
    required this.clickHandler,
  });

  final Game game;
  final bool largeText;
  final VoidCallback? clickHandler;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);
    final achievementCount = game.incompleteAchievements().length;

    var textSize = theme.displaySmall!.copyWith(color: Colors.white);
    if (largeText) {
      textSize = theme.displayLarge!.copyWith(color: Colors.white);
    }

    var achievementText = "$achievementCount achievement remaining";
    if (achievementCount > 1) {
      achievementText = "$achievementCount achievements remaining";
    }

    final children = [
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
        child: Text(
          achievementText,
          style: textSize,
        ),
      ),
    ];

    if (clickHandler != null) {
      children.add(
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.only(bottom: 5, right: 5),
          child: IconButton(
            icon: const Icon(Icons.edit),
            color: Colors.white,
            onPressed: clickHandler,
          ),
        ),
      );
    }

    return Stack(
      children: children,
    );
  }
}
