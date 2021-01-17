import 'package:score_log_app/screen/settings.dart';

DataSettings data = new DataSettings();

bool isDark = _getDarkMode();
bool isGraph = _getGraph();
bool isSat = _getSatI();
bool isSatII = _getSatII();
bool isAct = _getAct();

bool _getDarkMode() {
  if (data.settings[0].isDarkModeEnabled == 1) {
    return true;
  }
  if (data.settings[0].isDarkModeEnabled == 0) {
    return false;
  }
}

bool _getGraph() {
  if (data.settings[0].isGraphsEnabled == 1) {
    return true;
  }
  if (data.settings[0].isGraphsEnabled == 0) {
    return false;
  }
}

bool _getSatI() {
  if (data.settings[0].isSatEnabled == 1) {
    return true;
  }
  if (data.settings[0].isSatEnabled == 0) {
    return false;
  }
}

bool _getSatII() {
  if (data.settings[0].isSat2Enabled == 1) {
    return true;
  }
  if (data.settings[0].isSat2Enabled == 0) {
    return false;
  }
}

bool _getAct() {
  if (data.settings[0].isActEnabled == 1) {
    return true;
  }
  if (data.settings[0].isActEnabled == 0) {
    return false;
  }
}

void updateSettings() {
  data.updateListViewNoState();
}
