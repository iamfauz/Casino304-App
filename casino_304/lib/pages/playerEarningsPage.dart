import 'package:casino_304/model/playerEarning.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;


class PlayerEarningListPage extends StatefulWidget {
  PlayerEarningListPage({Key key, this.playerId}) : super(key: key);
  final String playerId;
  @override
  _PlayerEarningListPageState createState() => _PlayerEarningListPageState();
}

class _PlayerEarningListPageState extends State<PlayerEarningListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Player Earnings'),
        ),
        body: PlayerEarningsListView(playerId: widget.playerId));
  }
}

class PlayerEarningsListView extends StatelessWidget {
  PlayerEarningsListView({Key key, this.playerId}) : super(key: key);
  final String playerId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<PlayerEarning>>(
      future: _fetchPlayerEarnings(playerId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<PlayerEarning> data = snapshot.data;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return PlayerEarningsRow(
                  playerEarning: data[index],
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


class PlayerIdFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Casino304'),
        ),
        body: Column(
          children: <Widget>[
            PlayerIdEntry(),
          ],
        ));
  }
}

class PlayerIdEntry extends StatefulWidget {
  @override
  _PlayerIdEntryState createState() => _PlayerIdEntryState();
}


class _PlayerIdEntryState extends State<PlayerIdEntry> {
  final textController = TextEditingController();
  String playerId;

  @override
  void initState() {
    playerId = "";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: textController,
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter player ID'),
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => PlayerEarningListPage(
                          playerId: textController.text,
                        )),
              );
            },
            child: const Text('Show earnings',
                style: TextStyle(fontSize: 15, color: Colors.white)),
          )
        ],
      ),
    );
  }
}



Future<List<PlayerEarning>> _fetchPlayerEarnings(String playerId) async {
  final playerEarningAPIUrl =
      'http://10.0.2.2:3000/gameplays/player?player_id=$playerId';
  final response = await http.get(playerEarningAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse
        .map((playerEarning) => new PlayerEarning.fromJson(playerEarning))
        .toList();
  } else {
    throw Exception('Failed to Earnings from API');
  }
}

class PlayerEarningsRow extends StatelessWidget {
  PlayerEarningsRow({Key key, this.playerEarning}) : super(key: key);

  final PlayerEarning playerEarning;
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
                Text("Date: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(playerEarning.gameDate,
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Starting Stack: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(playerEarning.startingstack.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Ending Stack ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(playerEarning.endingstack.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Profit: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(playerEarning.profit.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
