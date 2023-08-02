import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/components/front_page_slider.dart';
import 'package:better_steam_achievements/achievements/components/less_than_ten_game_card.dart';
import 'package:better_steam_achievements/achievements/components/menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LessThanTenPage extends StatefulWidget {
  const LessThanTenPage({super.key});

  @override
  State<LessThanTenPage> createState() => _LessThanTenPageState();
}

class _LessThanTenPageState extends State<LessThanTenPage> {
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
    final games = state.gamesWithLessThanTenAchivementsToGo();
    return Scaffold(
      key: scaffoldState,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          "Better Steam Achievements - ${games.length} games with less than 10 achievements to go",
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
        games: games,
        cardGenerator: (game) => LessThanTenGameCard(game: game),
      ),
    );
  }
}
