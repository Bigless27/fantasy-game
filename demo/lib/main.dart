import 'package:flutter/material.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      home: new Center(
        child: new Container(
          child: new GestureDetector(
            onTap: () {
              print("tapped!");
            },
          ),
          height: 60.0,
          width: 350.0,
          decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.0),
              border: new Border.all(
                color: Color.fromRGBO(0, 150, 255, 1.0),
                width: 1.0,
              )),
        ),
      ),
    );
  }
}
