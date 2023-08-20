import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/components/front_page_slider.dart';
import 'package:better_steam_achievements/achievements/components/fully_completed_game_card.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SlideShow extends StatefulWidget {
  const SlideShow({super.key});

  @override
  State<SlideShow> createState() => _SlideShowState();
}

class _SlideShowState extends State<SlideShow> {
  late final AchievementBloc achievementBloc;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

    return BlocBuilder<AchievementBloc, AchievementState>(
      builder: (BuildContext context, AchievementState state) {
        final achievementState = achievementBloc.state as FullyLoadedGameState;
        final fullyCompletedGames = achievementState.fullyCompletedGames();
        fullyCompletedGames.shuffle();

        return Scaffold(
          key: scaffoldState,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(
              "Better Steam Achievements - Fully completed ${fullyCompletedGames.length}",
            ),
            leading: IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                scaffoldState.currentState!.openDrawer();
              },
            ),
          ),
          drawer: const Menu(),
          body: FrontPageSlider(
            games: fullyCompletedGames,
            cardGenerator: (game) => FullyCompletedGameCard(
              game: game,
              largeText: true,
            ),
          ),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.minimize),
            onPressed: () {
              context.go('/');
            },
          ),
        );
      },
    );
  }
}
