part of 'achievement_bloc.dart';

@immutable
abstract class AchievementState extends Equatable {}

@immutable
class InitialAchievementState extends AchievementState {
  InitialAchievementState();

  @override
  List<Object> get props => [];
}

@immutable
class FailedToLoadCredentailsState extends AchievementState {
  @override
  List<Object> get props => [];
}

@immutable
class LoadGamesWithoutAchievementsState extends AchievementState {
  final Games games;

  LoadGamesWithoutAchievementsState(this.games);

  @override
  List<Object> get props => [games];

  List<Game> gamesWithoutAchievementsFetched() {
    return games
        .where((element) => element.gameState == GameState.untouched)
        .toList();
  }
}

class FullyLoadedGameState extends AchievementState {
  final Games games;

  FullyLoadedGameState(this.games);

  @override
  List<Object> get props => [games];

  Games fullyCompletedGames() {
    return games.where((game) {
      return game.achievementsCompleted();
    }).toList();
  }

  Games gamesWithLessThanTenAchivementsToGo() {
    var lessThanThenToGo = games.where((element) {
      return element.hasLessThanTenAchievements();
    }).toList();

    lessThanThenToGo.sort((a, b) {
      return a.incompleteAchievements().length -
          b.incompleteAchievements().length;
    });

    return lessThanThenToGo;
  }

  Games gamesWithMoreThanTenAchievementsToGo() {
    return games.where((element) {
      return element.hasMoreThanTenAchievements();
    }).toList();
  }

  Game findGameById(int gameId) {
    return games.where((element) {
      return element.appId == gameId;
    }).first;
  }
}
