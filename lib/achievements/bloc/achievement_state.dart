import 'package:better_steam_achievements/achievements/bloc/data/configuration.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AchievementState extends Equatable {
  late Configuration configuration;

  @override
  List<Object> get props => [
        configuration.steamApiKey,
        configuration.steamId,
      ];
}

class InitialAchievementState extends AchievementState {
  InitialAchievementState() {
    configuration = Configuration.empty();
  }
}
