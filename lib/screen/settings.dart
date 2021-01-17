import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_tile_switch/list_tile_switch.dart';
import 'package:score_log_app/model/settingsModel.dart';
import 'package:score_log_app/screen/settings/about.dart';
import 'package:score_log_app/services/database.dart';
import 'package:score_log_app/services/generalVar.dart';
import 'package:score_log_app/services/globalVar.dart' as global;
import 'package:sqflite/sqflite.dart';
import 'package:url_launcher/url_launcher.dart';

class Setting extends StatefulWidget {
  final SettingsModel settings;

  Setting(this.settings);

  @override
  State<StatefulWidget> createState() {
    return SettingState(this.settings);
  }
}

class SettingState extends State<Setting> {
  SettingsModel settings;
  DatabaseHelper database = new DatabaseHelper();
  DataSettings data = new DataSettings();

  SettingState(this.settings);

  bool _isGraphOn;
  bool _isDarkModeOn;
  bool _isSatEnabled;
  bool _isSat2Enabled;
  bool _isActEnabled;

  @override
  Widget build(BuildContext context) {
    data.autoRefresh(setState);
    getData();

    return Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_sharp),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*ListTileSwitch(
                value: _isDarkModeOn,
                autoFocus: false,
                //toggleSelectedOnValueChange: true,
                onChanged: (value) {
                  setState(() {
                    _isDarkModeOn = value;
                    _setDarkMode();
                    _update();
                    data.getData(setState);
                    _printSettings();
                  });
                },
                switchActiveColor: MyColors.primary(),
                title: Text('Dark Mode'),
              ),*/
              ListTileSwitch(
                value: _isGraphOn,
                autoFocus: false,
                //toggleSelectedOnValueChange: true,
                onChanged: (value) {
                  setState(() {
                    _isGraphOn = value;
                    _setGraph();
                    _update();
                    data.getData(setState);
                    _printSettings();
                  });
                },
                subtitle: Text('Keep graphs on by default'),
                switchActiveColor: MyColors.primary(),
                title: Text('Graphs'),
              ),
              Divider(
                color: MyColors.black(),
                height: 0,
              ),
              ListTile(
                title: Text(
                  'Score Lists',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                subtitle: Text('UnChecking a box will not delete it\'s data'),
              ),
              CheckboxListTile(
                tristate: false,
                autofocus: false,
                title: Text('SAT I'),
                controlAffinity: ListTileControlAffinity.trailing,
                value: _isSatEnabled,
                onChanged: (value) {
                  setState(() {
                    _isSatEnabled = value;
                    _setSatI();
                    _update();
                    data.getData(setState);
                    _printSettings();
                  });
                },
              ),
              CheckboxListTile(
                tristate: false,
                autofocus: false,
                title: Text('SAT II'),
                controlAffinity: ListTileControlAffinity.trailing,
                value: _isSat2Enabled,
                onChanged: (value) {
                  setState(() {
                    _isSat2Enabled = value;
                    _setSatII();
                    _update();
                    data.getData(setState);
                    _printSettings();
                  });
                },
              ),
              CheckboxListTile(
                tristate: false,
                autofocus: false,
                title: Text('ACT'),
                controlAffinity: ListTileControlAffinity.trailing,
                value: _isActEnabled,
                onChanged: (value) {
                  setState(() {
                    _isActEnabled = value;
                    _setAct();
                    _update();
                    data.getData(setState);
                    _printSettings();
                  });
                },
              ),
              Divider(
                color: MyColors.black(),
                height: 0,
              ),
              ListTile(
                //enabled: false,
                title: Text('Review on Play Store'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  _launchURL();
                },
              ),
              Divider(
                color: MyColors.black(),
                height: 0,
              ),
              ListTile(
                //enabled: false,
                title: Text('About Calculators'),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.of(context, rootNavigator: true).push(
                    new CupertinoPageRoute<bool>(
                      fullscreenDialog: false,
                      builder: (BuildContext context) => new About(),
                    ),
                  );
                },
              ),
              Divider(
                color: MyColors.black(),
                height: 0,
              ),
            ],
          ),
        ));
  }

  _launchURL() async {
    const url =
        'https://play.google.com/store/apps/details?id=com.score_log_app';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _setDarkMode() {
    setState(() {
      if (_isDarkModeOn == true) {
        settings.isDarkModeEnabled = 1;
      }
      if (_isDarkModeOn == false) {
        settings.isDarkModeEnabled = 0;
      }
    });
  }

  void _setGraph() {
    setState(() {
      if (_isGraphOn == true) {
        settings.isGraphsEnabled = 1;
      }
      if (_isGraphOn == false) {
        settings.isGraphsEnabled = 0;
      }
    });
  }

  void _setSatI() {
    if (_isSatEnabled == true) {
      settings.isSatEnabled = 1;
    }
    if (_isSatEnabled == false) {
      settings.isSatEnabled = 0;
    }
  }

  void _setSatII() {
    if (_isSat2Enabled == true) {
      settings.isSat2Enabled = 1;
    }
    if (_isSat2Enabled == false) {
      settings.isSat2Enabled = 0;
    }
  }

  void _setAct() {
    if (_isActEnabled == true) {
      settings.isActEnabled = 1;
    }
    if (_isActEnabled == false) {
      settings.isActEnabled = 0;
    }
  }

  void _getDarkMode() {
    setState(() {
      if (data.settings[0].isDarkModeEnabled == 1) {
        _isDarkModeOn = true;
      }
      if (data.settings[0].isDarkModeEnabled == 0) {
        _isDarkModeOn = false;
      }
    });
  }

  void _getGraph() {
    setState(() {
      if (data.settings[0].isGraphsEnabled == 1) {
        _isGraphOn = true;
      }
      if (data.settings[0].isGraphsEnabled == 0) {
        _isGraphOn = false;
      }
    });
  }

  void _getSatI() {
    setState(() {
      if (data.settings[0].isSatEnabled == 1) {
        _isSatEnabled = true;
      }
      if (data.settings[0].isSatEnabled == 0) {
        _isSatEnabled = false;
      }
    });
  }

  void _getSatII() {
    setState(() {
      if (data.settings[0].isSat2Enabled == 1) {
        _isSat2Enabled = true;
      }
      if (data.settings[0].isSat2Enabled == 0) {
        _isSat2Enabled = false;
      }
    });
  }

  void _getAct() {
    setState(() {
      if (data.settings[0].isActEnabled == 1) {
        _isActEnabled = true;
      }
      if (data.settings[0].isActEnabled == 0) {
        _isActEnabled = false;
      }
    });
  }

  void getData() {
    _getGraph();
    _getDarkMode();
    _getAct();
    _getSatI();
    _getSatII();
  }

  void _printSettings() {
    debugPrint('-------Settings--------');
    debugPrint('| Dark Mode: ' +
        data.settings[0].isDarkModeEnabled.toString() +
        ', ' +
        _isDarkModeOn.toString() +
        ', ' +
        global.isDark.toString() +
        getWall(_isDarkModeOn));
    debugPrint('| Graphs   : ' +
        data.settings[0].isGraphsEnabled.toString() +
        ', ' +
        _isGraphOn.toString() +
        ', ' +
        global.isGraph.toString() +
        getWall(_isGraphOn));
    debugPrint('| SAT I    : ' +
        data.settings[0].isSatEnabled.toString() +
        ', ' +
        _isSatEnabled.toString() +
        ', ' +
        global.isSat.toString() +
        getWall(_isSatEnabled));
    debugPrint('| SAT II   : ' +
        data.settings[0].isSat2Enabled.toString() +
        ', ' +
        _isSat2Enabled.toString() +
        ', ' +
        global.isSatII.toString() +
        getWall(_isSat2Enabled));
    debugPrint('| ACT      : ' +
        data.settings[0].isActEnabled.toString() +
        ', ' +
        _isActEnabled.toString() +
        ', ' +
        global.isAct.toString() +
        getWall(_isActEnabled));
    debugPrint('-----------------------');
  }

  void _update() {
    _setAll();
    setPreferences();
    database.updateSettings(settings);
  }

  void setPreferences() {
    global.isDark = _isDarkModeOn;
    global.isGraph = _isGraphOn;
    global.isSat = _isSatEnabled;
    global.isSatII = _isSat2Enabled;
    global.isAct = _isActEnabled;
    debugPrint('Preferences set');
  }

  void _setAll() {
    _setDarkMode();
    _setGraph();
    _setSatI();
    _setSatII();
    _setAct();
  }

  String getWall(bool bool) {
    if (bool == false) {
      return ' |';
    } else
      return '  |';
  }
}

class DataSettings {
  DatabaseHelper databaseHelper = DatabaseHelper();
  SettingsModel title = SettingsModel.db();
  List<SettingsModel> settings;
  int count = 0;

  //ScoreSat1State sat1state = ScoreSat1State();
  void autoRefresh(Function setState) {
    if (settings == null || settings.length == 0) {
      settings = List<SettingsModel>();
      updateListView(setState);
    }
  }

  // when calling this function wrap it in a setState
  Future<void> getData(Function setState) async {
    updateListView(setState);
  }

  // when calling this function wrap it in a setState
  void updateListView(Function setState) {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<SettingsModel>> noteListFuture = databaseHelper.getSettings();
      noteListFuture.then((settings) {
        setState(() {
          this.settings = settings;
          this.count = settings.length;
        });
      });
    });
  }

  void updateListViewNoState() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<SettingsModel>> noteListFuture = databaseHelper.getSettings();
      noteListFuture.then((settings) {
        this.settings = settings;
        this.count = settings.length;
      });
    });
  }
}
