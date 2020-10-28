class ActPractice{
  final String dbTableName = 'actPractice';
  final String dbId = 'id';
  final String dbEnglishScore = 'english_score';
  final String dbMathScore = 'math_score';
  final String dbReadingScore = 'reading_score';
  final String dbScienceScore = 'science_score';
  final String dbDate = 'date';
  final String dbNote = 'note';
  int id;
  int englishScore;
  int mathScore;
  int readingScore;
  int scienceScore;
  String date;
  String note;

  ActPractice.db();
  ActPractice( this.englishScore, this.mathScore, this.date, this.readingScore,
      this.scienceScore, this.note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = id;
    }
    map[dbEnglishScore] = englishScore;
    map[dbMathScore] = mathScore;
    map[dbReadingScore] = readingScore;
    map[dbScienceScore] = scienceScore;
    map[dbDate] = date;
    map[dbNote] = note;
    return map;
  }

  // Extract a Note object from a Map object
  ActPractice.fromMapObject(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.englishScore = map[dbEnglishScore];
    this.mathScore = map[dbMathScore];
    this.readingScore = map[dbReadingScore];
    this.scienceScore = map[dbScienceScore];
    this.date = map[dbDate];
    this.note = map[dbNote];
  }
}