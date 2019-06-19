/// This is the NavDrawer class, that handled the way we
/// navigate throughout our application.
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/controller/UserController.dart';
import 'package:eox/views/Home.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatefulWidget {
  _NavDrawerState createState() => new _NavDrawerState();
}

void _askedToLeave(context) async {
  await showDialog<NavDrawer>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Are you sure you want to logout?'),
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(4.0),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          '/login', (Route<dynamic> route) => false);
                    },
                    child: const Text('Yes'),
                    color: Colors.teal,
                  ),
                ),
                new Padding(
                    padding: EdgeInsets.all(4.0),
                    child: RaisedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Cancel'),
                      color: Colors.white30,
                    )),
              ],
            ),
          ],
        );
      });
}

class _NavDrawerState extends State<NavDrawer> {
  @override
  Drawer build(BuildContext context) {
    return new Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the Drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        //Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
              child: new Image.asset(
                "assets/images/login_logo.png",
                width: MediaQuery.of(context).size.width - 200,
                height: MediaQuery.of(context).size.width - 200,
                alignment: Alignment.topCenter,
              ),
              margin: EdgeInsets.only(bottom: 20)),
          ListTile(
            leading: const Icon(Icons.home),
            title: Text(
              'Home',
              style: new TextStyle(
                fontSize: 20.0,
                fontFamily: 'Rock Salt',
              ),
            ),
            onTap: () {
              // Update the state of the app

              Navigator.pop(context);

              Navigator.of(context).pushNamed("/homePage");

              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.view_stream),
            title: Text(
              'Device/Stream Management ',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              // Update the state of the app

              Navigator.pop(context);
              Navigator.of(context).pushNamed("/devStreamManagement");

              // ...
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(
              'Logout',
              style: new TextStyle(
                fontSize: 20.0,
              ),
            ),
            onTap: () {
              //open a dialog to make sure that they want to logout
              _askedToLeave(context);
            },
          ),
        ],
      ),
    );
  }
}
