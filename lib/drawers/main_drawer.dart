import '../screens/cars_screen.dart';
import '../screens/main_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/realty_screen.dart';
import '../screens/settings_screen.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.blueGrey),
            otherAccountsPictures: [
              IconButton(
                  icon: Icon(
                    Icons.edit_outlined,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(ProfileScreen.routeName);
                  })
            ],
            arrowColor: Colors.white,
            accountName: Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                "Рамиль Анварович Юмаев",
                style: TextStyle(fontSize: 17),
              ),
            ),
            accountEmail: Text(
              "ramilka06@inbox.ru",
              style: TextStyle(color: Colors.white54),
            ),
            currentAccountPicture: CircleAvatar(
              child: Text(
                "РЮ",
                style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          ListTile(
            title: Text(
              "Главная",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.home,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(MainScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Моя недвижимость",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            leading: Icon(
              Icons.apartment,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(RealtyScreen.nameRoute);
            },
            trailing: Icon(
              Icons.add_outlined,
              color: Theme.of(context).buttonColor,
            ),
          ),
          ListTile(
            title: Text("Мой автомобиль",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            leading: Icon(
              Icons.car_rental,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            trailing: Icon(
              Icons.add_outlined,
              color: Theme.of(context).buttonColor,
            ),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(CarsScreen.nameRoute);
            },
          ),
          Divider(),
          ListTile(
            title: Text("Настройки",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            leading: Icon(
              Icons.settings,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(SettingsScreen.nameRoute);
            },
          ),
          ListTile(
            title: Text(
              "Выход",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
              size: 25,
            ),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
