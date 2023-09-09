import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/components/incomplete_game_card.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreThanTenPage extends StatefulWidget {
  const MoreThanTenPage({super.key});

  @override
  State<MoreThanTenPage> createState() => _MoreThanTenPageState();
}

class _MoreThanTenPageState extends State<MoreThanTenPage> {
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  late final AchievementBloc achievementBloc;
  late final FullyLoadedGameState state;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    state = achievementBloc.state as FullyLoadedGameState;
  }

  @override
  Widget build(BuildContext context) {
    final games = state.gamesWithMoreThanTenAchievementsToGo();
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Better Steam Achievements - ${games.length} games with more than 10 achievements to go",
        ),
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            scaffoldState.currentState!.openDrawer();
          },
        ),
      ),
      drawer: const Menu(),
      body: _getChildren(games),
    );
  }

  Widget _getChildren(Games nearlyCompleteGames) {
    final widgets = <Widget>[];
    for (final game in nearlyCompleteGames) {
      widgets.add(IncompleteGameCard(
        game: game,
        largeText: false,
      ));
    }
    return GridView.count(
      crossAxisCount: 4,
      children: widgets,
    );
  }
}
