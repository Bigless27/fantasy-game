import 'package:flutter/material.dart';
import 'package:gg/UI/background_image.dart';
import 'package:gg/UI/gg_logo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPage createState() => new _LoginPage();
}

final usernameTextController = new TextEditingController();
final passwordTextController = new TextEditingController();
bool isButtonDisabled = true;
bool infoExists;
var color = Color.fromRGBO(30, 30, 30, 1.0);
var activeColor = Color.fromRGBO(0, 150, 255, 1.0);

class _LoginPage extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    isButtonDisabled = true;

    usernameTextController.addListener(loginButton);
    passwordTextController.addListener(loginButton);
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is removed from the Widget tree
    usernameTextController.removeListener(loginButton);
    usernameTextController.dispose();
    passwordTextController.removeListener(loginButton);
    passwordTextController.dispose();

    super.dispose();
  }

  loginButton() {
    if (usernameTextController.text != "" &&
        passwordTextController.text != "") {
      setState(() {
        isButtonDisabled = false;
        print(isButtonDisabled);
      });
    } else {
      setState(() {
        isButtonDisabled = true;
        print(isButtonDisabled);
      });
    }
  }

  void error() {
    setState(() {
      return [
        infoExists = true,
        color = Color.fromRGBO(204, 27, 18, 1.0),
        activeColor = Color.fromRGBO(204, 27, 18, 1.0)
      ];
    });
  }

  void _authenticate(String email, String password) async {
    try {
      FirebaseUser user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      print("Signed In: ${user.uid}");
    } catch (error) {
      print("Error: $error");
      error();
    }
  }

  void _fetchUsername() async {
    final QuerySnapshot username = await Firestore.instance
        .collection("Users")
        .where("username", isEqualTo: usernameTextController.text.trim().toLowerCase())
        .limit(1)
        .getDocuments();
    final QuerySnapshot password = await Firestore.instance
        .collection("Users")
        .where("password", isEqualTo: passwordTextController.text)
        .limit(1)
        .getDocuments();
    if (username.documents.length == 1 && password.documents.length == 1) {
      await Firestore.instance.document("Users/Usernames").get().then((email) {
        if (email.exists) {
          _authenticate(email.data[usernameTextController.text.toLowerCase()],
              passwordTextController.text);
        }
      });
    } else {
      error();
    }
  }

  loginButtonPressed() {
    if (isButtonDisabled == true) {
      return null;
    } else if (isButtonDisabled == false) {
      return () {
        if (usernameTextController.text.trim().toLowerCase().contains("@")) {
          _authenticate(usernameTextController.text.trim().toLowerCase(),
              passwordTextController.text);
        } else {
          _fetchUsername();
        }
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color.fromRGBO(23, 23, 23, 1.0),
      body: new Column(
        children: <Widget>[
          new Stack(children: <Widget>[
            new BackgroundImage(),
            new GGLogo(),
          ]),
          new Container(
              padding: EdgeInsets.fromLTRB(15.0, 0.0, 15.0, 0.0),
              child: new Column(
                children: <Widget>[
                  new Theme(
                    data: new ThemeData(
                      primaryColor: activeColor,
                      hintColor: color,
                    ),
                    child: TextFormField(
                      controller: usernameTextController,
                      autovalidate: true,
                      validator: (text) {
                        if (infoExists == true) {
                          return "Invalid username or password";
                        }
                      },
                      autocorrect: false,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(5, 5, 10, 1.0),
                        hintText: "Username or Email",
                        hintStyle: new TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1.0),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: Colors.green,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Divider(
                    height: 35.0,
                  ),
                  new Theme(
                    data: new ThemeData(
                      primaryColor: activeColor,
                      hintColor: color,
                    ),
                    child: TextField(
                      controller: passwordTextController,
                      obscureText: true,
                      autocorrect: false,
                      style: new TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Color.fromRGBO(5, 5, 10, 1.0),
                        hintText: "Password",
                        hintStyle: new TextStyle(
                          color: Color.fromRGBO(170, 170, 170, 1.0),
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                        contentPadding:
                            EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(2.0),
                          borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: color,
                          ),
                        ),
                      ),
                    ),
                  ),
                  new Center(
                    child: new Container(
                        padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            new Container(
                              height: 60.0,
                              width: 140.0,
                              child: new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: new Center(
                                  child: new Text(
                                "Log In",
                                style: new TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "Century Gothic",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                              textColor: Colors.white,
                              disabledColor: Color.fromRGBO(137, 145, 151, 1.0),
                              color: Color.fromRGBO(0, 150, 255, 1.0),
                              onPressed: loginButtonPressed(),
                              //padding: EdgeInsets.fromLTRB(35.0, 15.0, 35.0, 15.0),
                            ),
                        ),
                            new SizedBox(
                              width: 20.0,
                            ),
                            new Container(
                              height: 60.0,
                              width: 140.0,
                              child: new FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.0),
                              ),
                              child: new Center(
                                  child: new Text(
                                "Sign Up",
                                style: new TextStyle(
                                  fontSize: 25.0,
                                  fontFamily: "Century Gothic",
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              )),
                              textColor: Colors.white,
                              color: Color.fromRGBO(0, 150, 255, 1.0),
                              onPressed: () {
                                Navigator.of(context).pushNamed('/SignUpPage');
                              },
                              //padding: EdgeInsets.fromLTRB(25.0, 15.0, 25.0, 15.0),
                            ),
                        ),
                          ],
                        )),
                  ),
                ],
              )),
          new Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Container(
                margin: EdgeInsets.fromLTRB(25.0, 35.0, 12.0, 32.0),
                height: 1.0,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 135.0, 0.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
              ),
              new Center(
                child: new Text(
                  "or",
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 17.0,
                    fontFamily: "Century Gothic",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              new Container(
                margin: EdgeInsets.fromLTRB(12.0, 35.0, 25.0, 32.0),
                height: 1.0,
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 135.0, 0.0),
                decoration: new BoxDecoration(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          new Center(
            child: Container(
              width: 300.0,
              height: 60.0,
              //margin: EdgeInsets.fromLTRB(35.0, 0.0, 35.0, 0.0),
              child: new FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2.0),
                ),
                //padding: EdgeInsets.only(bottom: 15.0, top: 15.0),
                disabledColor: Color.fromRGBO(78, 105, 204, 1.0),
                color: Color.fromRGBO(78, 105, 204, 1.0),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ProfilePage');
                },
                child: new Center(
                  child: new Text(
                    "Log In With Facebook",
                    style: new TextStyle(
                      color: Colors.white,
                      fontSize: 25.0,
                      fontFamily: "Century Gothic",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
