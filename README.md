# better-steam-achievements

{
	"baseUrl": "https://api.steampowered.com/",
	"key": "2438D3CEF231C55EFAA611596CD5D15A",
	"steamId": "76561198134391670",
	"format": "json"
}

curl --request GET \
  --url 'https://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key=2438D3CEF231C55EFAA611596CD5D15A&steamid=76561198134391670&format=json&include_appinfo=true'

  curl --request GET \
  --url 'https://api.steampowered.com/ISteamUserStats/GetUserStatsForGame/v0002/?key=2438D3CEF231C55EFAA611596CD5D15A&steamid=76561198134391670&format=json&appid=1266700'