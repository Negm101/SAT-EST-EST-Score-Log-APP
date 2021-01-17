import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:score_log_app/model/tansik.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseTansik {
  TansikModel tansikModel = new TansikModel.db();

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "tansik.db");

    final exists = await databaseExists(path);

    if (exists) {
      print('database already exists');
      return await openDatabase(path);
    } else {
      print('databse does not exist creating a new copy');
    }

    try {
      await Directory(dirname(path)).create(recursive: true);
    } catch (_) {}

    ByteData data = await rootBundle.load(join("assets", "tansik.db"));
    List<int> bytes =
        data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

    await File(path).writeAsBytes(bytes, flush: true);

    return await openDatabase(path);
  }

  Future<List<TansikModel>> getTansik(String year) async {
    Database db = await initDB();
    var tansikMapList = await db.query(tansikModel.dbTableName,
        orderBy: '${tansikModel.dbPercent} DESC',
        where:
            '${tansikModel.dbYear} = $year '); // Get 'Map List' from database
    int count =
        tansikMapList.length; // Count the number of map entries in db table

    List<TansikModel> scoreList = List<TansikModel>();
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      scoreList.add(TansikModel.fromMapObject(tansikMapList[i]));
    }

    return scoreList;
  }
}
