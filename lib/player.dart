class Player{
  
  String _name;
  int _score;

  Player(String _name){
    this._name = _name;
    this._score = 0;
  }
  String getName(){
    return _name;
  }
  void setName(String value){
    _name = value;
  }
  int getScore(){
    return _score;
  }
  void incScore(){
    if(_score == 99)
      return;
    _score++;
  }
  void decScore(){
    if(_score == 0)
      return;
    _score--;
  }
}