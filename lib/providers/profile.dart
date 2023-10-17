import 'package:flutter/foundation.dart';
import 'package:chosungood/utiles/parse_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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

  void singinWithToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('access_token');
    if (token == null) return;
    try {
      String userAPIURL = dotenv.env['USER_API_URL']!;
      final url = Uri.parse("$userAPIURL/verify-token");
      await http.post(url, headers: {"Autorization": "Bearer $token"});
      signin(token);
      // ignore: empty_catches
    } catch (e) {}
  }

  void signin(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var data = parseJwt(accessToken);
      _mbti = data['user_mbti'];
      _name = data['user_name'];
      _uid = data['uid'];
      _accessToken = accessToken;
      _isSignIn = true;

      await prefs.setString('access_token', _accessToken);
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
