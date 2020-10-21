class ScoreIPractice{
  final String dbTableName = 'scoreIPractice';
  final String dbId = 'id';
  final String dbReadingScore = 'reading_score';
  final String dbWritingScore = 'writing_score';
  final String dbMathWithNoCalcScore = 'mathNoCalc_score';
  final String dbMathCalcScore = 'mathCalc_score';
  final String dbDate = 'date';
  final String dbNote = 'note';
  int _id;
  int _readingScore;
  int _writingScore;
  int _mathNoCalcScore;
  int _mathCalcScore;
  String _date;
  String _note;

  ScoreIPractice.db();
  ScoreIPractice( this._readingScore, this._writingScore, this._date, this._mathNoCalcScore,
      this._mathCalcScore, this._note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (_id != null) {
      map['id'] = _id;
    }
    map['reading_score'] = _readingScore;
    map['writing_score '] = _writingScore;
    map['mathNoCalc_score'] = _mathNoCalcScore;
    map['mathCalc_score'] = _mathCalcScore;
    map['date'] = _date;
    map['note'] = _note;
    return map;
  }

  // Extract a Note object from a Map object
  ScoreIPractice.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._readingScore = map['reading_score'];
    this._writingScore = map['writing_score '];
    this._mathNoCalcScore = map['mathNoCalc_score'];
    this._mathCalcScore = map['mathCalc_Score'];
    this._date = map['date'];
    this._note = map['note'];
  }

  String get note => _note;

  set note(String value) {
    _note = value;
  }

  String get date => _date;

  set date(String value) {
    _date = value;
  }

  int get mathCalcScore => _mathCalcScore;

  set mathCalcScore(int value) {
    _mathCalcScore = value;
  }

  int get mathNoCalcScore => _mathNoCalcScore;

  set mathNoCalcScore(int value) {
    _mathNoCalcScore = value;
  }

  int get writingScore => _writingScore;

  set writingScore(int value) {
    _writingScore = value;
  }

  int get readingScore => _readingScore;

  set readingScore(int value) {
    _readingScore = value;
  }

  int get id => _id;

  set id(int value) {
    _id = value;
  }
}