class SettingsModel {
  final String dbTableName = 'Settings';
  final String dbId = 'id';
  final String dbIsSatEnabled = 'isSatEnabled';
  final String dbISat2Enabled = 'isSat2Enabled';
  final String dbIsActEnabled = 'isActEnabled';
  final String dbIsDarkModeEnabled = 'isDarkModeEnabled';
  final String dbIsGraphsEnabled = 'isGraphsEnabled';
  int id;
  int isSatEnabled;
  int isSat2Enabled;
  int isActEnabled;
  int isDarkModeEnabled;
  int isGraphsEnabled;

  SettingsModel.db();

  SettingsModel(this.id, this.isSatEnabled, this.isSat2Enabled,
      this.isActEnabled, this.isDarkModeEnabled, this.isGraphsEnabled);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map[dbIsSatEnabled] = isSatEnabled;
    map[dbISat2Enabled] = isSat2Enabled;
    map[dbIsActEnabled] = isActEnabled;
    map[dbIsDarkModeEnabled] = isDarkModeEnabled;
    map[dbIsGraphsEnabled] = isGraphsEnabled;
    return map;
  }

  SettingsModel.fromMapObject(Map<String, dynamic> map) {
    this.isSatEnabled = map[dbIsSatEnabled];
    this.isSat2Enabled = map[dbISat2Enabled];
    this.isActEnabled = map[dbIsActEnabled];
    this.isDarkModeEnabled = map[dbIsDarkModeEnabled];
    this.isGraphsEnabled = map[dbIsGraphsEnabled];
  }
}
