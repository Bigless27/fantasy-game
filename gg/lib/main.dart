import 'package:flutter/material.dart';
import 'package:gg/components/sign_up_page.dart';
import 'package:gg/components/profile_page.dart';
import 'package:gg/components/login_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "GG",
    theme: ThemeData(
      primaryColor: Color.fromRGBO(0, 150, 255, 1.0),
      hintColor: Color.fromRGBO(30, 30, 30, 1.0),
      fontFamily: "Avenir Next",
    ),
    home: new LoginPage(),
    initialRoute: "/LoginPage",
    routes: <String, WidgetBuilder>{
      "/LoginPage": (BuildContext context) => LoginPage(),
      "/SignUpPage": (BuildContext context) => SignUpPage(),
      "/ProfilePage": (BuildContext context) => ProfilePage(),
    },
  ));
}



