import 'dart:io';
import 'dart:async';

import 'package:authApp/models/profileModel.dart';
import 'package:flutter/material.dart';
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
    Directory documentDirectory = await getExternalStorageDirectory();
    print('db location :' + documentDirectory.path);
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
      await db.execute("CREATE TABLE user_data("
          "key TEXT NOT NULL,"
          "value TEXT"
          ")");
    });
  }

  insertUserData(ProfileModel profile) async {
    final db = await database;
    await db.insert("user_data", profile.toMapLastName());
    await db.insert("user_data", profile.toMapFirstName());
    await db.insert("user_data", profile.toMapPatronymic());
    await db.insert("user_data", profile.toMapEmail());
    await db.insert("user_data", profile.toMapPhone());
    await db.insert("user_data", profile.toMapSex());
    await db.insert("user_data", profile.toMapCategory());
  }

  Future<ProfileModel> readProfileData() async {
    final db = await database;
    var lastName =
        await db.query("user_data", where: "key=?", whereArgs: ["lastName"]);
    var firstName =
        await db.query("user_data", where: "key=?", whereArgs: ["firstName"]);
    var patronymic =
        await db.query("user_data", where: "key=?", whereArgs: ["patronymic"]);
    var email =
        await db.query("user_data", where: "key=?", whereArgs: ["email"]);
    var phone =
        await db.query("user_data", where: "key=?", whereArgs: ["phone"]);
    var sex = await db.query("user_data", where: "key=?", whereArgs: ["sex"]);
    var category =
        await db.query("user_data", where: "key=?", whereArgs: ["category"]);
    return lastName.isNotEmpty && firstName.isNotEmpty
        ? ProfileModel.fromMapUserData(
            lastName.first,
            firstName.first,
            patronymic.first,
            email.first,
            phone.first,
            sex.first,
            category.first)
        : null; //@TODO
  }

  Future<ProfileModel> updateProfileData(ProfileModel profile) async {
    final db = await database;
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["lastName"]);
    var lastName =
        await db.query("user_data", where: "key=?", whereArgs: ["lastName"]);
    print(lastName.toString());
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["firstName"]);
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["patronymic"]);
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["email"]);
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["phone"]);
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["sex"]);
    await db.update("user_data", profile.toMapLastName(),
        where: "key=?", whereArgs: ["category"]);
  }

  fetch() async {
    final db = await database;
    final result = await db.query("user_data");

    return result
        .map((e) => ProfileModel.fromMapUserData(e['lastName'], e['firstName'],
            e['patronymic'], e['email'], e['phone'], e['sex'], e['category']))
        .toList();
  }

  // insertProfile(ProfileModel profile) async {
  //   final db = await database;
  //   var result = db.insert("profile", profile.toMap());
  //   return result;
  // }

  // Future<ProfileModel> readProfile(int id) async {
  //   final db = await database;
  //   var result = await db.query("profile", where: "id=?", whereArgs: [id]);
  //   return result.isNotEmpty ? ProfileModel.fromMap(result.first) : null;
  // }

  // updateProfile(ProfileModel profile) async {
  //   final db = await database;
  //   var result = await db.update("profile", profile.toMap(),
  //       where: "id = ?", whereArgs: [profile.id]);
  //   return result;
  // }

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
