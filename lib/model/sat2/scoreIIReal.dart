class ScoreIIReal {
  final String dbTableName = 'scoreIIReal';
  final String dbId = 'id';
  final String dbScore = 'score';
  final String dbSubject = 'subject';
  final String dbDate = 'date';
  final String dbNote = 'note';

  int id;
  int score;
  String subject;
  String date;
  String note;

  ScoreIIReal.db();
  ScoreIIReal( this.score, this.subject, this.date,
      this.note);
  ScoreIIReal.withId(this.id, this.score, this.subject, this.date,
      this.note);

  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map[dbId] = id;
    }
    map[dbScore] = score;
    map[dbSubject] = subject;
    map[dbDate] = date;
    map[dbNote] = note;
    return map;
  }

  ScoreIIReal.fromMapObject(Map<String, dynamic> map) {
    this.id = map[dbId];
    this.score = map[dbScore];
    this.subject = map[dbSubject];
    this.date = map[dbDate];
    this.note = map[dbNote];
  }

}

