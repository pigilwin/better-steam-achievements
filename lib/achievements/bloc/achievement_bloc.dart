import 'package:better_steam_achievements/achievements/bloc/repositories/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/credentials_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/repositories/games_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final CredentialsRepository _credentialsRepository;
  final GamesRepository _gamesRepository;
  final AchievementRepository _achievementRepository;

  AchievementBloc(
    this._credentialsRepository,
    this._gamesRepository,
    this._achievementRepository,
  ) : super(InitialAchievementState()) {
    on<InitialiseAchievements>((event, emit) async {
      final credentials = _credentialsRepository.credentials;

      if (credentials.isEmpty) {
        emit(FailedToLoadCredentailsState());
        return;
      }

      emit(
        LoadGamesWithoutAchievementsState(
          await getGames(credentials),
        ),
      );
    });

    on<SaveCredentialsEvent>((event, emit) async {
      final credentials = Credentials(event.steamId, event.apiKey);
      _credentialsRepository.saveCredentials(credentials);
      emit(
        LoadGamesWithoutAchievementsState(
          await getGames(credentials),
        ),
      );
    });

    on<FetchAchievementForGameEvent>((event, emit) async {
      if (state is LoadGamesWithoutAchievementsState) {
        final typedState = state as LoadGamesWithoutAchievementsState;
        final games = typedState.games;

        final game = event.game;

        // Remove the current game from the list, if it has no achievements
        // then we don't want to store it
        final gamesWithoutCurrentGame = games.where((element) {
          return game.appId != element.appId;
        });

        // Create a new map from the current games
        final newGames = List<Game>.from(gamesWithoutCurrentGame);

        // Fetch the achievements for this game
        final achievements = await _achievementRepository.getAchievements(
          _credentialsRepository.credentials,
          game,
        );

        // If the game has no achievements then we don't want to keep the game
        if (achievements.isEmpty) {
          newGames.add(game.copyWithNoAchievements());
          await _gamesRepository.cacheGameNoAchievements(game);
          emit(LoadGamesWithoutAchievementsState(newGames));
          return;
        }

        // Attach the achievements to the games
        final gameWithAchievements = game.copyWithAchievements(achievements);

        // Add the game back to the list
        newGames.add(gameWithAchievements);

        emit(LoadGamesWithoutAchievementsState(newGames));
      }
    });

    on<CompleteFetchingAchievementEvent>((event, emit) {
      if (state is LoadGamesWithoutAchievementsState) {
        final typedState = state as LoadGamesWithoutAchievementsState;
        emit(FullyLoadedGameState(typedState.games));
      }
    });

    on<HideGameEvent>((event, emit) {
      if (state is FullyLoadedGameState) {
        final typedState = state as FullyLoadedGameState;
        final games = typedState.games;
        final game = event.game;

        // Remove the current game from the list, if it has no achievements
        // then we don't want to store it
        final gamesWithoutCurrentGame = games.where((element) {
          return game.appId != element.appId;
        });

        _gamesRepository.hideGame(game);

        final gamesWithHidden = List<Game>.from(gamesWithoutCurrentGame);
        gamesWithHidden.add(game.copyWithHidden());
        emit(FullyLoadedGameState(gamesWithHidden));
      }
    });

    on<RemoveHiddenGameEvent>((event, emit) async {
      if (state is FullyLoadedGameState) {
        final typedState = state as FullyLoadedGameState;
        final games = typedState.games;
        final game = event.game;

        // Remove the current game from the list, if it has no achievements
        // then we don't want to store it
        final gamesWithoutCurrentGame = games.where((element) {
          return game.appId != element.appId;
        });

        _gamesRepository.removeGameFromHidden(game);

        final gamesWithHidden = List<Game>.from(gamesWithoutCurrentGame);

        final achievements = await _achievementRepository.getAchievements(
          _credentialsRepository.credentials,
          game,
        );

        gamesWithHidden.add(game.copyWithAchievements(achievements));
        emit(FullyLoadedGameState(gamesWithHidden));
      }
    });
  }

  Credentials getCredentials() {
    return _credentialsRepository.credentials;
  }

  Future<List<Game>> getGames(Credentials credentials) async {
    final loadedGames = await _achievementRepository.getGames(credentials);
    final games = List<Game>.empty(growable: true);
    for (final game in loadedGames) {
      if (_gamesRepository.isGameHidden(game)) {
        games.add(game.copyWithHidden());
      } else {
        games.add(game);
      }
    }
    return games;
  }
}
