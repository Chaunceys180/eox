///This is the login class and presents the view for
///logging into the application
///@author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
///Dianna Carranza, and Eduard Romanyuk
///@version 1.1.0

import 'package:eox/controller/UserController.dart';
import 'package:eox/views/Home.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static UserController userController;
  final _formKey = GlobalKey<FormState>();
  String _email;
  String _password;

  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: true,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Image.asset(
                "assets/images/login_logo.png",
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.width - 200,
                alignment: Alignment.topCenter,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Email",
                ),
                validator: (value) {
                  return UserController.isValidEmail(value)
                      ? null
                      : "Invalid email";
                },
                onSaved: (value) => _email = value,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "Password"),
                validator: (value) {
                  return UserController.isValidPassword(value)
                      ? null
                      : "Invalid password";
                },
                onSaved: (value) => _password = value,
                obscureText: true,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () {
                      if (_submit()) {
                        UserController.getAllStreams(UserController.user);
                        var route = MaterialPageRoute(
                          builder: (BuildContext context) => Home(
                              userStreams: UserController.allStreams.streams),
                        );

                        Navigator.of(context).pushNamed("/guidePage1");
                      }
                    },
                    child: Text("Login"),
                    color: Colors.teal,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                  ),
                  RaisedButton(
                    child: Text("Register"),
                    color: Colors.white30,
                    onPressed: () {
                      Navigator.of(context).pushNamed('/register');
                    }, // makes sign up widgets show up
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

      return UserController.logUserIn(UserController.user);
    }
    return false;
  }
}
