import '../drawers/main_drawer.dart';
import 'package:flutter/material.dart';

class RealtyScreen extends StatelessWidget {
  static const nameRoute = "/realty";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Моя недвижимость"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Center(
        child: Text("Ничего не найдено"),
      ),
      drawer: MainDrawer(),
    );
  }
}
