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
        margin: EdgeInsets.all(30),
        child: Row(
          children: <Widget>[
           Container(
             child:Column(
               children: <Widget>[
                 Text("Label"),
                 Text("Controller"),
               ],
             )
           ),
           Container(
             child:Column(
               children: <Widget>[
                 Text("Label"),
                 Text("Controller"),
               ],
             )
           ),
          ],
        ),
      )
    );
  }
}