import '../db/db_helper.dart';
import '../models/profileModel.dart';
import 'package:flutter/material.dart';

import '../providers/urls.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  String _token;
  String _serverError;

  String get serverError {
    return _serverError;
  }

  bool get isAuth {
    return token != null;
  }

  String get token {
    return _token;
  }

  Future<void> signup(
      String email,
      String password,
      String phone,
      String lastName,
      String firstName,
      String patronymic,
      int sex,
      String category) async {
    ProfileModel profile = ProfileModel(
        lastName: lastName,
        firstName: firstName,
        patronymic: patronymic,
        email: email,
        phone: phone,
        sex: sex,
        category: category);

    try {
      final myResponse = await http.post(Urls.addUserUrl,
          body: json.encode({
            'email': profile.email,
            'password': password,
            'lastName': profile.lastName,
            'firstName': profile.firstName,
            'patronymic': profile.patronymic,
            'phone': profile.phone,
            'sex': profile.sex,
            'registrationType': profile.category,
          }));
      final responseData = json.decode(myResponse.body);
      _token = responseData['apiToken'];
      final error = responseData['error'];
      if (_token != null) {
        saveToken(_token);
      } else {
        _serverError = error;
      }
    } catch (error) {}

    DbHelper.db.insertProfile(profile);

    // DbHelper.insert('profile', {
    //   'last_name': lastName,
    //   'first_name': firstName,
    //   'patronymic': patronymic,
    //   'phone': phone,
    //   'email': email,
    //   'sex': sex,
    //   'category': category,
    // });
    //print(json.encode(db1));
    notifyListeners();
  }

  // Future<void> getProfileData() async {
  //   return  DbHelper.db.readProfile(1);
  //   notifyListeners();
  // }

  Future<void> saveToken(token) async {
    final pref = await SharedPreferences.getInstance();
    final userData = json.encode({'token': token});
    pref.setString('userData', userData);
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    final myLoginResponse = await http.post(
      Urls.loginUrl,
      body: json.encode({'email': email, 'password': password}),
    );
    final responseData = json.decode(myLoginResponse.body);
    final token = responseData['apiToken'];
    if (token != null) {
      saveToken(token);
    } else {
      final error = responseData['error'];
      _serverError = error;
    }
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedData =
        json.decode(prefs.getString('userData')) as Map<String, Object>;
    _token = extractedData['token'];
    notifyListeners();
  }

  Future<void> logout() async {
    _token = null;
    notifyListeners();
    final pref = await SharedPreferences.getInstance();
    pref.remove('userData');
    pref.clear();
  }
}
