import 'auth_card.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    final orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      body: Stack(children: <Widget>[
        Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: Image.asset(
            'assets/img/background.jpg',
            fit: BoxFit.cover,
          ),
        ),
        Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: FractionalOffset.topCenter,
            end: FractionalOffset.bottomCenter,
            colors: [
              Colors.blue.withOpacity(0.60),
              Color.fromARGB(255, 172, 149, 107),
              Color.fromRGBO(106, 25, 49, 0.60)
            ],
          )),
        ),
        Container(
          width: deviceSize.width,
          height: deviceSize.height,
          child: SafeArea(
            child: Column(
              children: [
                orientation == Orientation.portrait
                    ? Image.asset(
                        'assets/img/top_logo.png',
                        width: 250,
                        height: 150,
                      )
                    : SizedBox(
                        height: 10,
                      ),
                Container(
                  height: 100,
                  //  width: deviceSize.width,
                  child: Center(
                    child: Column(
                      children: [
                        Text("жилой комплекс",
                            style:
                                Theme.of(context).primaryTextTheme.headline5),
                        Text(
                          "ВИДНЫЙ ГОРОД",
                          style: Theme.of(context).primaryTextTheme.headline1,
                        ),
                      ],
                    ),
                  ),
                ),
                Flexible(
                  child: AuthCard(),
                  flex: 1,
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
