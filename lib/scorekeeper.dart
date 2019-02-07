import 'package:flutter/material.dart';

class ScoreKeeper extends StatefulWidget {
  @override
  ScoreKeeperState createState() => ScoreKeeperState();
}

class ScoreKeeperState extends State<ScoreKeeper> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.blueGrey,
        margin: EdgeInsets.all(30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           Container(
             color: Colors.red,
             child:Column(
               children: <Widget>[
                 Text("Column Container 1"),
               ],
             )
           ),
           Container(
             color: Colors.pink,
             child:Column(
               children: <Widget>[
                 Text("Column Container 2")
               ],
             )
           ),
          ],
        ),
      )
    );
  }
}