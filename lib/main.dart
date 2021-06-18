import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Screen/menu.dart';

void main() {
  runApp(Nabiitu());
}

class Nabiitu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
