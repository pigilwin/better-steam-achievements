import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AchievementRepository {
  Future<Games> getGames(Credentials credentials) async {
    final gamesResponse = await http.get(
      getBuiltUrl(
        'IPlayerService/GetOwnedGames/v0001',
        credentials,
        {'include_appinfo': true.toString()},
      ),
    );

    if (gamesResponse.statusCode != 200) {
      return [];
    }

    final reponseBody =
        (convert.jsonDecode(gamesResponse.body) as Map<String, dynamic>);
    final data = reponseBody['response']['games'];
    final games = <Game>[];
    for (final game in data) {
      final applicationId = getItem<int>(game, 'appid', 0);
      games.add(
        Game.untouched(
          applicationId,
          getItem<String>(game, 'name', ''),
        ),
      );
    }
    return games;
  }

  Future<List<Achievement>> getAchievements(
    Credentials credentials,
    Game game,
  ) async {
    final achievementsResponse = await http.get(
      getBuiltUrl(
        'ISteamUserStats/GetPlayerAchievements/v0001',
        credentials,
        {'appid': game.appId.toString(), 'l': 'en'},
      ),
    );

    if (achievementsResponse.statusCode != 200) {
      return [];
    }

    final achievements = <Achievement>[];
    final reponseBody = convert.jsonDecode(achievementsResponse.body);
    final playerstats = reponseBody['playerstats'] as Map;
    if (playerstats.containsKey('achievements')) {
      final data = playerstats['achievements'];
      for (final achievement in data) {
        achievements.add(
          Achievement(
            getItem<String>(achievement, 'apiname', ''),
            getItem<String>(achievement, 'name', ''),
            getItem<String>(achievement, 'description', ''),
            getItem<int>(achievement, 'achieved', 0) == 1,
            getItem<int>(achievement, 'unlocktime', 0),
          ),
        );
      }
    }

    return achievements;
  }

  Uri getBuiltUrl(
    String path,
    Credentials credentials,
    Map<String, dynamic> additional,
  ) {
    Map<String, dynamic> queryParameters = {
      'key': credentials.steamApiKey,
      'steamid': credentials.steamId,
      'format': 'json'
    };
    queryParameters.addAll(additional);
    return Uri.https("api.steampowered.com", path, queryParameters);
  }

  T getItem<T>(dynamic row, String key, T defaultValue) {
    final data = row as Map<String, dynamic>;
    if (data.containsKey(key)) {
      return data[key] as T;
    }
    return defaultValue;
  }
}
