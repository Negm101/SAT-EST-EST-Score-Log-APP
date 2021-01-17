class ScoreIPractice{
  final String dbTableName = 'scoreIPractice';
  final String dbId = 'id';
  final String dbReadingScore = 'reading_score';
  final String dbWritingScore = 'writing_score';
  final String dbMathWithNoCalcScore = 'mathNoCalc_score';
  final String dbMathCalcScore = 'mathCalc_score';
  final String dbDate = 'date';
  final String dbNote = 'note';
  int id;
  int readingScore;
  int writingScore;
  int mathNoCalcScore;
  int mathCalcScore;
  String date;
  String note;

  ScoreIPractice.db();
  ScoreIPractice( this.readingScore, this.writingScore, this.date, this.mathNoCalcScore,
      this.mathCalcScore, this.note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map[dbReadingScore] = readingScore;
    map[dbWritingScore] = writingScore;
    map[dbMathWithNoCalcScore] = mathNoCalcScore;
    map[dbMathCalcScore] = mathCalcScore;
    map[dbDate] = date;
    map[dbNote] = note;
    return map;
  }

  // Extract a Note object from a Map object
  ScoreIPractice.fromMapObject(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.readingScore = map[dbReadingScore];
    this.writingScore = map[dbWritingScore];
    this.mathNoCalcScore = map[dbMathWithNoCalcScore];
    this.mathCalcScore = map[dbMathCalcScore];
    this.date = map[dbDate];
    this.note = map[dbNote];
  }
}