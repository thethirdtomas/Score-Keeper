import 'package:flutter/material.dart';
import 'player.dart';

class Results extends StatelessWidget{
  List<Player>players;
   @override
  Results(List<Player>players){
    this.players = players;
    this.players.sort((a, b) => b.getScore().compareTo(a.getScore()));
  }
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF5f2c82), Color(0xFF49a09d)],
            begin: FractionalOffset.topLeft,
            end: FractionalOffset.bottomRight,
            stops: [0.0, 1.0],
            tileMode: TileMode.repeated,
          )
        ),
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top:30, bottom: 0),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white70), 
                    iconSize: 30,
                    onPressed: () => Navigator.pop(context),
                  ),
                  Text(
                    "Results",
                    style: TextStyle(
                    fontSize: 25,
                    color: Colors.white70,
                    ),
                  )
                ],
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, position){
                  return ListTile(
                    leading: Text(
                      "${position+1}.",
                      style: TextStyle(color: Colors.white, fontSize: 35)
                      ),
                    trailing: Text(
                      "${players[position].getScore()}",
                      style: TextStyle(color: Colors.white, fontSize: 30)
                      ),
                    title: Text(
                      "${players[position].getName()}",
                      style: TextStyle(color: Colors.white70, fontSize: 25)
                      ),
                  );
                },
              ),
            )
          ],
        ),
      )
    );
  }
}