import 'package:better_steam_achievements/achievements/bloc/achievement_event.dart';
import 'package:better_steam_achievements/achievements/bloc/achievement_state.dart';

import 'package:bloc/bloc.dart';

class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc() : super(InitialAchievementState()) {
    on<InitialiseAchievements>((event, emit) => {print('here')});
  }
}
