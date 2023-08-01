import 'dart:async';

import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrontPageSlider extends StatefulWidget {
  const FrontPageSlider({super.key});

  @override
  State<FrontPageSlider> createState() => _FrontPageSliderState();
}

class _FrontPageSliderState extends State<FrontPageSlider>
    with TickerProviderStateMixin {
  late final AchievementBloc achievementBloc;
  late final FullyLoadedGameState achievementState;
  late final PageController pageController;
  late final Games fullyCompletedGames;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    achievementState = achievementBloc.state as FullyLoadedGameState;
    fullyCompletedGames = achievementState.fullyCompletedGames();
    pageController = PageController(initialPage: 0, viewportFraction: 1);

    const fiveSeconds = Duration(seconds: 5);

    Future.delayed(fiveSeconds, () {
      Timer.periodic(fiveSeconds, (timer) async {
        if (pageController.hasClients) {
          var nextPage = pageController.page!.toInt() + 1;
          if (nextPage > fullyCompletedGames.length - 1) {
            nextPage = 0;
          }

          pageController.animateToPage(
            nextPage,
            duration: const Duration(milliseconds: 3),
            curve: Curves.easeInOut,
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    final media = MediaQuery.of(context);

    final largeWhiteText = theme.displayLarge!.copyWith(color: Colors.white);
    final mediumWhiteText = theme.displayMedium!.copyWith(color: Colors.white);

    return PageView.builder(
      pageSnapping: true,
      controller: pageController,
      itemCount: fullyCompletedGames.length,
      itemBuilder: (context, index) {
        final game = fullyCompletedGames[index];
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
              alignment: Alignment.topCenter,
              child: Text(
                "Fully completed ${fullyCompletedGames.length} games",
                style: largeWhiteText,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "${game.name} with $achievementCount achievements",
                style: mediumWhiteText,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
