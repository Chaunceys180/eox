/// This is the GuidePage class, that displays a small tutorial
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:flutter/material.dart';
import 'package:eox/model/Page.dart';

class GuidePage2 extends StatefulWidget {
  @override
  _GuidePage2State createState() => new _GuidePage2State();
}

class _GuidePage2State extends State<GuidePage2> with TickerProviderStateMixin {
  var indexOfFirstPageOfGuide = 1;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new Page(
            viewModel: pages[indexOfFirstPageOfGuide],
            percentVisible: 1.0,
          ),
        ],
      ),
    );
  }
}
