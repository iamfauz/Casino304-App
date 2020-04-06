
import 'package:casino_304/model/totalRake.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;



class TotalRakeListPage extends StatefulWidget {
  TotalRakeListPage({Key key}) : super(key: key);
  @override
  _TotalRakeListPageState createState() => _TotalRakeListPageState();
}

class _TotalRakeListPageState extends State<TotalRakeListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Total Rake Per Date'),
        ),
        body: TotalRakeListView());
  }
}



class TotalRakeListView extends StatelessWidget {
  TotalRakeListView({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<TotalRake>>(
      future: _fetchTotalRakeInfo(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<TotalRake> data = snapshot.data;
          return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return TotalRakeRow(
                  rake: data[index],
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


Future<List<TotalRake>> _fetchTotalRakeInfo() async {
  final totalRakeAPIUrl = 'http://10.0.2.2:3000/aggregate/total_rake_by_date';
  final response = await http.get(totalRakeAPIUrl);

  if (response.statusCode == 200) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((rake) => new TotalRake.fromJson(rake)).toList();
  } else {
    throw Exception('Failed to load rakes from API');
  }
}


class TotalRakeRow extends StatelessWidget {
  TotalRakeRow({Key key, this.rake}) : super(key: key);

  final TotalRake rake;
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
                Text(rake.gameDate,
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
                Text(rake.totalrake.toString(),
                    style: TextStyle(fontSize: 16, color: Colors.black87))
              ]),
            ),
           
          ],
        ),
      ),
    );
  }
}
