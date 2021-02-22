import 'package:authApp/providers/auth_provider.dart';
import 'package:authApp/screens/auth/auth_screen.dart';
import 'package:authApp/screens/main_screen.dart';
import 'package:authApp/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/cars_screen.dart';
import './screens/main_screen.dart';
import './screens/profile_screen.dart';
import './screens/realty_screen.dart';
import './screens/settings_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider.value(value: AuthProvider())],
      child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
                routes: {
                  ProfileScreen.routeName: (ctx) => ProfileScreen(),
                  RealtyScreen.nameRoute: (ctx) => RealtyScreen(),
                  CarsScreen.nameRoute: (ctx) => CarsScreen(),
                  SettingsScreen.nameRoute: (ctx) => SettingsScreen(),
                },
                theme: ThemeData(
                    primaryTextTheme: TextTheme(
                        headline1: TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poiret',
                          fontSize: 27.0,
                          // shadows: [
                          //   Shadow(
                          //       color: Colors.black,
                          //       blurRadius: 7.0,
                          //       offset: Offset.fromDirection(0.5))
                          // ],
                        ),
                        headline5: TextStyle(
                            color: Colors.white,
                            letterSpacing: 8.0,
                            fontSize: 15,
                            fontFamily: 'Poiret'),
                        bodyText2: TextStyle(color: Colors.white)),
                    primaryColor: Colors.blueGrey,
                    buttonColor: Color.fromARGB(255, 172, 149, 107),
                    accentColor: Colors.white),
                home: auth.isAuth
                    ? MainScreen()
                    : FutureBuilder(
                        future: auth.tryAutoLogin(),
                        builder: (ctx, authResultSnapshot) =>
                            authResultSnapshot.connectionState ==
                                    ConnectionState.waiting
                                ? SplashScreen()
                                : AuthScreen()),
              )),
    );
  }
}
