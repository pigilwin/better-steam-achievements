import 'package:better_steam_achievements/achievements/bloc/achievement_event.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_repository.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';

import 'package:bloc/bloc.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  final AchievementRepository _repository;

  AchievementBloc(this._repository) : super(InitialAchievementState()) {
    on<InitialiseAchievements>((event, emit) async {
      final credentials = await _repository.getCredentials();
      emit(ActiveAchievementState(credentials));
    });
  }
}
