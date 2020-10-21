import 'package:flutter/cupertino.dart';
import 'package:score_log_app/model/scoreIPractice.dart';
import 'package:score_log_app/model/scoreIReal.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database
  ScoreIReal scoreIReal = ScoreIReal.db();
  ScoreIPractice scoreIPractice = ScoreIPractice.db();

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {

    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance(); // This is executed only once, singleton object
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
    String path = directory.path + 'notes.db';

    // Open/create the database at a given path
    var scoreDatabase = await openDatabase(path, version: 1, onCreate: _createDb);
    return scoreDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute(
        "CREATE TABLE ${scoreIReal.dbTableName}"
            "("
            "${scoreIReal.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
            "${scoreIReal.dbEnglishScore} INTEGER NOT NULL CHECK (english_score >= 200 and english_score <= 800),"
            "${scoreIReal.dbMathScore} INTEGER NOT NULL CHECK ( math_score >= 200 and math_score <= 800 ),"
            "${scoreIReal.dbDate} DATE NOT NULL,"
            "${scoreIReal.dbTestType}	VARCHAR(10),"
            "${scoreIReal.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
            ")"
    );
    await db.execute(
        "CREATE TABLE ${scoreIPractice.dbTableName}"
            "("
            "${scoreIPractice.dbId} INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
            "${scoreIPractice.dbReadingScore} INTEGER NOT NULL CHECK (${scoreIPractice.dbReadingScore} >= 0 and ${scoreIPractice.dbReadingScore} <= 52),"
            "${scoreIPractice.dbWritingScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbWritingScore}  >= 0 and ${scoreIPractice.dbWritingScore}  <= 44 ),"
            "${scoreIPractice.dbMathWithNoCalcScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbMathWithNoCalcScore}  >= 0 and ${scoreIPractice.dbMathWithNoCalcScore}  <= 20 ),"
            "${scoreIPractice.dbMathCalcScore} INTEGER NOT NULL CHECK ( ${scoreIPractice.dbMathCalcScore}  >= 0 and ${scoreIPractice.dbMathCalcScore}  <= 38 ),"
            "${scoreIPractice.dbDate} DATE NOT NULL,"
            "${scoreIPractice.dbNote} VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
            ")"
    );
    debugPrint('tables Created');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getScoreIMapListReal() async {
    Database db = await this.database;
    var result = await db.query(scoreIReal.dbTableName, orderBy: '${scoreIReal.dbId} ASC');
    return result;
  }

  Future<List<Map<String, dynamic>>> getScoreIMapListPractice() async {
    Database db = await this.database;
    var result = await db.query(scoreIPractice.dbTableName, orderBy: '${scoreIPractice.dbId} ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertScoreSatIReal(ScoreIReal score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIReal.dbTableName, score.toMap());
    debugPrint('saved');
    return result;
  }

  Future<int> insertScoreSatIPractice(ScoreIPractice score) async {
    Database db = await this.database;
    var result = await db.insert(scoreIPractice.dbTableName, score.toMap());
    debugPrint('saved');
    return result;
  }
  // Update Operation: Update a Note object and save it to database
  Future<int> updateScoreSatIReal(ScoreIReal score) async {
    var db = await this.database;
    var result = await db.update(scoreIReal.dbTableName, score.toMap(), where: '${scoreIReal.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  Future<int> updateScoreSatIPractice(ScoreIPractice score) async {
    var db = await this.database;
    var result = await db.update(scoreIPractice.dbTableName, score.toMap(), where: '${scoreIPractice.dbId} = ?', whereArgs: [score.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteScoreSatIReal(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM ${scoreIReal.dbTableName} WHERE ${scoreIReal.dbId} = $id');
    return result;
  }

  Future<int> deleteScoreSatIPractice(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM ${scoreIPractice.dbTableName} WHERE ${scoreIPractice.dbId} = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCountSatIReal() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from ${scoreIReal.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<int> getCountSatIPractice() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from ${scoreIPractice.dbTableName}');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<ScoreIReal>> getScoreIListReal() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIReal.dbTableName, orderBy: '${scoreIReal.dbId} ASC'); // Get 'Map List' from database
    int count = scoreMapList.length;         // Count the number of map entries in db table

    List<ScoreIReal> scoreList = List<ScoreIReal>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIReal.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

  Future<List<ScoreIPractice>> getScoreIListPractice() async {
    Database db = await this.database;
    var scoreMapList = await db.query(scoreIPractice.dbTableName, orderBy: '${scoreIPractice.dbId} ASC'); // Get 'Map List' from database
    int count = scoreMapList.length;         // Count the number of map entries in db table

    List<ScoreIPractice> scoreList = List<ScoreIPractice>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreIPractice.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

}



