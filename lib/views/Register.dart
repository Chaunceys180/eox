/// This class if for registering a first-time user to the application.
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/controller/UserController.dart';
import 'package:eox/views/Home.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  _RegisterState createState() => new _RegisterState();
}

class _RegisterState extends State<Register> {
  static UserController userController;
  final _formKey = new GlobalKey<FormState>();
  var _passwordKey = new GlobalKey<FormFieldState>();
  String _email;
  String _password;

  Widget build(BuildContext context) {
    return new Scaffold(
      resizeToAvoidBottomPadding: true,
      body: new Padding(
        padding: const EdgeInsets.all(20.0),
        child: new Form(
          key: _formKey,
          child: new ListView(
            children: <Widget>[
              new Image.asset(
                "assets/images/login_logo.png",
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.width - 200,
                alignment: Alignment.topCenter,
              ),

              //username
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  return UserController.isValidEmail(value)
                      ? null
                      : "Invalid email";
                },
                onSaved: (value) => _email = value,
              ),

              //password
              new TextFormField(
                key: _passwordKey,
                decoration: new InputDecoration(
                  labelText: "Password",
                ),
                validator: (value) {
                  return UserController.isValidPassword(value)
                      ? null
                      : "Invalid Password Length";
                },
                obscureText: true,
              ),

              //confirm password
              new TextFormField(
                decoration: new InputDecoration(
                  labelText: "Confirm Password",
                ),
                validator: (password2) {
                  return UserController.isPasswordMatch(
                          _passwordKey.currentState.value, password2)
                      ? null
                      : "Passwords do not match";
                },
                onSaved: (password2) => _password = password2,
                obscureText: true,
              ),

              new Padding(
                padding: EdgeInsets.only(top: 20),
              ),

              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new RaisedButton(
                    onPressed: () {
                      if (_submit()) {
                        UserController.registerUser(UserController.user);

                        UserController.getAllStreams(UserController.user);
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => Home(
                              userStreams: UserController.allStreams.streams),
                        );

                        Navigator.of(context).push(route);
                      }
                    },
                    child: new Text("Register"),
                    color: Colors.teal,
                  ),
                  new Padding(
                    padding: const EdgeInsets.all(15.0),
                  ),
                  new RaisedButton(
                    child: new Text("Back"),
                    color: Colors.white30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool _submit() {
    final formState = _formKey.currentState;

    if (formState.validate()) {
      //if valid
      formState.save();

      //TODO: It's safe to create the user through the controller
      userController = UserController.getInstance(_email, _password);

      //TODO: check db to see if user exists, if he does then success
      if (UserController.doesUserExist(UserController.user)) {
        return false;
      } else {
        return true; //user doesn't exist, so register them
      }
    }
    return false;
  }
}
