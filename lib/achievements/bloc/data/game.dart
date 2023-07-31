import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:flutter/material.dart';

@immutable
class Game {
  final int appId;
  final String name;
  final String iconHash;
  final int playTime;
  final bool completed;
  final Achievements achievements;

  const Game(
    this.appId,
    this.name,
    this.iconHash,
    this.playTime,
    this.completed,
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

  @override
  String toString() {
    return "$name with ${achievements.length} achievements";
  }
}

typedef Games = Map<int, Game>;
