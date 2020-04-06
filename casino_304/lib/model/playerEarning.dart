class PlayerEarning {
  String gameDate;
  int gameid;
  int playerid;
  int startingstack;
  int endingstack;
  int profit;

  PlayerEarning(
      {this.gameDate,
      this.gameid,
      this.playerid,
      this.startingstack,
      this.endingstack,
      this.profit});

  PlayerEarning.fromJson(Map<String, dynamic> json) {
    gameDate = json['game_date'];
    gameid = json['gameid'];
    playerid = json['playerid'];
    startingstack = json['startingstack'];
    endingstack = json['endingstack'];
    profit = json['profit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_date'] = this.gameDate;
    data['gameid'] = this.gameid;
    data['playerid'] = this.playerid;
    data['startingstack'] = this.startingstack;
    data['endingstack'] = this.endingstack;
    data['profit'] = this.profit;
    return data;
  }
}