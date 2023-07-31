part of 'achievement_bloc.dart';

abstract class AchievementEvent {}

class InitialiseAchievements extends AchievementEvent {}

class SaveCredentialsEvent extends AchievementEvent {
  final String apiKey;
  final String steamId;

  SaveCredentialsEvent(this.apiKey, this.steamId);
}

class FetchAchievementForGameEvent extends AchievementEvent {
  final Credentials credentials;
  final Game game;

  FetchAchievementForGameEvent(this.credentials, this.game);
}
