import 'package:flutter/material.dart';


class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Material(
      color: Colors.greenAccent,
      child: new InkWell(
        onTap: () => print("tapped"),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Lets Gooo", style: new TextStyle(color: Colors.white, fontSize: 50.0,  fontWeight: FontWeight.bold),),
            new Text("Sonic Wind", style: new TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold))
          ],
        ), 
      ),
    );
  }
}

