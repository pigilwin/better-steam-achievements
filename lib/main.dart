import 'package:better_steam_achievements/achievements/bloc/repositories/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/credentials_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/games_repository.dart';
import 'package:better_steam_achievements/application.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  final sharedPreferences = await SharedPreferences.getInstance();
  final credentialsRepository = CredentialsRepository(sharedPreferences);
  final gameRepository = GamesRepository(sharedPreferences);
  final achievementRepository = AchievementRepository();

  runApp(
    Application(
      credentialsRepository: credentialsRepository,
      gamesRepository: gameRepository,
      achievementRepository: achievementRepository,
    ),
  );
}
