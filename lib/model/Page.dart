/// This is the Page class, builds a small list of guide pages.
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:flutter/material.dart';

//all pages that show up places in the array
final pages = [
  new PageViewModel(
      const Color.fromRGBO(70, 70, 70, 1),
      'assets/images/login_logo.png',
      'Welcome',
      'If this is your first time please take a minute to read '
      'through this guide. ',
      '/guidePage2'),
  new PageViewModel(
      const Color.fromRGBO(70, 70, 70, 1),
      'assets/images/deviceManagement.jpg',
      'Add a Device',
      'Go to manage devices page to add your streaing device, QR '
      'scan your device, or '
      'use your buddies keys to add their devices.',
      '/guidePage3'),
  new PageViewModel(
    const Color.fromRGBO(70, 70, 70, 1),
    'assets/images/streamSwipe.jpg',
    'List of streams',
    'On your home page you will see list of streams, click play button to '
        'play the stream, swipe left on a stream to see more '
        'options.',
    '/guidePage4',
  ),
  new PageViewModel(
    const Color.fromRGBO(70, 70, 70, 1),
    'assets/images/sideMenu.png',
    'Side Menu',
    'Click on the menu in the top left corner to be able to navigate anywhere '
        'in the app. If you need to view this guide again you can do so from '
        'the settings.',
    '/homePage', //going back to homepage since its the last guide page
  ),
];

class Page extends StatelessWidget {
  final PageViewModel viewModel;
  final double percentVisible;

  Page({
    this.viewModel,
    this.percentVisible = 1.0,
  });

  @override
  Widget build(BuildContext context) {
    return new Container(
        width: double.infinity,
        color: viewModel.color,
        child: new Opacity(
          opacity: percentVisible,
          child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 50.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 25.0),
                    child: new Image.asset(viewModel.heroAssetPath,
                        width: 200.0, height: 200.0),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: new Text(
                      viewModel.title,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'WorkSansMedium',
                        fontSize: 34.0,
                      ),
                    ),
                  ),
                ),
                new Transform(
                  transform: new Matrix4.translationValues(
                      0.0, 30.0 * (1.0 - percentVisible), 0.0),
                  child: new Padding(
                    padding: new EdgeInsets.only(bottom: 75.0),
                    child: new Text(
                      viewModel.body,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'WorkSansMedium',
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new RaisedButton(
                      onPressed: () {
                        //go to main page
                        Navigator.of(context).pushNamed('/homePage');
                      },
                      child: new Text("Close"),
                      color: Colors.white30,
                    ),
                    new Padding(
                      padding: const EdgeInsets.all(15.0),
                    ),
                    new RaisedButton(
                      child: new Text("Next"),

                      color: Colors.teal,

                      onPressed: () {
                        //go to next page
                        Navigator.of(context)
                            .pushNamed(this.viewModel.nextPagePath);
                      }, // makes sign up widgets show up
                    ),
                  ],
                ),
              ]),
        ));
  }
}

class PageViewModel {
  final Color color;
  final String heroAssetPath;
  final String title;
  final String body;
  final String nextPagePath;
//  final String iconAssetPath;

  PageViewModel(
    this.color,
    this.heroAssetPath,
    this.title,
    this.body,
    this.nextPagePath,
//    this.iconAssetPath,
  );
}
