import 'package:eox/views/call_sample.dart';
/**
 *
 * This file is the main entry point into the EOX Application, and handles all
 * routing between pages.
 *
 * @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
 * Dianna Carranza, and Eduard Romanyuk
 *
 * @version 1.1.0
 */

import 'package:eox/views/widgets/guides/GuidePage1.dart';
import 'package:eox/views/widgets/guides/GuidePage2.dart';
import 'package:eox/views/widgets/guides/GuidePage3.dart';
import 'package:eox/views/widgets/guides/GuidePage4.dart';
import 'package:flutter/material.dart';
import 'package:eox/views/DevManagement.dart';
import 'package:eox/views/Home.dart';
import 'package:eox/views/IdentityManagement.dart';
import 'package:eox/views/Login.dart';
import 'package:eox/views/Register.dart';

class EOXApp extends StatelessWidget {
  final String _title = "EOX Streamer";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: Login(),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => new Login(),
        '/register': (BuildContext context) => new Register(),
        '/homePage': (BuildContext context) => new CallSample(ip: "192.168.1.130",),
        '/identity': (BuildContext context) => new IdentityManagement(),
        '/devStreamManagement': (BuildContext context) => new DevManagement(),
        '/guidePage1': (BuildContext context) => new GuidePage1(),
        '/guidePage2': (BuildContext context) => new GuidePage2(),
        '/guidePage3': (BuildContext context) => new GuidePage3(),
        '/guidePage4': (BuildContext context) => new GuidePage4(),
      },
      theme: ThemeData.dark(),
    );
  }
}

void main() {
  runApp(EOXApp());
}
