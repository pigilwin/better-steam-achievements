import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/components/fully_completed_game_card.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_config_link.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
        if (state is InitialAchievementState ||
            state is FailedToLoadCredentailsState) {
          return const HomePageWithConfigLink();
        }

        if (state is LoadGamesWithoutAchievementsState) {
          return const HomePageWithLoading();
        }

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
          body: _getChildren(fullyCompletedGames),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              context.go('/slide-show');
            },
          ),
        );
      },
    );
  }

  Widget _getChildren(Games fullyCompletedGames) {
    final widgets = <Widget>[];
    for (final game in fullyCompletedGames) {
      widgets.add(FullyCompletedGameCard(
        game: game,
        largeText: false,
        clickHandler: () {
          context.go('/information/${game.appId}');
        },
      ));
    }
    return GridView.count(
      crossAxisCount: 4,
      children: widgets,
    );
  }
}
