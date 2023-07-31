import 'package:better_steam_achievements/achievements/bloc/achievement_event.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';
import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';

import 'package:bloc/bloc.dart';

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
  }
}
