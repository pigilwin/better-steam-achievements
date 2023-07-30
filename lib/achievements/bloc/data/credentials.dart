class Credentials {
  factory Credentials.empty() {
    return Credentials('', '');
  }

  String steamId;
  String steamApiKey;

  Credentials(this.steamId, this.steamApiKey);

  bool get isEmpty => steamApiKey.isEmpty || steamId.isEmpty;
}
