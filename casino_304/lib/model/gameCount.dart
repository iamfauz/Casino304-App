
class GameCount {
  String gamesplayed;

  GameCount({this.gamesplayed});

  GameCount.fromJson(Map<String, dynamic> json) {
    gamesplayed = json['gamesplayed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gamesplayed'] = this.gamesplayed;
    return data;
  }
}




