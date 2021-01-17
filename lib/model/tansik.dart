class TansikModel {
  final dbTableName = 'ALLTANSIK';
  final dbUniversity = 'UNIVERSITY';
  final dbPercent = 'PERCENT';
  final dbYear = 'YEAR';

  var university;
  var percent;
  var year;

  TansikModel.db();

  TansikModel(this.university, this.percent, this.year);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[dbUniversity] = university;
    map[dbPercent] = percent;
    map[dbYear] = year;
    return map;
  }

  TansikModel.fromMapObject(Map<String, dynamic> map) {
    this.university = map[dbUniversity];
    this.percent = map[dbPercent];
    this.year = map[dbYear];
  }
}
