/// This is the Home class, that represents the landing page of the application
/// and presents cards that represents streaming objects
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/controller/UserController.dart';
import 'package:eox/model/EOXStream.dart';
import 'package:eox/model/ButtonPresses.dart';
import 'package:eox/views/widgets/DeviceStreamCard.dart';
import 'package:eox/views/widgets/NavDrawer.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  final List<EOXStream> userStreams;

  Home({Key key, this.userStreams}) : super(key: key);

  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController editingController = TextEditingController();

  void filterSearchResults(String query) {
    List<EOXStream> dummyListData = List<EOXStream>();

    if (query.isNotEmpty) {
      widget.userStreams.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        widget.userStreams.clear();
        widget.userStreams.addAll(dummyListData);
      });
    } else {
      setState(() {
        widget.userStreams.clear();
        widget.userStreams
            .addAll(UserController.getAllStreams(UserController.user).streams);
      });
    }
  }

  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        //for this, my scaffold only needs an appbar and body.

        appBar: AppBar(
          //set the title of the home page
          title: Text("Streams"),

          //set the leading hamburger logo
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                filterStreams(context);
              },
              icon: Icon(Icons.more_vert),
              tooltip: "Filter Streams",
            )
          ],
        ),

        //app bar is done here, now moving on to what needs to be in the body
        body: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: (value) {
                    filterSearchResults(value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 15.0),
                      labelText: "Search",
                      hintText: "Stream Name",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(
                child: new ListView.builder(
                    itemCount: widget.userStreams.length,
                    itemBuilder: (context, int index) {
                      //index is set with itemCount:
                      ToolTipStreamCard stream = new ToolTipStreamCard(
                          widget.userStreams[index], context);
                      return stream.card;
                    }),
              ),
            ],
          ),
        ),
        //Lastly is navigation
        drawer: new NavDrawer(),
        //endDrawer: ,
      ),
    );
  }
}
