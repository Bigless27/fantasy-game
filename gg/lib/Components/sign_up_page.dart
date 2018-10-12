import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
=======
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025

class SignUpPage extends StatefulWidget {
  _SignUpPage createState() => new _SignUpPage();
}

<<<<<<< HEAD
String email = emailTextController.text.toLowerCase().trim();
String username = usernameTextController.text.toLowerCase().trim();
String password = passwordTextController.text.trim();
bool usernameExists;
bool emailExists;
=======
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
final usernameTextController = new TextEditingController();
final emailTextController = new TextEditingController();
final passwordTextController = new TextEditingController();
bool isButtonDisabled = true;
bool notVisible = true;
<<<<<<< HEAD
final RegExp nameExp = RegExp(r'^[A-Za-z0-9 ]+$');
final CollectionReference documentReference =
    Firestore.instance.collection("Users");
=======
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025

class _SignUpPage extends State<SignUpPage> {
  @override
  void initState() {
    super.initState();
    isButtonDisabled = true;
    signUpButton();
    usernameTextController.addListener(signUpButton);
    emailTextController.addListener(signUpButton);
    passwordTextController.addListener(signUpButton);
  }

  signUpButton() {
<<<<<<< HEAD
    if (usernameTextController.text.length > 3 &&
        passwordTextController.text.length > 5 &&
        emailTextController.text.contains("@")) {
=======
    if (usernameTextController.text != "" &&
        passwordTextController.text != "" &&
        emailTextController.text != "") {
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
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

<<<<<<< HEAD
  void _initialize(String user) async {
    Map<String, dynamic> initialData = <String, dynamic>{
      "email": email,
      "username": username,
      "password": password,
      "firstName": "",
      "lastName": "",
      "phoneNumber": "",
      "profile": [
        {
          "followers": 0,
          "following": 0,
          "posts": 0,
        }
      ]
    };

    Map<String, String> initialUsername = <String, String>{username: email};

    await Firestore.instance
        .document("Users/Usernames")
        .setData(initialUsername, merge: true);
    await Firestore.instance.document("Users/$user").setData(initialData);
  }

  void _register() async {
    try {
      final QuerySnapshot username = await Firestore.instance
          .collection("Users")
          .where("username",
              isEqualTo: usernameTextController.text.toLowerCase().trim())
          .limit(1)
          .getDocuments();
      final QuerySnapshot email = await Firestore.instance
          .collection("Users")
          .where("email",
              isEqualTo: emailTextController.text.toLowerCase().trim())
          .limit(1)
          .getDocuments();
      if (username.documents.length == 1) {
        setState(() {
          usernameExists = true;
        });
      } else if (email.documents.length == 1) {
        setState(() {
          emailExists = true;
        });
      } else {
        FirebaseUser user =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text.toLowerCase().trim(),
          password: passwordTextController.text.trim(),
        );
        _initialize(user.uid);
        print("Registered: ${user.uid}");
      }
    } catch (error) {
      print("Error: $error");
    }
  }

=======
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
  @override
  Widget build(BuildContext context) {
    signUpButtonPressed() {
      if (isButtonDisabled == true) {
        return null;
      } else if (isButtonDisabled == false) {
        return () {
<<<<<<< HEAD
          _register();
=======
          print("SIGNED UP");
          print(isButtonDisabled);
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
        };
      }
    }

    showText() {
      return () {
        setState(() {
          notVisible = !notVisible;
        });
      };
    }

    obscureText() {
      if (notVisible == true) {
        return true;
      } else {
        return false;
      }
    }

    return new Stack(
      children: <Widget>[
        new Container(
          padding: EdgeInsets.all(0.0),
          color: Color.fromRGBO(23, 23, 23, 1.0),
        ),
        new Container(
            padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: new Opacity(
                opacity: 0.25,
                child: new Image.asset(
                  "assets/background.png",
                  fit: BoxFit.cover,
                  height: 250.0,
                ))),
        new Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.fromLTRB(0.0, 125.0, 0.0, 0.0),
            child: new Image.asset(
              "assets/gglogo.png",
              width: 200.0,
              height: 56.0,
            )),
        new Scaffold(
          backgroundColor: Colors.transparent,
          appBar: new AppBar(
            backgroundColor: Colors.transparent,
            title: new Text(
              "Create An Account",
              style: new TextStyle(
                fontSize: 20.0,
                fontFamily: "Century Gothic",
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            leading: new BackButton(
              color: Colors.white,
            ),
            elevation: 0.0,
          ),
        ),
        new Container(
          padding: EdgeInsets.fromLTRB(15.0, 250.0, 15.0, 0.0),
          child: new Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.transparent,
            body: new Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new TextFormField(
<<<<<<< HEAD
                  // keyboardType: TextInputType.text,
                  autovalidate: true,
                  controller: usernameTextController,
                  validator: (text) {
                    if (text.trim().isNotEmpty && text.trim().length < 4) {
                      return "Username must contain at least 4 characters";
                    } else if (text.trim().length > 15) {
                      return "Username must contain less than 15 characters";
                    } else if (text.trim().isNotEmpty &&
                        !nameExp.hasMatch(text)) {
                      return "Username must contain alphanumeric characters only";
                    } else if (usernameExists == true) {
                      return "Username is taken";
=======
                  autovalidate: true,
                  controller: usernameTextController,
                  validator: (text) {
                    if (text.isNotEmpty && text.length < 4) {
                      return "Username must contain at least 4 characters";
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
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
                    hintText: "Username",
                    hintStyle: new TextStyle(
                      color: Color.fromRGBO(170, 170, 170, 1.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: Color.fromRGBO(0, 150, 255, 1.0))),
                  ),
                ),
                new Divider(
                  height: 25.0,
                ),
                new TextFormField(
<<<<<<< HEAD
                  keyboardType: TextInputType.emailAddress,
                  autovalidate: true,
                  controller: emailTextController,
                  validator: (text) {
                    if (text.trim().isNotEmpty &&
                        !text.trim().contains("@") &&
                        !text.trim().contains(".")) {
                      return "Email is not valid";
                    } else if (emailExists == true) {
                      return "Email is already being used";
=======
                  autovalidate: true,
                  controller: emailTextController,
                  validator: (text) {
                    if (text.isNotEmpty && !text.contains("@")) {
                      return "Email is not valid";
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
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
                    hintText: "Email",
                    hintStyle: new TextStyle(
                      color: Color.fromRGBO(170, 170, 170, 1.0),
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: Color.fromRGBO(0, 150, 255, 1.0))),
                  ),
                ),
                new Divider(
                  height: 25.0,
                ),
                new TextFormField(
                  controller: passwordTextController,
                  autovalidate: true,
                  validator: (text) {
<<<<<<< HEAD
                    if (text.trim().isNotEmpty && text.trim().length < 6) {
=======
                    if (text.isNotEmpty && text.length < 6) {
>>>>>>> c056af465ff9ad3f4a30f919850fe8df5d308025
                      return "Password must contain at least 6 characters";
                    }
                  },
                  obscureText: obscureText(),
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
                    contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(2.0),
                        borderSide: BorderSide(
                            style: BorderStyle.solid,
                            width: 1.0,
                            color: Color.fromRGBO(0, 150, 255, 1.0))),
                  ),
                ),
                new Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: new Row(
                    children: <Widget>[
                      new Stack(
                        alignment: Alignment.topLeft,
                        children: <Widget>[
                          new GestureDetector(
                              onTap: showText(),
                              child: new Container(
                                child: new AnimatedOpacity(
                                    opacity: notVisible ? 0.0 : 1.0,
                                    duration: new Duration(milliseconds: 0),
                                    child: new Icon(
                                      Icons.check,
                                      color: Color.fromRGBO(0, 150, 255, 1.0),
                                      size: 17.0,
                                    )),
                                width: 20.0,
                                height: 20.0,
                                decoration: new BoxDecoration(
                                  color: Color.fromRGBO(5, 5, 10, 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(2.0)),
                                  border: new Border.all(
                                    color: Color.fromRGBO(30, 30, 30, 1.0),
                                    width: 1.0,
                                  ),
                                ),
                              ))
                        ],
                      ),
                      new Container(
                        margin: EdgeInsets.only(left: 5.0),
                        child: new Text(
                          "Show Password",
                          style: new TextStyle(
                            color: Color.fromRGBO(170, 170, 170, 1.0),
                            fontSize: 12.0,
                            fontFamily: "Century Gothic",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new Center(
                  child: new Container(
                    width: 300.0,
                    height: 60.0,
                    margin: EdgeInsets.only(top: 20.0),
                    child: new FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                      disabledColor: Color.fromRGBO(137, 145, 151, 1.0),
                      color: Color.fromRGBO(0, 150, 250, 1.0),
                      onPressed: signUpButtonPressed(),
                      child: new Center(
                        child: new Text(
                          "Sign Up",
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
          ),
        ),
      ],
    );
  }
}
