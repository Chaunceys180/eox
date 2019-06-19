///This is the IdentityManagement class and handles the way users need to handle
///changing account information.
///@author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
///Dianna Carranza, and Eduard Romanyuk
///@version 1.1.0

import 'package:eox/views/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class IdentityManagement extends StatelessWidget {


  Widget build(BuildContext context) {

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Identity Management"),
      ),

      //Lastly is navigation
      drawer: new NavDrawer(),
    );
  }

}