import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
}
