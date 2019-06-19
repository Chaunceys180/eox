///  This is the User class that represents the user using the application
///  @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
///  Dianna Carranza, and Eduard Romanyuk
///  @version 1.1.0

class User {
  String _email;
  String _password;

  //TODO: figure out encryption on flutter

  User(String email, String password) {
    this._email = email;
    this._password = password;
  }

  String get email => _email;

  String get password => _password;

  set email(String value) {
    _email = value;
  }

  @override
  String toString() {
    return 'UserModel{_email: $_email}';
  }
}
