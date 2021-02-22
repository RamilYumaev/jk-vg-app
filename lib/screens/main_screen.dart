import 'package:authApp/drawers/main_drawer.dart';
import 'package:authApp/providers/auth_provider.dart';
import 'package:flutter/material.dart';
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
      body: Center(
          child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(color: Colors.grey),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: [BoxShadow(blurRadius: 2.0)]),
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Подтвердить номер телефона"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.8),
                      boxShadow: [BoxShadow(blurRadius: 2.0)]),
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Запрос подтверждения старшего по дому"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.withOpacity(0.8),
                      boxShadow: [BoxShadow(blurRadius: 2.0)]),
                  width: 150,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text("Умная парковка"),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
