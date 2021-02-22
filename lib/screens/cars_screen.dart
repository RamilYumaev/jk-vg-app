import '../drawers/main_drawer.dart';
import 'package:flutter/material.dart';

class CarsScreen extends StatelessWidget {
  static const nameRoute = "/cars";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Мой автомобиль"),
        actions: [IconButton(icon: Icon(Icons.add), onPressed: () {})],
      ),
      body: Center(
        child: RichText(
            text: TextSpan(
                text:
                    "Внесите марку и гос.номер Вашего авто для участия в сообществе автомобилистов нашего ЖК. Вместе мы попытаемся решить проблему парковок в ЖК")),
      ),
      drawer: MainDrawer(),
    );
  }
}
