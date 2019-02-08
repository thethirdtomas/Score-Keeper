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
              margin: EdgeInsets.only(left: 10, right: 10, top:30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.settings_backup_restore,color: Colors.white70), 
                    iconSize: 30,
                  ),
                  IconButton(
                    icon: Icon(Icons.add, color: Colors.white70,),
                    iconSize: 30,
                  )
                ],
              ),
            ),
            _buildTile(),
            _buildTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildTile(){
    return ListTile(
      title: Text("Test"),
      leading: Icon(Icons.remove_circle_outline, size: 50, color: Colors.white70,),
      trailing: Icon(Icons.add_circle_outline, size: 50, color: Colors.white70,),
    );
  }
}