///  This is the UserController class that controls
///  user states and crud operations between the model and view layers
///
///  @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
///  Dianna Carranza, and Eduard Romanyuk
///  @version 1.1.0

import 'package:eox/model/User.dart';
import 'package:eox/model/EOXStream.dart';
import 'package:eox/model/UserStreams.dart';

import '../model/User.dart';

class UserController {
  static User user;
  static bool _isLogin;
  static var emailRegex = r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  static UserController userController;
  static UserStreams allStreams;

  _UserController(String email, String password) {
    // do nothing
  }

  static UserController getInstance(String email, String password) {
    if (userController == null) {
      userController = new UserController();
      user = new User(email, password);
      _isLogin = logUserIn(user);
      return userController;
    }
    return null;
  }

  static bool get isLogin => _isLogin;

  static set isLogin(bool value) {
    _isLogin = value;
  }

  static bool isPasswordMatch(String password1, String password2) {
    return password1 == password2 ? true : false;
  }

  static bool isValidEmail(String email) {
    return RegExp(emailRegex).hasMatch(email) ? true : false;
  }

  static bool isValidPassword(String password) {
    return password.length >= 6 && password != null ? true : false;
  }

  static bool doesUserExist(User user) {
    //TODO: check the DB for the user, if he exists, don't register
  }

  static bool registerUser(User user) {
    //TODO: register user, return true or false on success/failure
  }

  static bool logUserIn(User user) {
    //TODO: use the modal to check if user exists in db

    //TODO: if user exists, then allow the route forward and set login to true
    return true;
  }

  static UserStreams getAllStreams(User user) {
    UserStreams buddies = getBuddies(user);
    UserStreams myStreams = getMyStreams(user);

    List<EOXStream> streams = buddies.streams;

    for (int i = 0; i < streams.length; i++) {
      myStreams.streams.add(new EOXStream(streams[i].isActive,
          streams[i].isConnected, streams[i].name, streams[i].url));
    }

    allStreams = myStreams;

    return allStreams;
  }

  static UserStreams getBuddies(User user) {
    //TODO: build stream object for the user stream
    List<EOXStream> streams = new List();
    EOXStream stream = new EOXStream(false, false, "Chauncey", "Nah");
    streams.add(stream);
    //TODO: build UserStream objects based on the user, and return their streams

    UserStreams userStreams = new UserStreams(streams);

    return userStreams;
  }

  static UserStreams getMyStreams(User user) {
    //TODO: build UserStream objects based on the user, and return their streams
    List<EOXStream> streams = new List();
    EOXStream stream = new EOXStream(true, false, "Chauncey", "Nah");
    streams.add(stream);
    //TODO: build UserStream objects based on the user, and return their streams

    UserStreams userStreams = new UserStreams(streams);
    return userStreams;
  }
}
