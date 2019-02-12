import 'package:flutter/material.dart';

class Player{
  int score;
  String name;
  TextEditingController ctr;
  Player(this.name){
    score = 0;
    ctr = TextEditingController();
  }
}