import 'package:eox/model/ButtonPresses.dart';
import 'package:eox/views/widgets/NavDrawer.dart';
import 'package:eox/views/widgets/slidable/Slidable.dart';
import 'package:eox/views/widgets/slidable/SlideAction.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:core';
import 'signaling.dart';
import 'package:flutter_webrtc/webrtc.dart';

class CallSample extends StatefulWidget {
  static String tag = 'call_sample';

  final String ip;

  CallSample({Key key, @required this.ip}) : super(key: key);

  @override
  _CallSampleState createState() => new _CallSampleState(serverIP: ip);
}

class _CallSampleState extends State<CallSample> {
  TextEditingController editingController = TextEditingController();
  Signaling _signaling;
  String _displayName =
      Platform.localHostname + '(' + Platform.operatingSystem + ")";
  List<dynamic> _peers;
  var _selfId;
  RTCVideoRenderer _localRenderer = new RTCVideoRenderer();
  RTCVideoRenderer _remoteRenderer = new RTCVideoRenderer();
  bool _inCalling = false;
  final String serverIP;

  _CallSampleState({Key key, @required this.serverIP});

  @override
  initState() {
    super.initState();
    initRenderers();
    _connect();
  }

  initRenderers() async {
    await _remoteRenderer.initialize();
  }

  @override
  deactivate() {
    super.deactivate();
    if (_signaling != null) _signaling.close();
    _remoteRenderer.dispose();
  }

  void _connect() async {
    if (_signaling == null) {
      _signaling = new Signaling("192.168.43.214", _displayName)..connect();

      _signaling.onStateChange = (SignalingState state) {
        switch (state) {
          case SignalingState.CallStateNew:
            this.setState(() {
              _inCalling = true;
            });
            break;
          case SignalingState.CallStateBye:
            this.setState(() {
              _remoteRenderer.srcObject = null;
              _inCalling = false;
            });
            break;
          case SignalingState.CallStateInvite:
          case SignalingState.CallStateConnected:
          case SignalingState.CallStateRinging:
          case SignalingState.ConnectionClosed:
          case SignalingState.ConnectionError:
          case SignalingState.ConnectionOpen:
            break;
        }
      };

      _signaling.onPeersUpdate = ((event) {
        this.setState(() {
          _selfId = event['self'];
          _peers = event['peers'];
        });
      });

      _signaling.onAddRemoteStream = ((stream) {
        _remoteRenderer.srcObject = stream;
      });

      _signaling.onRemoveRemoteStream = ((stream) {
        _remoteRenderer.srcObject = null;
      });
    }
  }

  _invitePeer(context, peerId, use_screen) async {
    if (_signaling != null && peerId != _selfId) {
      _signaling.invite(peerId, 'video', use_screen);
    }
  }

  _hangUp() {
    if (_signaling != null) {
      _signaling.bye();
    }
  }

  _switchCamera() {
    _signaling.switchCamera();
  }

  _muteMic() {}

  _buildRow(context, peer) {
    var self = (peer['id'] == _selfId);
    var secondaryAction = <Widget>[
      new IconSlideAction(
        caption: 'Play',
        color: Colors.blue,
        icon: Icons.play_arrow,
        onTap: () {
          _invitePeer(context, peer['id'], false);
        },
        closeOnTap: false,
      ),
    ];
    return new Tooltip(
        message: "Swipe or Click to Play",
        child: new Padding(
            padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
            child: new Container(
                color: Colors.white,
                child: new Slidable(
                    child: new ListTile(
                      contentPadding: EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
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
                          //child: buddyOrMine,
                        ),
                      ),
                      title: Text(
                        self
                            ? peer['name'] + '[Your self]'
                            : peer['name'] + '[' + peer['user_agent'] + ']',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18),
                      ),
                      subtitle: Row(
                        children: <Widget>[
                          Icon(
                            Icons.wifi,
                            color: Colors.green.withOpacity(0.5),
                          ),
                          Text(
                            " Connection: Great",
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
                    secondaryActions: secondaryAction))));
    //subtitle: Text('id: ' + peer['id']),
  }

  void _filterSearchResults(String query) {
    // List<EOXStream> dummyListData = List<EOXStream>();

    // if (query.isNotEmpty) {
    //   widget.userStreams.forEach((item) {
    //     if (item.name.toLowerCase().contains(query.toLowerCase())) {
    //       dummyListData.add(item);
    //     }
    //   });
    //   setState(() {
    //     widget.userStreams.clear();
    //     widget.userStreams.addAll(dummyListData);
    //   });
    // } else {
    //   setState(() {
    //     widget.userStreams.clear();
    //     widget.userStreams
    //         .addAll(UserController.getAllStreams(UserController.user).streams);
    //   });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Streams'),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: _inCalling
          ? new SizedBox(
              width: 200.0,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      child: const Icon(Icons.switch_camera),
                      onPressed: _switchCamera,
                    ),
                    FloatingActionButton(
                      onPressed: _hangUp,
                      tooltip: 'Hangup',
                      child: new Icon(Icons.call_end),
                      backgroundColor: Colors.pink,
                    ),
                    FloatingActionButton(
                      child: const Icon(Icons.mic_off),
                      onPressed: _muteMic,
                    )
                  ]))
          : null,
      body: _inCalling
          ? OrientationBuilder(builder: (context, orientation) {
              return new Container(
                child: new Stack(children: <Widget>[
                  new Positioned(
                      left: 0.0,
                      right: 0.0,
                      top: 0.0,
                      bottom: 0.0,
                      child: new Container(
                        margin: new EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: new RTCVideoView(_remoteRenderer),
                        decoration: new BoxDecoration(color: Colors.black54),
                      )),
                  new Positioned(
                    left: 20.0,
                    top: 20.0,
                    child: new Container(
                      width: orientation == Orientation.portrait ? 90.0 : 120.0,
                      height:
                          orientation == Orientation.portrait ? 120.0 : 90.0,
                      decoration: new BoxDecoration(color: Colors.black54),
                    ),
                  ),
                ]),
              );
            })
          : Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (value) {
                        _filterSearchResults(value);
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
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(0.0),
                        itemCount: (_peers != null ? _peers.length : 0),
                        itemBuilder: (context, i) {
                          return _buildRow(context, _peers[i]);
                        }),
                  ),
                ],
              ),
            ),
      //Lastly is navigation
      drawer: new NavDrawer(),
      //endDrawer: ,
    );
  }
}
