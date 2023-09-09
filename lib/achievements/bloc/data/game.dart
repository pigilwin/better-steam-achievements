import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Game extends Equatable {
  final int appId;
  final String name;
  final GameState gameState;
  final Achievements achievements;

  const Game(
    this.appId,
    this.name,
    this.gameState,
    this.achievements,
  );

  factory Game.untouched(
    int appId,
    String name,
  ) {
    return Game(appId, name, GameState.untouched, const []);
  }

  Game copyWithNoAchievements() {
    return Game(
      appId,
      name,
      GameState.noachievements,
      const [],
    );
  }

  Game copyWithHidden() {
    return Game(
      appId,
      name,
      GameState.hidden,
      const [],
    );
  }

  Game copyWithAchievements(Achievements achievements) {
    return Game(
      appId,
      name,
      GameState.loaded,
      achievements,
    );
  }

  bool achievementsCompleted() {
    final completedAchievementsLength =
        achievements.where((element) => element.completed).length;
    return completedAchievementsLength == achievements.length;
  }

  bool hasLessThanTenAchievements() {
    final notCompletedAchievments = incompleteAchievements().length;
    return notCompletedAchievments < 10 && notCompletedAchievments > 0;
  }

  bool hasMoreThanTenAchievements() {
    final notCompletedAchievments = incompleteAchievements().length;
    return notCompletedAchievments > 10;
  }

  Achievements incompleteAchievements() {
    return achievements.where((element) => !element.completed).toList();
  }

  String imageUrl() {
    return "https://cdn.akamai.steamstatic.com/steam/apps/$appId/library_hero.jpg";
  }

  String logoUrl() {
    return "https://cdn.cloudflare.steamstatic.com/steam/apps/$appId/logo.png";
  }

  @override
  String toString() {
    return "$name with ${achievements.length} achievements";
  }

  @override
  List<Object> get props => [
        appId,
        name,
        gameState,
        achievements,
      ];
}

typedef Games = List<Game>;

enum GameState {
  untouched,
  noachievements,
  hidden,
  loaded,
}
