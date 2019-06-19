/// This is the UserStreams class, that represents a list of user streams
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

import 'package:eox/model/EOXStream.dart';

class UserStreams {
  List<EOXStream> _streams;

  UserStreams(List<EOXStream> streams) {
    this._streams = streams;
  }

  List<EOXStream> get streams => _streams;

  set streams(List<EOXStream> value) {
    _streams = value;
  }

  @override
  String toString() {
    return 'UserStreams{_streams: $_streams';
  }
}