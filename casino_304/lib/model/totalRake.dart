class TotalRake {
  String gameDate;
  int totalrake;

  TotalRake({this.gameDate, this.totalrake});

  TotalRake.fromJson(Map<String, dynamic> json) {
    gameDate = json['game_date'];
    totalrake = json['totalrake'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_date'] = this.gameDate;
    data['totalrake'] = this.totalrake;
    return data;
  }
}