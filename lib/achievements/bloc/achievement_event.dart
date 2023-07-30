abstract class AchievementEvent {}

class InitialiseAchievements extends AchievementEvent {}

class SaveCredentialsEvent extends AchievementEvent {
  final String apiKey;
  final String steamId;

  SaveCredentialsEvent(this.apiKey, this.steamId);
}
