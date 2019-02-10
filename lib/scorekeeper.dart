import 'package:flutter/material.dart';

class ScoreKeeper extends StatefulWidget {
  @override
  ScoreKeeperState createState() => ScoreKeeperState();
}

class ScoreKeeperState extends State<ScoreKeeper> {
  int itemCount = 2;

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
                    onPressed: addPlayer,
                  )
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: itemCount,
                itemBuilder: (context, position){
                  return ListTileItem(position);
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
     itemCount = 2; 
    });
  }

  addPlayer()
  {
    setState(() {
     itemCount++; 
    });
  }
}

class ListTileItem extends StatefulWidget {
  int index;
  ListTileItem(int index){
    this.index = index;
  }
  @override
  ListTileItemState createState() => ListTileItemState(index);
}

class ListTileItemState extends State<ListTileItem>{
  int score = 0;
  int playerNumber;

  ListTileItemState(int index){
    playerNumber = index+1;
  }

  @override
  Widget build(BuildContext context){
    return  ListTile(
      title: ListTile(
        title: TextField(
          style: TextStyle(color: Colors.white70, fontSize: 20),
          decoration: InputDecoration(
            hintText: "Player $playerNumber",
            hintStyle: TextStyle(color: Colors.white70, fontSize: 20),
            border: InputBorder.none,
        
          ),
        ),
        trailing: Text(
          "$score",
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
    if(score == 0)
      return;
    setState(() {
    score--; 
    });
  }

  incScore(){
    setState(() {
     score++; 
    });
  }
}

