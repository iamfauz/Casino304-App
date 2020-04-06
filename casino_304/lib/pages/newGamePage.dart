import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class StartNewGamePage extends StatefulWidget {
  StartNewGamePage({Key key}) : super(key: key);

  @override
  _StartNewGamePageState createState() => _StartNewGamePageState();
}

class _StartNewGamePageState extends State<StartNewGamePage> {
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  final numPlayersController = TextEditingController();
  final branchIdController = TextEditingController();
  final tableNoController = TextEditingController();
  final employeeIdController = TextEditingController();
  final tipController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Start New Game'),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(2.0),
            child: TextField(
              controller: dateController,
              decoration: InputDecoration(
                  fillColor: Colors.grey,
                  border: InputBorder.none,
                  hintText: 'Enter Start Date'),
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
              controller: timeController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Start Time'),
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
              controller: numPlayersController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter No of players'),
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
              controller: branchIdController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Branch Id'),
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
              controller: tableNoController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter table No'),
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
              controller: employeeIdController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Employee Ids'),
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
              controller: tipController,
              decoration: InputDecoration(
                  border: InputBorder.none, hintText: 'Enter Dealer Tip'),
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
                  final http.Response response = await http.post(
                    'http://10.0.2.2:3000/games',
                    headers: <String, String>{
                      'Content-Type': 'application/json; charset=UTF-8',
                    },
                    body: jsonEncode(<String, String>{
                      'startDate': dateController.text,
                      'startTime': timeController.text,
                      'numPlayers': numPlayersController.text,
                      'branchId': branchIdController.text,
                      'tableNo': tableNoController.text,
                      'employeeId': employeeIdController.text,
                      'tip': tipController.text,
                    }),
                  );

                  if (response.statusCode == 200) {
                    showDialog(
                        context: context,
                        child: new AlertDialog(
                          title: new Text("Success"),
                          content: new Text("New game has been created"),
                        ));
                  } else {
                    throw Exception('Failed to create game.');
                  }
                },
                child: const Text('Start Game',
                    style: TextStyle(fontSize: 15, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
