import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Screen/menu.dart';

void main() {
  runApp(Nabiitu());
}

class Nabiitu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return MaterialApp(
      theme: ThemeData(
        fontFamily: null,
        textTheme: TextTheme(),
        primaryColor: Color.fromRGBO(0, 179, 13, 1),
        primaryTextTheme: TextTheme(
          bodyText1: TextStyle(fontFamily: "Poppins-Regular"),
        ),
      ),
      home: MenuScreen(),
    );
  }
}
