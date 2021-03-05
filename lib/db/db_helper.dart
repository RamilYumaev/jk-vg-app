import 'dart:io';
import 'dart:async';

import 'package:authApp/models/profileModel.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper db = DbHelper._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'authApp.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE profile("
          "id INTEGER PRIMARY KEY,"
          "last_name TEXT,"
          "first_name TEXT,"
          "patronymic TEXT,"
          "email TEXT,"
          "phone TEXT,"
          "sex INTEGER,"
          "category TEXT,"
          "transfer_status INTEGER"
          ")");
    });
  }

  insertProfile(ProfileModel profile) async {
    final db = await database;
    var result = db.insert("profile", profile.toMap());
    return result;
  }

  Future<ProfileModel> readProfile(int id) async {
    final db = await database;
    var result = await db.query("profile", where: "id=?", whereArgs: [id]);
    return result.isNotEmpty ? ProfileModel.fromMap(result.first) : null;
  }

  updateProfile(ProfileModel profile) async {
    final db = await database;
    var result = await db.update("profile", profile.toMap(),
        where: "id = ?", whereArgs: [profile.id]);
    return result;
  }

  // static Future<Database> database() async {
  //   final dbPath = await sql.getDatabasesPath();
  //   return sql.openDatabase(path.join(dbPath, 'userDB1.db'),
  //       onCreate: (db, version) {
  //     return db.execute('CREATE TABLE profile(key TEXT UNIQUE, value TEXT)');
  //   }, version: 1);
  // }

  // static Future<void> insert(String table, Map<String, Object> data) async {
  //   final db = await DbHelper.database();
  //   db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // static Future<List<Map<String, dynamic>>> getData(
  //     String table, List<String> column, String where) async {
  //   final db = await DbHelper.database();
  //   return db.query(table);
  // }
}
