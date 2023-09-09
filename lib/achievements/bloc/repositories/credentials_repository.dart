import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CredentialsRepository {
  final SharedPreferences preferences;

  late Credentials credentials;

  CredentialsRepository(this.preferences) {
    credentials = _loadCredentails();
  }

  void saveCredentials(Credentials credentials) async {
    preferences.setString('steamId', credentials.steamId);
    preferences.setString('apiKey', credentials.steamApiKey);
    this.credentials = credentials;
  }

  Credentials _loadCredentails() {
    final containsSteamId = preferences.containsKey('steamId');
    final containsApiKey = preferences.containsKey('apiKey');

    if (!containsApiKey || !containsSteamId) {
      return Credentials.empty();
    }
    final id = preferences.getString('steamId')!;
    final apiKey = preferences.getString('apiKey')!;
    return Credentials(id, apiKey);
  }
}
