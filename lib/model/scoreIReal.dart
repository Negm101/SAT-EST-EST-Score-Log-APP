class ScoreIReal {
  final String dbTableName = 'scoreIReal';
  final String dbId = 'id';
  final String dbEnglishScore = 'english_score';
  final String dbMathScore = 'math_score';
  final String dbDate = 'date';
  final String dbTestType = 'test_type';
  final String dbNote = 'note';

  int id;
  int englishScore;
  int mathScore;
  String date;
  String type;
  String note;
  
  ScoreIReal.db();
  ScoreIReal( this.englishScore, this.mathScore, this.date, this.type,
      this.note);
  ScoreIReal.withId(this.id, this.englishScore, this.mathScore, this.date, this.type,
      this.note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map[dbId] = id;
    }
    map[dbEnglishScore] = englishScore;
    map[dbMathScore] = mathScore;
    map[dbDate] = date;
    map[dbTestType] = type;
    map[dbNote] = note;
    return map;
  }

  ScoreIReal.fromMapObject(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.englishScore = map[dbEnglishScore];
    this.mathScore = map[dbMathScore];
    this.date = map[dbDate];
    this.type = map[dbTestType];
    this.note = map[dbNote];
  }
  
}

