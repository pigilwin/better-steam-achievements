import 'package:better_steam_achievements/achievements/bloc/achievement_bloc.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/credentials_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/games_repository.dart';
import 'package:better_steam_achievements/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatelessWidget {
  final CredentialsRepository credentialsRepository;
  final GamesRepository gamesRepository;
  final AchievementRepository achievementRepository;

  const Application({
    super.key,
    required this.credentialsRepository,
    required this.gamesRepository,
    required this.achievementRepository,
  });

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AchievementBloc>(
      create: (_) => AchievementBloc(
        credentialsRepository,
        gamesRepository,
        achievementRepository,
      )..add(InitialiseAchievements()),
      lazy: false,
      child: MaterialApp.router(
        title: 'Better Steam Achievements',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
          useMaterial3: true,
        ),
        routerConfig: ApplicationRouter.router(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
