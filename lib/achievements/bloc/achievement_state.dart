import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

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
  List<Object> get props => [
        credentials.steamApiKey,
        credentials.steamId,
      ];

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
  List<Object> get props => [
        credentials.steamApiKey,
        credentials.steamId,
        games,
      ];

  @override
  Credentials getCredentails() {
    return credentials;
  }
}
