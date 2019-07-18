import 'player.dart';
import 'package:flutter/material.dart';

class PlayerList{
  static int maxPlayers = 100;
  static int minPlayers = 2;
  static int maxScore = 999;
  static int minScore = -999;
  List<Player> _players = List();

  //undos
  Player trash;
  int trashIndex;
  int scoreTrash;
  int scoreIndex;
  
  PlayerList(){
    addPlayer();
    addPlayer();
  }

  PlayerList.clone(PlayerList players){
    List<Player> clone = players._getList();
    for(var x in clone){
      this._players.add(x);
    }
  }

  List<Player> _getList(){
    return _players;
  }

  int getScore(int index) => _players[index].score;
  int size() => _players.length;
  String getName(int index) => _players[index].name;
  TextEditingController getCtr(int index) => _players[index].ctr;
  void savePlayerName(String name, int index) => _players[index].name = name;

  void resetPlayer(int index){
    scoreTrash = _players[index].score;
    scoreIndex = index;
    _players[index].score = 0;
  }

  void undoResetPlayer(){
     _players[scoreIndex].score = scoreTrash;
  }

  bool addPlayer(){
    if(_players.length < maxPlayers){
      _players.add(Player('Player ${_players.length+1}'));
      return true;
    }
    return false;
  }

  bool removePlayer(int index){
    if(_players.length > minPlayers){
      trash = _players[index];
      trashIndex = index;
      _players.removeAt(index);
      return true;
    }
    return false;
  }

  void undoPlayer(){
    _players.insert(trashIndex, trash);
  }

  bool incScore(int index){
    if(_players[index].score < maxScore){
      _players[index].score++;
      return true;
    }
    return false;
  }
  bool decScore(int index){
    if(_players[index].score > minScore){
      _players[index].score--;
      return true;
    }
    return false;
      
  }

  void flush(){
    for(var x in _players){
      x.ctr.clear();
    }
  }

  void sort(){
    _players.sort((a, b) => b.score.compareTo(a.score));
  }
}