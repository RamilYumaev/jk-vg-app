import '../db/db_helper.dart';
import '../models/profileModel.dart';
import '../providers/auth_provider.dart';

import '../screens/cars_screen.dart';
import '../screens/main_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/realty_screen.dart';
import '../screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          FutureBuilder(
              future: DbHelper.db.readProfileData(),
              builder:
                  (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
                if (snapshot.hasData) {
                  return UserAccountsDrawerHeader(
                    accountName: Text(snapshot.data.fullName),
                    accountEmail: Text(snapshot.data.email),
                    otherAccountsPictures: [
                      IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ProfileScreen.routeName);
                          })
                    ],
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.grey,
                      child: Text(
                        snapshot.data.lastName.characters.first.toUpperCase() +
                            snapshot.data.firstName.characters.first
                                .toUpperCase(),
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator());
                }
              })
          // UserAccountsDrawerHeader(
          //   decoration: BoxDecoration(color: Colors.blueGrey),
          //   otherAccountsPictures: [
          //     IconButton(
          //         icon: Icon(
          //           Icons.edit_outlined,
          //           color: Colors.white,
          //         ),
          //         onPressed: () {
          //           Navigator.of(context).pushNamed(ProfileScreen.routeName);
          //         })
          //   ],
          //   arrowColor: Colors.white,
          //   accountName: Container(
          //     margin: EdgeInsets.only(top: 20),
          //     child: FutureBuilder(
          //       future: DbHelper.db.readProfileData(),
          //       builder: (BuildContext context,
          //           AsyncSnapshot<ProfileModel> snapshot) {
          //         if (snapshot.hasData) {
          //           return Text(
          //             snapshot.data.fullName,
          //             style: TextStyle(fontSize: 17),
          //           );
          //         } else {
          //           return SizedBox(
          //               width: 20,
          //               height: 20,
          //               child: CircularProgressIndicator());
          //         }
          //       },
          //     ),
          //   ),
          //   // Container(
          //   //   margin: EdgeInsets.only(top: 20),
          //   //   child: Text(
          //   //     "Рамиль Анварович Юмаев",
          //   //     style: TextStyle(fontSize: 17),
          //   //   ),
          //   // ),
          //   // FutureBuilder(
          //   //     future: Provider.of<AuthProvider>(context).getProfileData(),
          //   //     builder: (ctx, snapshot) =>
          //   //         snapshot.connectionState == ConnectionState.waiting
          //   //             ? Center(child: CircularProgressIndicator())
          //   //             : Consumer<AuthProvider>(
          //   //                 builder: (ctx, auth, ch) => ListView.builder(
          //   //                     itemCount: auth.profile.length,
          //   //                     itemBuilder: (ctx, i) => Column(
          //   //                           children: [
          //   //                             Text(auth.profile[i].lastName)
          //   //                           ],
          //   //                         )),
          //   //               )),
          //   accountEmail: Text(
          //     "",
          //     style: TextStyle(color: Colors.white54),
          //   ),
          //   currentAccountPicture: CircleAvatar(
          //     child: Text(
          //       "РЮ",
          //       style: TextStyle(
          //           fontSize: 17,
          //           fontWeight: FontWeight.bold,
          //           color: Theme.of(context).primaryColor),
          //     ),
          //     backgroundColor: Colors.white,
          //   ),
          // ),
          ,
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
            onTap: () {
              Provider.of<AuthProvider>(context).logout();
            },
          ),
        ],
      ),
    );
  }
}
