import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';

class Game {
  final int appId;
  final String name;
  final String iconHash;
  final int playTime;
  final List<Achievement> achievements;

  Game(
    this.appId,
    this.name,
    this.iconHash,
    this.playTime,
    this.achievements,
  );

  @override
  String toString() {
    return "$name with ${achievements.length} achievements";
  }
}
