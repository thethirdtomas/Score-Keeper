import 'package:flutter/material.dart';
import 'player.dart';

class ScoreKeeper extends StatefulWidget {
  @override
  ScoreKeeperState createState() => ScoreKeeperState();
}

class ScoreKeeperState extends State<ScoreKeeper> {
  
  List<Player> players = List();
  
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
                mainAxisAlignment: MainAxisAlignment.end,
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
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: players.length,
                itemBuilder: (context, position){
                  return ListTileItem(players[position]);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  reset(){
    setState(() {
      players.clear();
          
    });

  }

  addPlayer(int position)
  {
    if(players.length > 99)
      return;
      
    setState(() {
      players.add(Player("Player $position", 0));
    });
  }
}

class ListTileItem extends StatefulWidget {
  Player player;
  ListTileItem(Player player){
    this.player = player;
  }
  @override
  ListTileItemState createState() => ListTileItemState(player);
}

class ListTileItemState extends State<ListTileItem>{
  Player player;
  ListTileItemState(Player player){
    this.player = player;
  }

  @override
  Widget build(BuildContext context){
    return  ListTile(
      title: ListTile(
        title: TextField(
          style: TextStyle(color: Colors.white70, fontSize: 20),
          onChanged: savePlayerName,
          decoration: InputDecoration(
            hintText: "${player.getName()}",
            hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            border: InputBorder.none,
        
          ),
        ),
        trailing: Text(
          "${player.getScore()}",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
      ),
      leading: IconButton(
        icon: Icon(Icons.remove_circle_outline, color: Colors.white70),
        iconSize: 50,
        color: Colors.white70,
        onPressed: decScore,
      ),
      trailing: IconButton(
        icon: Icon(Icons.add_circle_outline, color: Colors.white70),
        iconSize: 50,
        color: Colors.white70,
        onPressed: incScore,
      ),
    );
  }
  decScore(){
    setState(() {
     player.decScore();
    });
  }

  incScore(){
    setState(() {
     player.incScore(); 
    });
  }

  savePlayerName(String value){
    player.setName(value);
  }
}

