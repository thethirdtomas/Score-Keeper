import 'player_list.dart';
import 'package:flutter/material.dart';
import 'results.dart';
import "package:flutter_slidable/flutter_slidable.dart";


class ScoreKeeper extends StatefulWidget {
  @override
  ScoreKeeperState createState() => ScoreKeeperState();
}

class ScoreKeeperState extends State<ScoreKeeper> {

  PlayerList players; 

  ScoreKeeperState() {
    players = PlayerList();
  } 
  @override
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.format_list_numbered,color: Colors.white70), 
                        iconSize: 30,
                        onPressed: results,
                      ),
                    ],
                  ),
                  //Text("Score Keeper", style: TextStyle(fontSize: 20,color: Colors.white70)),
                  Row(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.settings_backup_restore,color: Colors.white70), 
                        iconSize: 30,
                        onPressed: reset,
                      ),
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white70,),
                        iconSize: 30,
                        onPressed: addPlayer,
                     ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: players.size(),
                itemBuilder: (context, position){
                  return Slidable(
                    delegate: SlidableDrawerDelegate(),
                    actionExtentRatio: 0.25,
                    actions: <Widget>[
                      IconSlideAction(
                        caption: "Reset",
                        color: Colors.blueAccent,
                        icon: Icons.restore,
                        onTap: () => resetPlayer(position),
                      )
                    ],
                    secondaryActions: <Widget>[
                      IconSlideAction(
                        caption: "Delete",
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap:() => removePlayer(position),
                      )
                    ],
                    child: listItem(position)
                    
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget listItem(position){
    return ListTile(
      title: ListTile(
        title: TextField(
          controller: players.getCtr(position),
          style: TextStyle(color: Colors.white70, fontSize: 20),
          onChanged:(value) => savePlayerName(value,position),
          onSubmitted: (value) => flush,
          decoration: InputDecoration(
            hintText: "${players.getName(position)}",
            hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            border: InputBorder.none,
          ),
        ),
        trailing: Text(
          "${players.getScore(position)}",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.remove_circle_outline, color: Colors.white70),
        iconSize: 50,
        color: Colors.white70,
        onPressed:()=> decScore(position),
      ),
      trailing: IconButton(
        icon: Icon(Icons.add_circle_outline, color: Colors.white70),
        iconSize: 50,
        color: Colors.white70,
        onPressed: ()=> incScore(position),
      ),
    );
  }

  results(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Results(PlayerList.clone(players)),
      )
    );
  }

  reset(){
    setState(() {
      players = PlayerList();
    });
  }

  addPlayer() {
    setState(() {
     players.addPlayer(); 
    });
  }
  removePlayer(int index){
    setState(() {
     players.removePlayer(index);
    });
  }
  resetPlayer(int index){
    setState(() {
     players.resetPlayer(index);
    });
  }
  decScore(int index){
    setState(() {
     players.decScore(index);
    });
  }

  incScore(int index){
    setState(() {
     players.incScore(index);
    });
  }

  savePlayerName(String name, int index){
    players.savePlayerName(name, index);
  }
  
  flush(){
    setState(() {
     players.flush(); 
    });
  }
}
