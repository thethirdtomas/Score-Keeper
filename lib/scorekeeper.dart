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
  PlayerList trash; 
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  ScoreKeeperState() {
    players = PlayerList();
  } 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
        child: SafeArea(
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

  void _alert(String value, int time){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("$value"),
      duration: Duration(milliseconds:time),
    ),);
  }

  void _undoAlert(String value, int type){
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text("$value"),
      action: SnackBarAction(
        label: 'undo',
        onPressed: (){
          if(type == 0)
            undoPlayer();
          else if(type == 1)
            undoScore();
          else if(type == 2)
            undoList();
        },
        
      ),
    ),);
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
      trash = players;
      players = PlayerList();
      _undoAlert("scorekeeper reset", 2);
    });
  }

  addPlayer() {
    setState(() {
      if(players.addPlayer()){
        _alert("new player added", 250);
      }
      else{
        _alert("${PlayerList.maxPlayers} player maximum", 1000);
      }
    });
  }
  removePlayer(int index){
    String name = players.getName(index);
    setState(() {
      if(players.removePlayer(index)){
         _undoAlert("$name removed", 0);
      }
      else{
        _alert("${PlayerList.minPlayers} player minimum", 1000);
      }
    });
  }
  resetPlayer(int index){
    String name = players.getName(index);
    setState(() {
     players.resetPlayer(index);
     _undoAlert("$name's score reset", 1);
    });
  }
  decScore(int index){
    setState(() {
     if(!players.decScore(index)){
       _alert("minimum score ${PlayerList.minScore}", 1000);
     }
    });
  }

  incScore(int index){
    setState(() {
     if(!players.incScore(index)){
       _alert("maximum score ${PlayerList.maxScore}", 1000);
     }
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

  undoPlayer(){
    setState(() {
     players.undoPlayer(); 
    });
  }

  undoScore(){
    setState(() {
     players.undoResetPlayer(); 
    });
  }

  undoList(){
    setState(() {
     players = trash; 
    });
  }
}
