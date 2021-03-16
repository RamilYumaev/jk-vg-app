import 'dart:io';
import 'dart:async';
import 'package:authApp/models/profileModel.dart';
import 'package:authApp/providers/auth_provider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqlite_api.dart';

class DbHelper {
  DbHelper._();
  static final DbHelper db = DbHelper._();
  static Database _database;
  AuthProvider provider = AuthProvider();

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentDirectory = await getExternalStorageDirectory();
    print('db location :' + documentDirectory.path);
    String path = join(documentDirectory.path, 'authApp.db');
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE profile("
          "id TEXT,"
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

  Future<ProfileModel> readProfile() async {
    final db = await database;
    var result = await db.query("profile");
    return result.isNotEmpty ? ProfileModel.fromMap(result.first) : null;
  }

  updateProfile(ProfileModel profile) async {
    final db = await database;
    var result = await db.update("profile", profile.toMap());
    return result;
  }

  deleteProfile() async {
    final db = await database;
    db.delete("profile");
  }
}
