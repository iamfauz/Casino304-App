import 'package:casino_304/model/game.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchGamesListPage extends StatefulWidget {
  SearchGamesListPage({Key key, this.date}) : super(key: key);
  final String date;
  @override
  _SearchGamesListPageState createState() => _SearchGamesListPageState();
}

class _SearchGamesListPageState extends State<SearchGamesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Games'),
        ),
        body: GamesListView(date: widget.date));
  }
}

class DateEntryFormPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Casino304'),
        ),
        body: Column(
          children: <Widget>[
            DateEntry(),
          ],
        ));
  }
}

class DateEntry extends StatefulWidget {
  @override
  _DateEntryState createState() => _DateEntryState();
}

class _DateEntryState extends State<DateEntry> {
  final textController = TextEditingController();
  String date;

  @override
  void initState() {
    date = "";
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
                border: InputBorder.none, hintText: 'Enter a date'),
          ),
          RaisedButton(
            color: Colors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SearchGamesListPage(
                          date: textController.text,
                        )),
              );
            },
            child: const Text('Filter Games By Date',
                style: TextStyle(fontSize: 15, color: Colors.white)),
          )
        ],
      ),
    );
  }
}

class GamesListView extends StatelessWidget {
  GamesListView({Key key, this.date}) : super(key: key);
  final String date;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Game>>(
      future: _fetchGames(date),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Game> data = snapshot.data;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return GamesRow(
                  game: data[index],
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

Future<List<Game>> _fetchGames(String date) async {
  final gamesAPIUrl = 'http://10.0.2.2:3000/games?game_date=$date';
  final response = await http.get(gamesAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((game) => new Game.fromJson(game)).toList();
  } else {
    throw Exception('Failed to load games from API');
  }
}

class GamesRow extends StatelessWidget {
  GamesRow({Key key, this.game}) : super(key: key);

  final Game game;
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
                Text("Game Id: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(game.id.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Date: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(game.gameDate,
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Rake Amount: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(game.rakeamount.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("Start Time: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(game.starttime,
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
              
            ),
             Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 8.0, 0.0, 0.0),
              child: Row(children: <Widget>[
                Text("End Time: ",
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w600)),
                Text(game?.endtime ?? "-",
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
              
            ),
           
          ],
        ),
      ),
    );
  }
}
