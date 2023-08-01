import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class Game extends Equatable {
  final int appId;
  final String name;
  final String iconHash;
  final int playTime;
  final bool achievementsFetched;
  final Achievements achievements;

  const Game(
    this.appId,
    this.name,
    this.iconHash,
    this.playTime,
    this.achievementsFetched,
    this.achievements,
  );

  factory Game.emptyAchievements(
    int appId,
    String name,
    String iconHash,
    int playTime,
  ) {
    return Game(appId, name, iconHash, playTime, false, const []);
  }

  Game copyWithAchievements(Achievements achievements) {
    return Game(
      appId,
      name,
      iconHash,
      playTime,
      true,
      achievements,
    );
  }

  bool achievementsCompleted() {
    final completedAchievementsLength =
        achievements.where((element) => element.completed).length;
    return completedAchievementsLength == achievements.length;
  }

  bool hasLessThanTenAchievements() {
    final notCompletedAchievments =
        achievements.where((element) => !element.completed).length;
    return notCompletedAchievments < 10 && notCompletedAchievments > 0;
  }

  String imageUrl() {
    return "https://cdn.akamai.steamstatic.com/steam/apps/$appId/header.jpg";
  }

  @override
  String toString() {
    return "$name with ${achievements.length} achievements";
  }

  @override
  List<Object> get props => [
        appId,
        name,
        iconHash,
        playTime,
        achievementsFetched,
        achievements,
      ];
}

typedef Games = List<Game>;
