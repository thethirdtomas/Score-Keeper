import 'player.dart';
import 'package:flutter/material.dart';

class PlayerList{
  final int maxPlayers = 100;
  final int minPlayers = 2;
  final int maxScore = 100;
  final int minScore = 0;
  List<Player> _players = List();
  
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
  void resetPlayer(int index) => _players[index].score = 0;

  void addPlayer(){
    if(_players.length < maxPlayers){
      _players.add(Player('Player ${_players.length+1}'));
    }
  }

  void removePlayer(int index){
    if(_players.length > minPlayers){
      _players.removeAt(index);
    }
  }

  void incScore(int index){
    if(_players[index].score < maxScore)
      _players[index].score++;
  }
  void decScore(int index){
    if(_players[index].score > minScore)
      _players[index].score--;
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