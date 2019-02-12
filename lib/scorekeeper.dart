import 'package:flutter/material.dart';
import 'player.dart';
import 'results.dart';
import "package:flutter_slidable/flutter_slidable.dart";



class ScoreKeeper extends StatefulWidget {
  @override
  ScoreKeeperState createState() => ScoreKeeperState();
}

class ScoreKeeperState extends State<ScoreKeeper> {

  final int maxPlayers = 100;
  List<Player> players = List();
  List<TextEditingController> ctr = List();

  ScoreKeeperState(){
    players.add(Player("Player 1"));
    players.add(Player("Player 2"));
    ctr.add(TextEditingController());
    ctr.add(TextEditingController());
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
                        onPressed: () => addPlayer(players.length+1),
                     ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
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
                        onTap:() => deletePlayer(position),
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
    Player p = players[position];
    return ListTile(
      title: ListTile(
        title: TextField(
          controller: ctr[position],
          style: TextStyle(color: Colors.white70, fontSize: 20),
          onChanged:(value) => savePlayerName(value,position),
          onSubmitted: (value){
            setState(() {
             for(TextEditingController x in ctr){
               x.clear();
             } 
            });
          },
          decoration: InputDecoration(
            hintText: "${p.getName()}",
            hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            border: InputBorder.none,
          ),
        ),
        trailing: Text(
          "${p.getScore()}",
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
        builder: (context) => Results(players),
      )
    );
  }

  reset(){
    setState(() {
      players.clear();
      players.add(Player("Player 1"));
      players.add(Player("Player 2"));
      ctr.add(TextEditingController());
      ctr.add(TextEditingController());
    });
  }

  addPlayer(int position)
  {
    if(players.length >= maxPlayers)
      return;

    setState(() {
      players.add(Player("Player $position"));
      ctr.add(TextEditingController());
    });
  }
  deletePlayer(int position){
    setState(() {
     players.removeAt(position); 
     ctr.removeAt(position);
    });
  }
  resetPlayer(int position){
    setState(() {
     players[position].reset(); 
    });
  }
  decScore(int position){
    setState(() {
     players[position].decScore();
    });
  }

  incScore(int position){
    setState(() {
     players[position].incScore(); 
    });
  }

  savePlayerName(String value, int position){
    players[position].setName(value);
  }
}
