import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class EndNewGamePage extends StatefulWidget {
  EndNewGamePage({Key key}) : super(key: key);

  @override
  _EndNewGamePageState createState() => _EndNewGamePageState();
}

class _EndNewGamePageState extends State<EndNewGamePage> {

  final idController = TextEditingController();
  final endtimeController = TextEditingController();
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('End Game'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: idController,
              decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                  hintText: 'Enter Game Id '),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: endtimeController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter End Time'),
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
         
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: RaisedButton(
                color: Colors.green,
                onPressed: () async {
                  final http.Response response = await http.patch(
                    'http://10.0.2.2:3000/gameplays/endGame',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'endTime': endtimeController.text,
                      'gameId': idController.text,
                      
                    }),
                  );

                  if (response.statusCode == 200) {
                    showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Success"),
                          content: new Text("Gamed Ended"),
                        ));
                  } else {
                    showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Fail!"),
                          content: new Text("Gamed end fail."),
                        ));
                    throw Exception('Failed to end game.');
                  }
                },
                child: const Text('End Game',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
