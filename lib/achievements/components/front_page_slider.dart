import 'dart:async';

import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/components/fully_completed_game_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FrontPageSlider extends StatefulWidget {
  const FrontPageSlider({super.key, required this.fullyCompletedGames});

  final Games fullyCompletedGames;

  @override
  State<FrontPageSlider> createState() => _FrontPageSliderState();
}

class _FrontPageSliderState extends State<FrontPageSlider>
    with TickerProviderStateMixin {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: 0, viewportFraction: 1);

    const fiveSeconds = Duration(seconds: 5);

    Future.delayed(fiveSeconds, () {
      Timer.periodic(fiveSeconds, (timer) async {
        if (pageController.hasClients) {
          var nextPage = pageController.page!.toInt() + 1;
          if (nextPage > widget.fullyCompletedGames.length - 1) {
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
    return PageView.builder(
      pageSnapping: true,
      controller: pageController,
      itemCount: widget.fullyCompletedGames.length,
      itemBuilder: (context, index) {
        final game = widget.fullyCompletedGames[index];
        return FullyCompletedGameCard(game: game);
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }
}
