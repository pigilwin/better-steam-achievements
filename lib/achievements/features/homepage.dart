import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/features/homepage_with_config_link.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController progressBarController;
  late final AchievementBloc achievementBloc;

  @override
  void initState() {
    super.initState();
    progressBarController = AnimationController(vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AchievementBloc, AchievementState>(
      listener: listener,
      builder: (BuildContext context, AchievementState state) {
        if (state is InitialAchievementState ||
            state is FailedToLoadCredentailsState) {
          return const HomePageWithConfigLink();
        }

        if (state is LoadGamesWithoutAchievementsState) {
          return _getLoadingState(context, state);
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

  Widget _getLoadingState(
    BuildContext context,
    LoadGamesWithoutAchievementsState state,
  ) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('BSA - Loading'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Loading application...",
              style: textTheme.bodyLarge,
            ),
            Text("Found ${state.games.length} games"),
            const Text("Achievements now fetching..."),
            Padding(
              padding: const EdgeInsets.all(20),
              child: LinearProgressIndicator(
                value: progressBarController.value,
                semanticsLabel: 'Achievement fetching process',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void listener(BuildContext context, AchievementState state) {
    if (state is LoadGamesWithoutAchievementsState) {
      final games = state.games.values;
      final gamesNotCompleted = games.where((element) => !element.completed);

      setState(() {
        progressBarController.value =
            (games.length - gamesNotCompleted.length).toDouble();
      });

      if (gamesNotCompleted.isNotEmpty) {
        achievementBloc.add(
          FetchAchievementForGameEvent(
            state.credentials,
            gamesNotCompleted.first,
          ),
        );
      }
    }
  }
}
