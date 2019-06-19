/// This is the DevManagement class, that allows interactions for
/// managing user devices and streams
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/controller/UserController.dart';
import 'package:eox/model/EOXStream.dart';
import 'package:eox/views/Home.dart';
import 'package:eox/views/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';

class DevManagement extends StatefulWidget {
  _DevManagementState createState() => new _DevManagementState();
}

class _DevManagementState extends State<DevManagement> {
  final _formKey = GlobalKey<FormState>();

  // VARIABLE FOR QR CODE. Saves it here now, will be changed later
  String qrCode = "";

  //QR SCAN METHOD
  Future _scanQR() async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        qrCode = qrResult;
      });
    } on PlatformException catch (ex) {
      //exception for if camera permission was denied
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        // Do something if camera permission was denied?
        setState(() {
          qrCode = "Camera permission denied";
        });
      } else {
        setState(() {
          //Do something if unknown error happened (for platformException)
          qrCode = "Uknown Error $ex";
        });
      }
    } on FormatException {
      setState(() {
        //if back button was pressed
        qrCode = "You pressed the back button before scanning";
      });
    } catch (ex) {
      //do something gif unknown error happened (for FormatException)
      setState(() {
        qrCode = "Uknown Error $ex";
      });
    }
  }

  void _addKey(context) async {
    await showDialog<DevManagement>(
        barrierDismissible: true,
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(children: <Widget>[
            Row(
              children: <Widget>[
                new Form(
                  key: _formKey,
                  child: Container(
                    width: 280,
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Device Key or Stream Key"),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    if (_submit()) {
                      EOXStream stream =
                          new EOXStream(true, true, "New Device", "");
                      UserController.allStreams.streams.add(stream);

                      //send data back to home page
                      var route = new MaterialPageRoute(
                          builder: (BuildContext context) => new Home(
                              userStreams: UserController.allStreams.streams));

                      Navigator.of(context).push(route);
                    }
                  },
                  child: Text("Login"),
                  color: Colors.teal,
                ),
              ],
            )
          ]);
        });
  }

  bool _submit() {
    //TODO: validate the code entered and get build the stream object
    return true;
  }

  void keySearch(context) async {
    await showDialog<DevManagement>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: <Widget>[
              //button that will open up a QR code scanner
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.all(4.0),
                    child: RaisedButton(
                      onPressed: () {
                        //Opens QR scanner
                        _scanQR();
                      },
                      child: const Text('Scan Code'),
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),

              // Button to press when user wants to enter the key manually
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: EdgeInsets.all(4.0),
                    child: RaisedButton(
                      onPressed: () {
                        //take input and search for key

                        //do something

                        //added, or not found
                        _addKey(context);
                      },
                      child: const Text('Enter Key'),
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
              new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
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

  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Device/Stream Management"),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              child: new Text(
                "There appears to be nothing here, click the add button to set "
                    "up a new device or stream",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white10.withOpacity(0.3),
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
            new RaisedButton(
              onPressed: () {
                //when clicked, open up a input dialog that
                // accepts a key to search for
                keySearch(context);
              },
              child: new Text("Add"),
              color: Colors.teal,
            ),
          ],
        ),
      ),


      //Lastly is navigation
      drawer: new NavDrawer(),
    );
  }
}
