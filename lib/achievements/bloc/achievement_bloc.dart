import 'package:better_steam_achievements/achievements/bloc/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:bloc/bloc.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final AchievementRepository _repository;

  AchievementBloc(this._repository) : super(InitialAchievementState()) {
    on<InitialiseAchievements>((event, emit) async {
      final credentials = await _repository.getCredentials();

      if (credentials.isEmpty) {
        emit(FailedToLoadCredentailsState());
      }

      final games = await _repository.getGames(credentials);

      emit(LoadGamesWithoutAchievementsState(credentials, games));
    });

    on<SaveCredentialsEvent>((event, emit) async {
      final credentials = Credentials(event.steamId, event.apiKey);
      await _repository.saveCredentials(credentials);
    });

    on<FetchAchievementForGameEvent>((event, emit) async {
      if (state is LoadGamesWithoutAchievementsState) {
        final typedState = state as LoadGamesWithoutAchievementsState;
        final games = typedState.games;

        final credentials = event.credentials;
        final game = event.game;

        // Fetch the achievements for this game
        final achievements =
            await _repository.getAchievements(credentials, game);

        final gamesWithoutCurrentGame = games.where((element) {
          return game.appId != element.appId;
        });

        // Create a new map from the current games
        final newGames = List<Game>.from(gamesWithoutCurrentGame);

        // If the game has no achievements then we don't want to keep the game
        if (achievements.isEmpty) {
          emit(LoadGamesWithoutAchievementsState(credentials, newGames));
          return;
        }

        // Attach the achievements to the games
        final gameWithAchievements = game.copyWithAchievements(achievements);

        // Add the game back to the list
        newGames.add(gameWithAchievements);

        emit(LoadGamesWithoutAchievementsState(credentials, newGames));
      }
    });
    on<ConvertAchievementToActiveStateEvent>((event, emit) {
      if (state is LoadGamesWithoutAchievementsState) {
        final typedState = state as LoadGamesWithoutAchievementsState;
        emit(FullyLoadedGameState(typedState.credentials, typedState.games));
      }
    });
  }
}
