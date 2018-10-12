import 'package:flutter/material.dart';
import 'package:gg/components/login_page.dart';

String utext;
String ptext;

class UsernameOrEmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TextField(
      controller: usernameTextController,
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
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 1.0,
                color: Color.fromRGBO(0, 150, 255, 1.0))),
      ),
    );
  }
}

class PasswordTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
      //controller: passwordTextController,
      //validator: (text) => text.isEmpty ? "" : null,
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
        contentPadding: EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 5.0),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(2.0),
            borderSide: BorderSide(
                style: BorderStyle.solid,
                width: 1.0,
                color: Color.fromRGBO(0, 150, 255, 1.0))),
      ),
    );
  }
}

class UsernameTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
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
    );
  }
}

class EmailTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new TextFormField(
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
    );
  }
}
