import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePageWithLoading extends StatefulWidget {
  const HomePageWithLoading({super.key});

  @override
  State<HomePageWithLoading> createState() => _HomePageWithLoadingState();
}

class _HomePageWithLoadingState extends State<HomePageWithLoading> {
  late final AchievementBloc achievementBloc;

  @override
  void initState() {
    super.initState();
    achievementBloc = context.read<AchievementBloc>();
    final state = achievementBloc.state;
    if (state is LoadGamesWithoutAchievementsState) {
      final notCompletedGames = state.gamesWithoutAchievementsFetched();
      if (notCompletedGames.isNotEmpty) {
        achievementBloc.add(
          FetchAchievementForGameEvent(
            notCompletedGames.first,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AchievementBloc, AchievementState>(
      listenWhen: listenWhen,
      listener: listener,
      bloc: achievementBloc,
      builder: (BuildContext context, AchievementState state) {
        if (state is LoadGamesWithoutAchievementsState) {
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
                  Text(
                      "Found ${state.games.length} games, these will be checked for achievements."),
                  const Text("Achievements now fetching..."),
                  const Padding(
                    padding: EdgeInsets.all(20),
                    child: CircularProgressIndicator(),
                  ),
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }

  void listener(BuildContext context, AchievementState state) {
    if (state is LoadGamesWithoutAchievementsState) {
      final gamesWithoutAchievementsFetched =
          state.gamesWithoutAchievementsFetched();
      if (gamesWithoutAchievementsFetched.isNotEmpty) {
        achievementBloc.add(
          FetchAchievementForGameEvent(
            gamesWithoutAchievementsFetched.first,
          ),
        );
      } else {
        achievementBloc.add(CompleteFetchingAchievementEvent());
        context.go('/');
      }
    }
  }

  bool listenWhen(
    AchievementState previousState,
    AchievementState currentState,
  ) {
    return true;
  }
}
