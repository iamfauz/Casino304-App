import 'package:casino_304/pages/playerEarningsPage.dart';
import 'package:casino_304/pages/searchGamesPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Casino304',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(title: 'Casino304'),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
            crossAxisCount: 2,
            padding: EdgeInsets.all(3.0),
            children: <Widget>[
              DashBoardItem(
                title: "Search Games",
                icon: Icons.search,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DateEntryFormPage()),
                  );
                },
              ),
              DashBoardItem(title: "Statistics", icon: Icons.equalizer),
              DashBoardItem(
                  title: "Player Earnings",
                  icon: Icons.attach_money,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerIdFormPage()),
                    );
                  }),
              DashBoardItem(title: "Start New Game", icon: Icons.add),
              DashBoardItem(title: "Edit Game", icon: Icons.edit),
              DashBoardItem(title: "Delete", icon: Icons.delete_outline)
            ]),
      ),
    );
  }
}

class DashBoardItem extends StatelessWidget {
  DashBoardItem({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);
  final String title;
  final IconData icon;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 2.0,
        margin: new EdgeInsets.all(6.0),
        child: Container(
          child: new InkWell(
            onTap: () => onPressed(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.blueGrey,
                )),
                SizedBox(height: 20.0),
                new Center(
                  child: new Text(title,
                      style:
                          new TextStyle(fontSize: 18.0, color: Colors.black)),
                )
              ],
            ),
          ),
        ));
  }
}
