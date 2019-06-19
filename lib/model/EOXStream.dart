/// This is the EOXStream class, that represents a stream object
/// @author Conner Ledbetter, Chauncey Brown-Castro, Janell Wilson,
/// Dianna Carranza, and Eduard Romanyuk
/// @version 1.0

class EOXStream {
  bool _isActive = false;
  bool _isConnected = false;
  String _name = "";
  String _url = "";
  String _id = "";
  bool isMine = false;
  bool _isSelected = false;

  EOXStream(this._isActive, this._isConnected, this._name, this._url);

  String get id => _id;

  set id(String value) {
    _id = value;
  }

  String get url => _url;

  set url(String value) {
    _url = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool get isConnected => _isConnected;

  set isConnected(bool value) {
    _isConnected = value;
  }

  bool get isActive => _isActive;

  set isActive(bool value) {
    _isActive = value;
  }

  @override
  String toString() {
    return 'Stream{_isActive: $_isActive, _isConnected: '
        '$_isConnected, _name: $_name, _url: $_url}';
  }

  bool get isSelected => _isSelected;

  set isSelected(bool value) {
    _isSelected = value;
  }
}
