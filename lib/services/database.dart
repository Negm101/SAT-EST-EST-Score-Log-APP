import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:score_log_app/model/act/actPractice.dart';
import 'package:score_log_app/model/act/actReal.dart';
import 'package:score_log_app/model/sat1/scoreIPractice.dart';
import 'package:score_log_app/model/sat1/scoreIReal.dart';
import 'package:score_log_app/model/sat2/scoreIIPractice.dart';
import 'package:score_log_app/model/sat2/scoreIIReal.dart';
import 'package:score_log_app/model/settingsModel.dart';
import 'package:score_log_app/model/tansik.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper; // Singleton DatabaseHelper
  static Database _database; // Singleton Database
  ScoreIReal scoreIReal = ScoreIReal.db();
  ScoreIPractice scoreIPractice = ScoreIPractice.db();
  ScoreIIReal scoreIIReal = ScoreIIReal.db();
  ScoreIIPractice scoreIIPractice = ScoreIIPractice.db();
  ActPractice scoreActPractice = ActPractice.db();
  ActReal scoreActReal = ActReal.db();
  TansikModel tansik = TansikModel.db();
  SettingsModel settings = SettingsModel.db();

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper
          ._createInstance(); // This is executed only once, singleton object
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'LOG';

    // Open/create the database at a given path
    var scoreDatabase = await openDatabase(
      path,
      version: 2,
      onCreate: _createDb,
      onUpgrade: (db, oldVersion, newVersion) async {
        var batch = db.batch();
        if (oldVersion == 1) {
          _createSettings(db);
        }
        await batch.commit();
      },
    );
    return scoreDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute("CREATE TABLE ${scoreIReal.dbTableName}"
        "("
        "${scoreIReal.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreIReal.dbEnglishScore} INTEGER NOT NULL CHECK (english_score >= 200 and english_score <= 800),"
        "${scoreIReal.dbMathScore} INTEGER NOT NULL CHECK ( math_score >= 200 and math_score <= 800 ),"
        "${scoreIReal.dbDate} DATE NOT NULL,"
        "${scoreIReal.dbTestType}	VARCHAR(10),"
        "${scoreIReal.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    await db.execute("CREATE TABLE ${scoreIPractice.dbTableName}"
        "("
        "${scoreIPractice.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreIPractice.dbReadingScore} INTEGER NOT NULL CHECK (${scoreIPractice.dbReadingScore} >= 0 and ${scoreIPractice.dbReadingScore} <= 52),"
        "${scoreIPractice.dbWritingScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbWritingScore}  >= 0 and ${scoreIPractice.dbWritingScore}  <= 44 ),"
        "${scoreIPractice.dbMathWithNoCalcScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbMathWithNoCalcScore}  >= 0 and ${scoreIPractice.dbMathWithNoCalcScore}  <= 20 ),"
        "${scoreIPractice.dbMathCalcScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbMathCalcScore}  >= 0 and ${scoreIPractice.dbMathCalcScore}  <= 38 ),"
        "${scoreIPractice.dbDate} DATE NOT NULL,"
        "${scoreIPractice.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    await db.execute("CREATE TABLE ${scoreIIReal.dbTableName}"
        "("
        "${scoreIIReal.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreIIReal.dbScore} INTEGER NOT NULL CHECK (${scoreIIPractice.score} >= 200 and ${scoreIIPractice.score} <= 800),"
        "${scoreIIReal.dbSubject} TEXT NOT NULL,"
        "${scoreIIReal.dbDate} DATE NOT NULL,"
        "${scoreIIReal.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    await db.execute("CREATE TABLE ${scoreIIPractice.dbTableName}"
        "("
        "${scoreIIPractice.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreIIPractice.dbScore} INTEGER NOT NULL CHECK (${scoreIIPractice.score} >= 200 and ${scoreIIPractice.score} <= 800),"
        "${scoreIIPractice.dbSubject} TEXT NOT NULL,"
        "${scoreIIPractice.dbDate} DATE NOT NULL,"
        "${scoreIIPractice.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    await db.execute("CREATE TABLE ${scoreActReal.dbTableName}"
        "("
        "${scoreActReal.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreActReal.dbEnglishScore} INTEGER NOT NULL CHECK (${scoreActReal.dbEnglishScore} >= 1 and ${scoreActReal.dbEnglishScore} <= 36),"
        "${scoreActReal.dbMathScore} INTEGER NOT NULL CHECK ( ${scoreActReal.dbMathScore}  >= 1 and ${scoreActReal.dbMathScore}  <= 36 ),"
        "${scoreActReal.dbReadingScore} INTEGER NOT NULL CHECK ( ${scoreActReal.dbReadingScore}  >= 1 and ${scoreActReal.dbReadingScore}  <= 36 ),"
        "${scoreActReal.dbScienceScore} INTEGER NOT NULL CHECK ( ${scoreActReal.dbScienceScore}  >= 1 and ${scoreActReal.dbScienceScore}  <= 36 ),"
        "${scoreActReal.dbDate} DATE NOT NULL,"
        "${scoreActReal.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    await db.execute("CREATE TABLE ${scoreActPractice.dbTableName}"
        "("
        "${scoreActPractice.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
        "${scoreActPractice.dbEnglishScore} INTEGER NOT NULL CHECK (${scoreActPractice.dbEnglishScore} >= 1 and ${scoreActPractice.dbEnglishScore} <= 75),"
        "${scoreActPractice.dbMathScore} INTEGER NOT NULL CHECK ( ${scoreActPractice.dbMathScore}  >= 1 and ${scoreActPractice.dbMathScore}  <= 60 ),"
        "${scoreActPractice.dbReadingScore} INTEGER NOT NULL CHECK ( ${scoreActPractice.dbReadingScore}  >= 1 and ${scoreActPractice.dbReadingScore}  <= 40 ),"
        "${scoreActPractice.dbScienceScore} INTEGER NOT NULL CHECK ( ${scoreActPractice.dbScienceScore}  >= 1 and ${scoreActPractice.dbScienceScore}  <= 40 ),"
        "${scoreActPractice.dbDate} DATE NOT NULL,"
        "${scoreActPractice.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
        ")");
    _createSettings(db);
    debugPrint('database created');
  }

  void _createSettings(Database db) async {
    await db.execute("CREATE TABLE ${settings.dbTableName}"
        "("
        "${settings.dbId} INTEGER,"
        "${settings.dbIsGraphsEnabled} INTEGER,"
        "${settings.dbIsDarkModeEnabled} INTEGER,"
        "${settings.dbIsSatEnabled} INTEGER,"
        "${settings.dbISat2Enabled} INTEGER,"
        "${settings.dbIsActEnabled} INTEGER"
        ")");
    await db.execute(
        "INSERT INTO ${settings.dbTableName} (${settings.dbId}, ${settings.dbIsGraphsEnabled}, ${settings.dbIsDarkModeEnabled}, ${settings.dbIsSatEnabled}, ${settings.dbISat2Enabled}, ${settings.dbIsActEnabled}) "
        " VALUES (1, 0, 0, 1, 1, 1);");
    debugPrint('settings created');
  }

  // Fetch Operation: Get all objects from database
  Future<List<Map<String, dynamic>>> getScoreIMapListReal() async {
    Database db = await this.database;
    var result = await db.query(scoreIReal.dbTableName,
        orderBy: '${scoreIReal.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getScoreIMapListPractice() async {
    Database db = await this.database;
    var result = await db.query(scoreIPractice.dbTableName,
        orderBy: '${scoreIPractice.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getScoreIIMapListReal() async {
    Database db = await this.database;
    var result = await db.query(scoreIIReal.dbTableName,
        orderBy: '${scoreIIReal.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getScoreIIMapListPractice() async {
    Database db = await this.database;
    var result = await db.query(scoreIIPractice.dbTableName,
        orderBy: '${scoreIIPractice.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getActMapListReal() async {
    Database db = await this.database;
    var result = await db.query(scoreActReal.dbTableName,
        orderBy: '${scoreActReal.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getActMapListPractice() async {
    Database db = await this.database;
    var result = await db.query(scoreActPractice.dbTableName,
        orderBy: '${scoreActPractice.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getSettingsMapList() async {
    Database db = await this.database;
    var result =
        await db.query(settings.dbTableName, orderBy: '${settings.dbId} ASC');
    return result;
  }

  // Insert Operation: Insert an object to database
  Future<int> insertScoreSatIReal(ScoreIReal score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIReal.dbTableName, score.toMap());
    return result;
  }

  Future<int> insertScoreSatIPractice(ScoreIPractice score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIPractice.dbTableName, score.toMap());
    return result;
  }

  Future<int> insertScoreSatIIReal(ScoreIIReal score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIIReal.dbTableName, score.toMap());
    return result;
  }

  Future<int> insertScoreSatIIPractice(ScoreIIPractice score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIIPractice.dbTableName, score.toMap());
    return result;
  }

  Future<int> insertScoreActReal(ActReal score) async {
    Database db = await this.database;
    var result = await db.insert(scoreActReal.dbTableName, score.toMap());
    return result;
  }

  Future<int> insertScoreActPractice(ActPractice score) async {
    Database db = await this.database;
    var result = await db.insert(scoreActPractice.dbTableName, score.toMap());
    return result;
  }

  // Update Operation: Update an object and save it to database
  Future<int> updateScoreSatIReal(ScoreIReal score) async {
    var db = await this.database;
    var result = await db.update(scoreIReal.dbTableName, score.toMap(),
        where: '${scoreIReal.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateScoreSatIPractice(ScoreIPractice score) async {
    var db = await this.database;
    var result = await db.update(scoreIPractice.dbTableName, score.toMap(),
        where: '${scoreIPractice.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateScoreSatIIReal(ScoreIIReal score) async {
    var db = await this.database;
    var result = await db.update(scoreIIReal.dbTableName, score.toMap(),
        where: '${scoreIIReal.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateScoreSatIIPractice(ScoreIIPractice score) async {
    var db = await this.database;
    var result = await db.update(scoreIIPractice.dbTableName, score.toMap(),
        where: '${scoreIIPractice.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateActReal(ActReal score) async {
    var db = await this.database;
    var result = await db.update(scoreActReal.dbTableName, score.toMap(),
        where: '${scoreActReal.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateActPractice(ActPractice score) async {
    var db = await this.database;
    var result = await db.update(scoreActPractice.dbTableName, score.toMap(),
        where: '${scoreActPractice.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateSettings(SettingsModel setting) async {
    var db = await this.database;
    var result = await db.update(settings.dbTableName, setting.toMap(),
        where: '${settings.dbId} = ?', whereArgs: [setting.id]);
    return result;
  }

  // Delete Operation: Delete an object from database
  Future<int> deleteScoreSatIReal(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreIReal.dbTableName} WHERE ${scoreIReal.dbId} = $id');
    return result;
  }

  Future<int> deleteScoreSatIPractice(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreIPractice.dbTableName} WHERE ${scoreIPractice.dbId} = $id');
    return result;
  }

  Future<int> deleteScoreSatIIReal(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreIIReal.dbTableName} WHERE ${scoreIIReal.dbId} = $id');
    return result;
  }

  Future<int> deleteScoreSatIIPractice(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreIIPractice.dbTableName} WHERE ${scoreIIPractice.dbId} = $id');
    return result;
  }

  Future<int> deleteActReal(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreActReal.dbTableName} WHERE ${scoreActPractice.dbId} = $id');
    return result;
  }

  Future<int> deleteActPractice(int id) async {
    var db = await this.database;
    int result = await db.rawDelete(
        'DELETE FROM ${scoreActPractice.dbTableName} WHERE ${scoreActPractice.dbId} = $id');
    return result;
  }

  Future<int> deleteAllFrom(String tableName) async {
    var db = await this.database;
    int result = await db.rawDelete("DELETE FROM " + tableName);
    return result;
  }

  // Get number of objects in database
  Future<int> getCountSatIReal() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from ${scoreIReal.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountSatIPractice() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from ${scoreIPractice.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountSatIIReal() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from ${scoreIIReal.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountSatIIPractice() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from ${scoreIIPractice.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountActReal() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from ${scoreActReal.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountActPractice() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db
        .rawQuery('SELECT COUNT (*) from ${scoreActPractice.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<ScoreIReal>> getScoreIListReal() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIReal.dbTableName,
        orderBy: '${scoreIReal.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIReal> scoreList = List<ScoreIReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIReal>> getScoreIListRealSortBy(String sortBy) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIReal.dbTableName,
        orderBy: '$sortBy'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIReal> scoreList = List<ScoreIReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIPractice>> getScoreIListPractice() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIPractice.dbTableName,
        orderBy: '${scoreIPractice.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIPractice> scoreList = List<ScoreIPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIPractice>> getScoreIListPracticeSortBy(
      String sortBy) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIPractice.dbTableName,
        orderBy: '$sortBy'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIPractice> scoreList = List<ScoreIPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIIReal>> getScoreIIListReal() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIIReal.dbTableName,
        orderBy: '${scoreIIReal.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIIReal> scoreList = List<ScoreIIReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIIReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIIReal>> getScoreIIListRealSortBy(String sortBy) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIIReal.dbTableName,
        orderBy: '$sortBy ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIIReal> scoreList = List<ScoreIIReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIIReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIIPractice>> getScoreIIListPractice() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIIPractice.dbTableName,
        orderBy: '${scoreIIPractice.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIIPractice> scoreList = List<ScoreIIPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIIPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIIPractice>> getScoreIIListPracticeSortBy(
      String name) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIIPractice.dbTableName,
        orderBy: '$name ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ScoreIIPractice> scoreList = List<ScoreIIPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIIPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ActReal>> getActReal() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreActReal.dbTableName,
        orderBy: '${scoreActReal.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ActReal> scoreList = List<ActReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ActReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<SettingsModel>> getSettings() async {
    Database db = await this.database;
    var settingsMapList = await db.query(settings.dbTableName,
        orderBy: '${settings.dbId} ASC'); // Get 'Map List' from database
    int count =
        settingsMapList.length; // Count the number of map entries in db table

    List<SettingsModel> setting = List<SettingsModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      setting.add(SettingsModel.fromMapObject(settingsMapList[i]));
    }

    return setting;
  }

  Future<List<ActReal>> getActRealSortBy(String sortBy) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreActReal.dbTableName,
        orderBy: '$sortBy'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ActReal> scoreList = List<ActReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ActReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ActPractice>> getActPractice() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreActPractice.dbTableName,
        orderBy:
            '${scoreActPractice.dbId} ASC'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ActPractice> scoreList = List<ActPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ActPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ActPractice>> getActPracticeSortBy(String sortBy) async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreActPractice.dbTableName,
        orderBy: '$sortBy'); // Get 'Map List' from database
    int count =
        scoreMapList.length; // Count the number of map entries in db table

    List<ActPractice> scoreList = List<ActPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ActPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }
}
