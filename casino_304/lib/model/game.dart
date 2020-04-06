

class Game {
  int id;
  String gameDate;
  String starttime;
  String endtime;
  int noofplayers;
  int rakeamount;
  int branchid;
  int tableNo;
  int employeeid;
  int tip;

  Game(
      {this.id,
      this.gameDate,
      this.starttime,
      this.endtime,
      this.noofplayers,
      this.rakeamount,
      this.branchid,
      this.tableNo,
      this.employeeid,
      this.tip});

  Game.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gameDate = json['game_date'];
    starttime = json['starttime'];
    endtime = json['endtime'];
    noofplayers = json['noofplayers'];
    rakeamount = json['rakeamount'];
    branchid = json['branchid'];
    tableNo = json['table_no'];
    employeeid = json['employeeid'];
    tip = json['tip'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['game_date'] = this.gameDate;
    data['starttime'] = this.starttime;
    data['endtime'] = this.endtime;
    data['noofplayers'] = this.noofplayers;
    data['rakeamount'] = this.rakeamount;
    data['branchid'] = this.branchid;
    data['table_no'] = this.tableNo;
    data['employeeid'] = this.employeeid;
    data['tip'] = this.tip;
    return data;
  }
}