/// This is the MyFilter class, that represents the filter pop up
/// shown on the home page
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/views/DevManagement.dart';
import 'package:flutter/material.dart';

class MyFilter {
  bool onlyActive = false;
  bool onlySelected = false;
  bool onlyConnected = false;
  bool onlyMine = false;
  bool onlyBuddy = false;

  MyFilter();
  MyFilter.prepared(
      String name, bool isActive, bool connection, bool selected, bool isMine);
}

void filterStreams(context) async {
  MyFilter filter = new MyFilter();
  bool activeChecked = false;
  await showDialog<DevManagement>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          children: <Widget>[
            new CheckboxListTile(
              //leading: const Icon(Icons.person),
              title: new Text("Show Only Active Streams"),
              value: activeChecked,
              onChanged: (activeChecked) {
                filter.onlyActive = true;
                activeChecked = true;
              },
            ),
            new CheckboxListTile(
              //leading: const Icon(Icons.person),
              title: new Text("Show Only My Streams"),
              value: activeChecked,
              onChanged: (activeChecked) {
                filter.onlyMine = true;
                activeChecked = true;
              },
            ),
            new CheckboxListTile(
              //leading: const Icon(Icons.person),
              title: new Text("Show Only Buddy Streams"),
              value: activeChecked,
              onChanged: (activeChecked) {
                filter.onlyBuddy = true;
                activeChecked = true;
              },
            ),
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Padding(
                  padding: EdgeInsets.all(4.0),
                  child: RaisedButton(
                    onPressed: () {
                      return filter;
                    },
                    child: const Text('Confirm'),
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
