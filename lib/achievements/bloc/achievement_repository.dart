import 'package:better_steam_achievements/achievements/bloc/data/achievement.dart';
import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:better_steam_achievements/achievements/bloc/data/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class AchievementRepository {
  Future<Credentials> getCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final containsSteamId = sharedPreferences.containsKey('steamId');
    final containsApiKey = sharedPreferences.containsKey('apiKey');

    if (!containsApiKey || !containsSteamId) {
      return Credentials.empty();
    }
    final id = sharedPreferences.getString('steamId')!;
    final apiKey = sharedPreferences.getString('apiKey')!;
    return Credentials(id, apiKey);
  }

  Future<void> saveCredentials(Credentials credentials) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString('steamId', credentials.steamId);
    sharedPreferences.setString('apiKey', credentials.steamApiKey);
  }

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
        Game.emptyAchievements(
          applicationId,
          getItem<String>(game, 'name', ''),
          getItem<String>(game, 'img_icon_url', ''),
          getItem<int>(game, 'playtime_forever', 0),
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
