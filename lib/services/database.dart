import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:score_log_app/model/scoreSAT1.dart';


class ScoreDatabase {
  // ignore: non_constant_identifier_names
  static final ScoreDatabase _ScoreIDatabase = new ScoreDatabase._internal();

  final String tableName = "Books";

  Database db;

  bool didInit = false;

  static ScoreDatabase get() {
    return _ScoreIDatabase;
  }

  ScoreDatabase._internal();


  /// Use this method to access the database, because initialization of the database (it has to go through the method channel)
  Future<Database> _getDb() async{
    if(!didInit) await _init();
    return db;
  }

  Future init() async {
    return await _init();
  }

  Future _init() async {
    // Get a location using path_provider
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "demo.db");
    db = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
          // When creating the db, create the table
          await db.execute(
              "CREATE TABLE $tableName ("
                  "${ScoreI.dbID} int unique not null auto_increment primary key,"
                  "${ScoreI.dbEnglishScore} int not null check (english_score >= 200 and english_score <= 800),"
                  "${ScoreI.dbMathScore} int not null check ( math_score >= 200 and math_score <= 800 ),"
                  "${ScoreI.dbDate} date not null,"
                  "${ScoreI.dbNote}  varchar(34) not null default 'No note for this test',"
                  "${ScoreI.dbTestType} enum ('practice', 'real') not null default 'practice',"
                  ")");
        });
    didInit = true;


  }

  /// Get a book by its id, if there is not entry for that ID, returns null.
  Future<ScoreI> getScoreI(String id) async{
    var db = await _getDb();
    var result = await db.rawQuery('SELECT * FROM $tableName WHERE ${ScoreI.dbID} = "$id"');
    if(result.length == 0)return null;
    return new ScoreI.fromMap(result[0]);
  }

  Future<List> getAllScoresI(String dbTable) async {
    var dbClient = db;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");

    return result.toList();
  }

  Future insertScoreI(ScoreI score) async {
    var db = await _getDb();
    await db.rawInsert(
        'INSERT INTO '
            '$tableName(${ScoreI.dbEnglishScore}, ${ScoreI.dbMathScore}, ${ScoreI.dbDate}, ${ScoreI.dbNote}, ${ScoreI.dbTestType})'
            ' VALUES(?, ?, ?, ?, ?)',
        [score.englishScore, score.mathScore, score.date, score.note, score.date]);

  }

  Future close() async {
    var db = await _getDb();
    return db.close();
  }

}