import 'package:flutter/foundation.dart';
import 'package:chosungood/utiles/parse_jwt.dart';

class CPProfile with ChangeNotifier {
  bool _isSignIn = false;
  String _accessToken = '';
  String _mbti = '';
  String _name = '';
  String _uid = '';

  bool get isSingIn => _isSignIn;
  String get accessToken => _accessToken;
  String get mbti => _mbti;
  String get name => _name;
  String get uid => _uid;

  void dummySignin() {
    var data = parseJwt(
        "eyJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyOTc2MDk3MTgwIiwidXNlcl9uYW1lIjoi7J2067O47JiBIiwidXNlcl9tYnRpIjoiSVNUUCJ9.-Kyjh-mb5hQ2Oq58OADfHLXy26f52nAqS2fVUnlltGg");
    _mbti = data['user_mbti'];
    _name = data['user_name'];
    _uid = data['uid'];
    _accessToken = accessToken;
    _isSignIn = true;
  }

  void signin(String accessToken) {
    try {
      var data = parseJwt(accessToken);
      _mbti = data['user_mbti'];
      _name = data['user_name'];
      _uid = data['uid'];
      _accessToken = accessToken;
      _isSignIn = true;
    } catch (error) {
      _isSignIn = false;
      if (kDebugMode) {
        print('jwt토큰 파싱 오류 : $error');
      }
    }
    notifyListeners();
  }

  void signout() {
    _isSignIn = false;
    _accessToken = '';
    _mbti = '';
    _name = '';
    _uid = '';
    notifyListeners();
  }
}
