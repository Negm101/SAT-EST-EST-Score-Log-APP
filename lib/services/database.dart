import 'package:flutter/cupertino.dart';
import 'package:score_log_app/model/scoreSAT1.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databaseHelper;    // Singleton DatabaseHelper
  static Database _database;                // Singleton Database

  String scores1Table = 'scores_sat1';
  String dbId = 'id';
  String dbEnglishScore = 'english_score';
  String dbMathScore = 'math_score';
  String dbDate = 'date';
  String dbTestType = 'test_type';
  String dbNote = 'note';
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
        "CREATE TABLE $scores1Table"
            "("
            "$dbId INTEGER UNIQUE NOT NULL PRIMARY KEY AUTOINCREMENT,"
            "$dbEnglishScore INTEGER NOT NULL CHECK (english_score >= 200 and english_score <= 800),"
            "$dbMathScore INTEGER NOT NULL CHECK ( math_score >= 200 and math_score <= 800 ),"
            "$dbDate DATE NOT NULL,"
            "$dbTestType	VARCHAR(10),"
            "$dbNote VARCHAR(34)  NOT NULL DEFAULT 'No note for this test'"
            ")"
    );
  }
/*
create table score_sat1
(
    id            int unique                not null auto_increment primary key,
    english_score int                       not null check (english_score >= 200 and english_score <= 800),
    math_score    int                       not null check ( math_score >= 200 and math_score <= 800 ),
    date          date                      not null,
    note          varchar(34)               not null default 'No note for this test',
    test_type     enum ('practice', 'real') not null default 'practice'
);
 */
  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getScoreIMapListPractice() async {
    Database db = await this.database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db.query(scores1Table, orderBy: '$dbId ASC');
    return result;
  }

  // Insert Operation: Insert a Note object to database
  Future<int> insertScore(ScoreI score) async {
    Database db = await this.database;
    var result = await db.insert(scores1Table, score.toMap());
    debugPrint('saved');
    return result;
  }

  // Update Operation: Update a Note object and save it to database
  Future<int> updateScore(ScoreI score) async {
    var db = await this.database;
    var result = await db.update(scores1Table, score.toMap(), where: '$dbId = ?', whereArgs: [score.id]);
    return result;
  }

  // Delete Operation: Delete a Note object from database
  Future<int> deleteScore(int id) async {
    var db = await this.database;
    int result = await db.rawDelete('DELETE FROM $scores1Table WHERE $dbId = $id');
    return result;
  }

  // Get number of Note objects in database
  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $scores1Table');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<ScoreI>> getScoreIListPractice() async {

    var scoreMapList = await getScoreIMapListPractice(); // Get 'Map List' from database
    int count = scoreMapList.length;         // Count the number of map entries in db table

    List<ScoreI> scoreList = List<ScoreI>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(ScoreI.fromMapObject(scoreMapList[i]));
    }

    return scoreList;
  }

}



