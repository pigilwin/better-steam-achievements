part of 'achievement_bloc.dart';

abstract class WithCredentials {
  Credentials getCredentails();
}

@immutable
abstract class AchievementState extends Equatable {}

@immutable
class InitialAchievementState extends AchievementState
    implements WithCredentials {
  late final Credentials credentials;

  InitialAchievementState() {
    credentials = Credentials.empty();
  }

  @override
  List<Object> get props => [credentials];

  @override
  Credentials getCredentails() {
    return credentials;
  }
}

@immutable
class FailedToLoadCredentailsState extends AchievementState {
  @override
  List<Object> get props => [];
}

@immutable
class LoadGamesWithoutAchievementsState extends AchievementState
    implements WithCredentials {
  final Credentials credentials;
  final Games games;

  LoadGamesWithoutAchievementsState(this.credentials, this.games);

  @override
  List<Object> get props => [credentials, games];

  @override
  Credentials getCredentails() {
    return credentials;
  }

  List<Game> gamesWithoutAchievementsFetched() {
    return games.where((element) => !element.achievementsFetched).toList();
  }

  double getCompletePrecentage() {
    final notCompletedGames = gamesWithoutAchievementsFetched();
    final totalGames = games.length;
    final gamesCompleted = totalGames - notCompletedGames.length;
    return gamesCompleted / totalGames;
  }
}

class FullyLoadedGameState extends AchievementState implements WithCredentials {
  final Credentials credentials;
  final Games games;

  FullyLoadedGameState(this.credentials, this.games);

  @override
  List<Object> get props => [credentials, games];

  @override
  Credentials getCredentails() {
    return credentials;
  }
}
