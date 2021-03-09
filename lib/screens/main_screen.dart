import 'dart:io';

import 'package:authApp/db/db_helper.dart';
import 'package:authApp/drawers/main_drawer.dart';
import 'package:authApp/models/profileModel.dart';
import 'package:authApp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(),
        appBar: AppBar(
          //  title: Text("Главная"),
          actions: [
            IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () {
                  Provider.of<AuthProvider>(context).logout();
                })
          ],
          backgroundColor: Colors.blueGrey,
        ),
        body: Container());
  }
}
