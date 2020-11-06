class SettingsModel {
  final String dbTableName = 'Settings';
  final String dbIsSatEnabled = 'isSatEnabled';
  final String dbISat2Enabled = 'isSat2Enabled';
  final String dbIsActEnabled = 'isActEnabled';
  final String dbIsDarkModeEnabled = 'isDarkModeEnabled';
  final String dbDate = 'date';
  final String dbNote = 'note';
  int id;
  int englishScore;
  int mathScore;
  int readingScore;
  int scienceScore;
  String date;
  String note;

  SettingsModel.db();

  SettingsModel(this.englishScore, this.mathScore, this.date, this.readingScore,
      this.scienceScore, this.note);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[dbIsSatEnabled] = englishScore;
    map[dbISat2Enabled] = mathScore;
    map[dbIsActEnabled] = readingScore;
    map[dbIsDarkModeEnabled] = scienceScore;
    map[dbDate] = date;
    map[dbNote] = note;
    return map;
  }

  // Extract a Note object from a Map object
  SettingsModel.fromMapObject(Map<String, dynamic> map) {
    this.englishScore = map[dbIsSatEnabled];
    this.mathScore = map[dbISat2Enabled];
    this.readingScore = map[dbIsActEnabled];
    this.scienceScore = map[dbIsDarkModeEnabled];
    this.date = map[dbDate];
    this.note = map[dbNote];
  }
}
