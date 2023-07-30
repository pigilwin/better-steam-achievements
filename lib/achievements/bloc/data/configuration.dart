class Configuration {
  factory Configuration.empty() {
    return Configuration('', '');
  }

  String steamId;
  String steamApiKey;

  Configuration(this.steamId, this.steamApiKey);
}
