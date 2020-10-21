class ScoreIReal {
  final String dbTableName = 'scoreIReal';
  final String dbId = 'id';
  final String dbEnglishScore = 'english_score';
  final String dbMathScore = 'math_score';
  final String dbDate = 'date';
  final String dbTestType = 'test_type';
  final String dbNote = 'note';

  int _id;
  int _englishScore;
  int _mathScore;
  String _date;
  String _type;
  String _note;


  int get id => _id;

  set id(int value) {
    _id = value;
  }
  ScoreIReal.db();
  ScoreIReal( this._englishScore, this._mathScore, this._date, this._type,
      this._note);
  ScoreIReal.withId(this._id, this._englishScore, this._mathScore, this._date, this._type,
      this._note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['english_score'] = _englishScore;
    map['math_score'] = _mathScore;
    map['date'] = _date;
    map['test_type'] = _type;
    map['note'] = _note;
    return map;
  }

  // Extract a Note object from a Map object
  ScoreIReal.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._englishScore = map['english_score'];
    this._mathScore = map['math_score'];
    this._date = map['date'];
    this._type = map['test_type'];
    this._note = map['note'];
  }

  int get englishScore => _englishScore;

  set englishScore(int value) {
    _englishScore = value;
  }

  int get mathScore => _mathScore;

  set mathScore(int value) {
    _mathScore = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get note => _note;

  set note(String value) {
    _note = value;
  }
}

