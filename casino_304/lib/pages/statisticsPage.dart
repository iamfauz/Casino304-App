import 'package:casino_304/model/gameCount.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class PlayerFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Casino304'),
        ),
        body: Column(
          children: <Widget>[
            PlayerEntry(),
          ],
        ));
  }
}

class PlayerEntry extends StatefulWidget {
  @override
  _PlayerEntryState createState() => _PlayerEntryState();
}


class _PlayerEntryState extends State<PlayerEntry> {
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
                    builder: (context) => GameCountPage(
                          playerId: textController.text,
                        )),
              );
            },
            child: const Text('Show no games played',
                style: TextStyle(fontSize: 15, color: Colors.white)),
          )
        ],
      ),
    );
  }
}


class GameCountPage extends StatefulWidget {
  GameCountPage({Key key, this.playerId}) : super(key: key);
  final String playerId;
  @override
  _GameCountPageState createState() => _GameCountPageState();
}

class _GameCountPageState extends State<GameCountPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Games Played'),
        ),
        body: GamesCountView(playerId: widget.playerId));
  }
}



class GamesCountView extends StatelessWidget {
  GamesCountView({Key key, this.playerId}) : super(key: key);
  final String playerId;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<GameCount>(
      future: _fetchGameCount(playerId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          GameCount data = snapshot.data;
          return Card(child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(children: <Widget>[
                Text("Total Games Played: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(data.gamesplayed.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
          ));
              
              
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

Future<GameCount> _fetchGameCount(String id) async {
  final gamesAPIUrl = 'http://10.0.2.2:3000/aggregate/total_games?player_id=$id';
  final response = await http.get(gamesAPIUrl);

  if (response.statusCode == 200) {
     
    return new GameCount.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load from API');
  }
}