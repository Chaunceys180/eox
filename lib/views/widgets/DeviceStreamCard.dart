/// This is the ToolTipStreamCard class, that builds cards that represent our
/// stream object dynamically, and makes them slide-able,
/// and show tooltips when held.
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/model/EOXStream.dart';
import 'package:eox/views/widgets/slidable/Slidable.dart';
import 'package:eox/views/widgets/slidable/SlideAction.dart';
import 'package:flutter/material.dart';

class ToolTipStreamCard {
  EOXStream _stream;
  Tooltip _card;

  ToolTipStreamCard(this._stream, BuildContext cont) {
    _card = makeCard(_stream.name, _stream.isActive, _stream.isConnected,
        _stream.isSelected, _stream.isMine, cont, _stream.url);
  }

  Tooltip get card => _card;

  Slidable makeListTile(String name, bool isActive, bool connection,
      bool selected, bool isMine, BuildContext cont,
      [String url]) {
    Tooltip buddyOrMine = new Tooltip(
      message: "My Stream",
      child: new Icon(
        Icons.person,
        color: Colors.black,
      ),
    );
    IconData connectedIcon = Icons.wifi;
    String connectionText = " Connection: Great";

    if (url == null) {
      url = "null";
    }
    var secondaryAction = <Widget>[
      new IconSlideAction(
        caption: 'Edit',
        color: Colors.teal,
        icon: Icons.edit,
      ),
      new IconSlideAction(
        caption: 'Play',
        color: Colors.blue,
        icon: Icons.play_arrow,
        onTap: () {
          Navigator.pop(cont);
          Navigator.pushNamed(cont, "/video");
        },
        closeOnTap: false,
      ),
    ];

    if (!isMine) {
      buddyOrMine = new Tooltip(
        message: "Buddy Stream",
        child: new Icon(
          Icons.vpn_key,
          color: Colors.black,
        ),
      );
      secondaryAction = <Widget>[
        new IconSlideAction(
          caption: 'Play',
          color: Colors.blue,
          icon: Icons.play_arrow,
        )
      ];
    }
    if (!isActive) {
      secondaryAction = <Widget>[];
      connectedIcon = Icons.signal_wifi_off;
      connectionText = " Inactive";
    }

    return new Slidable(
        child: new ListTile(
          contentPadding:
              EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: EdgeInsets.only(right: 12.0),
            decoration: new BoxDecoration(
              border: new Border(
                right: new BorderSide(
                  width: 1.0,
                  color: Colors.black,
                ),
              ),
            ),
            child: new Padding(
              padding: EdgeInsets.only(
                top: 10.0,
                bottom: 7.0,
              ),
              child: buddyOrMine,
            ),
          ),
          title: Text(
            name,
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          subtitle: Row(
            children: <Widget>[
              Icon(
                connectedIcon,
                color: Colors.green.withOpacity(0.5),
              ),
              Text(
                connectionText,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: Tooltip(
              message: "Play Video",
              child: Icon(Icons.play_circle_filled,
                  color: Colors.black, size: 30.0)),
        ),
        delegate: new SlidableDrawerDelegate(),
        secondaryActions: secondaryAction);
  }

  Tooltip makeCard(String name, bool isActive, bool connection, bool selected,
      bool isMine, BuildContext cont,
      [String url]) {
    Color activeColor = Colors.white;

    if (!isActive) {
      activeColor = Colors.grey;
      activeColor.withOpacity(0.2);
    }

    if (url == null) {
      return new Tooltip(
          message: "Stream Inactive",
          child: new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: activeColor,
              ),
              child: makeListTile(
                  name, isActive, connection, selected, isMine, cont),
            ),
          ));
    } else {
      return new Tooltip(
          message: "Swipe left for more",
          child: new Card(
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(vertical: 6.0),
            child: Container(
              decoration: BoxDecoration(
                color: activeColor,
              ),
              child: makeListTile(
                  name, isActive, connection, selected, isMine, cont, url),
            ),
          ));
    }
  }
}
