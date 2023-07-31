import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_config_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AchievementBloc, AchievementState>(
      listener: (BuildContext context, AchievementState state) {},
      builder: (BuildContext context, AchievementState state) {
        if (state is InitialAchievementState ||
            state is FailedToLoadCredentailsState) {
          return const HomePageWithConfigLink();
        }

        if (state is LoadGamesWithoutAchievementsState) {
          return _getLoadingState(state);
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: const Text('Better Steam Achievements'),
          ),
          body: const Center(
            child: Text("Homepage will be here"),
          ),
        );
      },
    );
  }

  Widget _getLoadingState(LoadGamesWithoutAchievementsState state) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BSA - Loading'),
      ),
      body: Center(
        child: Text("Loading ${state.games.length}"),
      ),
    );
  }
}
