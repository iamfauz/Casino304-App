import 'package:casino_304/model/leaderBoard.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class LeaderBoardPage extends StatefulWidget {
  LeaderBoardPage({Key key}) : super(key: key);
  @override
  _LeaderBoardPageState createState() => _LeaderBoardPageState();
}

class _LeaderBoardPageState extends State<LeaderBoardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('LeaderBoard'),
        ),
        body: LeaderBoardListView());
  }
}


class LeaderBoardListView extends StatelessWidget {
  LeaderBoardListView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<LeaderBoard>>(
      future: _fetchLeaderBoard(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<LeaderBoard> data = snapshot.data;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return LeaderBoardRow(
                  player: data[index],
                );
              });
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}


Future<List<LeaderBoard>> _fetchLeaderBoard() async {
  final url = 'http://10.0.2.2:3000/gameplays/leaderBoards';
  final response = await http.get(url);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((leader) => new LeaderBoard.fromJson(leader)).toList();
  } else {
    throw Exception('Failed to players from API');
  }
}


class LeaderBoardRow extends StatelessWidget {
  LeaderBoardRow({Key key, this.player}) : super(key: key);

  final LeaderBoard player;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
           
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("PlayerId ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(player.id.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Name: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(player.name,
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
           
          ],
        ),
      ),
    );
  }
}
