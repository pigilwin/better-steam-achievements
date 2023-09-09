import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GamesRepository {
  final SharedPreferences preferences;

  late List<int> gamesWithoutAchievements;
  late List<int> gamesHidden;

  GamesRepository(this.preferences) {
    gamesWithoutAchievements = _loadGames('gamesWithoutAchievements');
    gamesHidden = _loadGames('gamesHidden');
  }

  Future<void> cacheGameNoAchievements(Game game) async {
    gamesWithoutAchievements.add(game.appId);
    final gamesIds = gamesWithoutAchievements.map((e) => e.toString()).toList();
    await preferences.setStringList(
      'gamesWithoutAchievements',
      gamesIds,
    );
  }

  bool isGameHidden(Game game) {
    return gamesHidden.contains(game.appId);
  }

  List<int> _loadGames(String key) {
    if (!preferences.containsKey(key)) {
      return [];
    }

    final games = preferences.getStringList(key)!;
    return games.map((e) => int.parse(e)).toList();
  }
}
