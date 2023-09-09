part of 'achievement_bloc.dart';

abstract class AchievementEvent {}

class InitialiseAchievements extends AchievementEvent {}

class SaveCredentialsEvent extends AchievementEvent {
  final String apiKey;
  final String steamId;

  SaveCredentialsEvent(this.apiKey, this.steamId);
}

class FetchAchievementForGameEvent extends AchievementEvent {
  final Game game;

  FetchAchievementForGameEvent(this.game);
}

class CompleteFetchingAchievementEvent extends AchievementEvent {
  CompleteFetchingAchievementEvent();
}

class HideGameEvent extends AchievementEvent {
  final Game game;

  HideGameEvent(this.game);
}

class RemoveHiddenGameEvent extends AchievementEvent {
  final Game game;

  RemoveHiddenGameEvent(this.game);
}
