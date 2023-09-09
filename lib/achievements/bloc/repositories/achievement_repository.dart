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
    final achievementResponse = await http.get(getBuiltUrl(
      'ISteamUserStats/GetPlayerAchievements/v0001',
      credentials,
      {'appid': game.appId.toString(), 'l': 'en'},
    ));

    if (achievementResponse.statusCode != 200) {
      return [];
    }

    final achievementInformation = await getAchievementInformation(
      credentials,
      game,
    );

    final achievements = <Achievement>[];

    final reponseBody = convert.jsonDecode(achievementResponse.body);
    final playerstats = reponseBody['playerstats'] as Map;
    if (playerstats.containsKey('achievements')) {
      final data = playerstats['achievements'];
      for (final achievement in data) {
        final apiName = getItem<String>(achievement, 'apiname', '');
        final information = achievementInformation[apiName];

        achievements.add(
          Achievement(
              apiName,
              getItem<String>(achievement, 'name', ''),
              getItem<String>(achievement, 'description', ''),
              getItem<int>(achievement, 'achieved', 0) == 1,
              getItem<int>(achievement, 'unlocktime', 0),
              getItem<String>(information, 'icon', ''),
              getItem<String>(information, 'icongray', ''),
              getItem<String>(information, 'hidden', 'N') == 'Y'),
        );
      }
    }
    return achievements;
  }

  Future<AchievementIcons> getAchievementInformation(
    Credentials credentials,
    Game game,
  ) async {
    final informationResponse = await http.get(
      getBuiltUrl(
        'ISteamUserStats/GetSchemaForGame/v2',
        credentials,
        {'appid': game.appId.toString(), 'l': 'en'},
      ),
    );

    if (informationResponse.statusCode != 200) {
      return {};
    }

    final information = <String, Map<String, String>>{};
    final reponseBody = convert.jsonDecode(informationResponse.body) as Map;

    if (reponseBody.containsKey('game')) {
      final game = reponseBody['game'] as Map;
      if (game.containsKey('availableGameStats')) {
        final availableGameStats = game['availableGameStats'] as Map;
        if (availableGameStats.containsKey('achievements')) {
          final data = availableGameStats['achievements'] as List;
          for (final achievement in data) {
            information[achievement['name']] = {
              'icon': achievement['icon'],
              'icongray': achievement['icongray'],
              'hidden': achievement['hidden'] == 1 ? 'Y' : 'N'
            };
          }
        }
      }
    }
    return information;
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

  T getItem<T>(
    dynamic row,
    String key,
    T defaultValue,
  ) {
    final data = row as Map<String, dynamic>;
    if (data.containsKey(key)) {
      return data[key] as T;
    }
    return defaultValue;
  }
}

typedef AchievementIcons = Map<String, Map<String, String>>;
