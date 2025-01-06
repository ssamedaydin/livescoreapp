class LeaguesModel {
  final int? leagueKey;
  final String? leagueName;
  final String? leagueLogo;

  LeaguesModel({required this.leagueKey, required this.leagueName, required this.leagueLogo});

  LeaguesModel.fromJson(Map<String, dynamic> json)
      : leagueKey = json["league_key"],
        leagueName = json["league_name"],
        leagueLogo = json["league_logo"];
}
