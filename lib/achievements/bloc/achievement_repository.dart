import 'package:better_steam_achievements/achievements/bloc/data/credentials.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementRepository {
  Future<Credentials> getCredentials() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('credentials')) {
      return Credentials.empty();
    }
    final data = sharedPreferences.get('credentials');
    print(data);
    return Credentials.empty();
    //return Credentials(data['steamId'], data['steamApiKey']);
  }
}
