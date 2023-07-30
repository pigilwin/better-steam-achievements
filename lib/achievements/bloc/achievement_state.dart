import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AchievementState extends Equatable {
  late Credentials credentials;

  @override
  List<Object> get props => [
        credentials.steamApiKey,
        credentials.steamId,
      ];
}

class InitialAchievementState extends AchievementState {
  InitialAchievementState() {
    credentials = Credentials.empty();
  }
}

class ActiveAchievementState extends AchievementState {
  ActiveAchievementState(Credentials credentialsState) {
    credentials = credentialsState;
  }
}
