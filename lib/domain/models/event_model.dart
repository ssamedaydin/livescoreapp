class EventModel {
  final int? eventKey;
  final String? eventLive;
  final String? eventDate;
  final String? eventHomeTeam;
  final String? eventAwayTeam;
  final String? eventHalftimeResult;
  final String? eventFinalResult;
  final String? eventStatus;
  final int? leaugeKey;
  final String? leaugeName;
  final String? leaugeRound;
  final String? homeTeamLogo;
  final String? awayTeamLogo;
  final String? leaugeLogo;
  final List<GoalModel>? goals;
  final List<CardsModel>? cards;
  final List<StatisticsModel>? statistics;

  EventModel({
    required this.eventKey,
    required this.eventLive,
    required this.eventDate,
    required this.eventHomeTeam,
    required this.eventAwayTeam,
    required this.eventHalftimeResult,
    required this.eventFinalResult,
    required this.eventStatus,
    required this.leaugeKey,
    required this.leaugeName,
    required this.leaugeRound,
    required this.homeTeamLogo,
    required this.awayTeamLogo,
    required this.leaugeLogo,
    required this.goals,
    required this.cards,
    required this.statistics,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      eventKey: json["event_key"],
      eventLive: json["event_live"],
      eventDate: json["event_date"],
      eventHomeTeam: json["event_home_team"],
      eventAwayTeam: json["event_away_team"],
      eventHalftimeResult: json["event_halftime_result"],
      eventFinalResult: json["event_final_result"],
      eventStatus: json["event_status"],
      leaugeKey: json["leauge_key"],
      leaugeName: json["league_name"],
      leaugeRound: json["leauge_round"],
      homeTeamLogo: json["home_team_logo"],
      awayTeamLogo: json["away_team_logo"],
      leaugeLogo: json["league_logo"],
      goals: (json['goalscorers'] as List?)?.map((goalJson) => GoalModel.fromJson(goalJson)).toList() ?? [], // Eğer null ise boş bir liste döndür
      cards: (json['cards'] as List?)?.map((cardJson) => CardsModel.fromJson(cardJson)).toList() ?? [], // Eğer null ise boş bir liste döndür
      statistics: (json['statistics'] as List?)?.map((statJson) => StatisticsModel.fromJson(statJson)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "event_key": eventKey,
      "event_live": eventLive,
      "event_date": eventDate,
      "event_home_team": eventHomeTeam,
      "event_away_team": eventAwayTeam,
      "event_halftime_result": eventHalftimeResult,
      "event_final_result": eventFinalResult,
      "event_status": eventStatus,
      "leauge_key": leaugeKey,
      "league_name": leaugeName,
      "leauge_round": leaugeRound,
      "home_team_logo": homeTeamLogo,
      "away_team_logo": awayTeamLogo,
      "league_logo": leaugeLogo,
      "goals": goals?.map((goal) => goal.toJson()).toList(),
      "cards": cards?.map((card) => card.toJson()).toList(),
      "statistics": statistics?.map((stat) => stat.toJson()).toList(),
    };
  }
}

class GoalModel {
  final String time;
  final String homeScorer;
  final String score;
  final String awayScorer;
  final String infoTime;

  GoalModel({
    required this.time,
    required this.homeScorer,
    required this.score,
    required this.awayScorer,
    required this.infoTime,
  });

  GoalModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        homeScorer = json['home_scorer'],
        score = json['score'],
        awayScorer = json['away_scorer'],
        infoTime = json['info_time'] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "home_scorer": homeScorer,
      "score": score,
      "away_scorer": awayScorer,
      "info_time": infoTime,
    };
  }
}

class CardsModel {
  final String time;
  final String card;
  final String homeFault;
  final String awayFault;
  final String infoTime;

  CardsModel({
    required this.time,
    required this.card,
    required this.homeFault,
    required this.awayFault,
    required this.infoTime,
  });

  CardsModel.fromJson(Map<String, dynamic> json)
      : time = json['time'],
        card = json['card'],
        homeFault = json['home_fault'],
        awayFault = json['away_fault'],
        infoTime = json['info_time'] ?? "";

  Map<String, dynamic> toJson() {
    return {
      "time": time,
      "card": card,
      "home_fault": homeFault,
      "away_fault": awayFault,
      "info_time": infoTime,
    };
  }
}

class StatisticsModel {
  final String type;
  final String home;
  final String away;

  StatisticsModel({
    required this.type,
    required this.home,
    required this.away,
  });

  StatisticsModel.fromJson(Map<String, dynamic> json)
      : type = json['type'],
        home = json['home'],
        away = json['away'];

  Map<String, dynamic> toJson() {
    return {
      "type": type,
      "home": home,
      "away": away,
    };
  }
}
