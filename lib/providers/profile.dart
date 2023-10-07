import 'package:flutter/foundation.dart';
import 'package:chosungood/utiles/parse_jwt.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Character {
  int characterId;
  String name;
  String mbti;
  String era;
  String description;

  Character(
      {required this.characterId,
      required this.name,
      required this.mbti,
      required this.era,
      required this.description});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      characterId: json['character_id'],
      description: json['description'],
      mbti: json['mbti'],
      name: json['name'],
      era: json['era'],
    );
  }
}

List<Character> parseData(String jsonData) {
  final parsed = json.decode(jsonData).cast<Map<String, dynamic>>();
  return parsed.map<Character>((json) => Character.fromJson(json)).toList();
}

class CPProfile with ChangeNotifier {
  bool _isSignIn = false;
  String _accessToken = '';
  String _mbti = '';
  String _name = '';
  String _uid = '';
  String _target = '';
  List<Character> _matches = [];
  late Character? _targetCharacter;

  bool get isSingIn => _isSignIn;
  String get accessToken => _accessToken;
  String get mbti => _mbti;
  String get name => _name;
  String get uid => _uid;
  String get target => _target;
  Character? get targetCharacter => _targetCharacter;

  List<Character> get matches => _matches;

  void dummySignin() {
    var data = parseJwt(
        "eyJhbGciOiJIUzI1NiJ9.eyJ1aWQiOiIyOTc2MDk3MTgwIiwidXNlcl9uYW1lIjoi7J2067O47JiBIiwidXNlcl9tYnRpIjoiSVNUUCJ9.-Kyjh-mb5hQ2Oq58OADfHLXy26f52nAqS2fVUnlltGg");
    _mbti = data['user_mbti'];
    _name = data['user_name'];
    _uid = data['uid'];
    _target = data['character_id'];
    _accessToken = accessToken;

    _isSignIn = true;
    if (_target != '') {
      _targetCharacter = fetchTargetCharacter(int.parse(_target)) as Character;
    }
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

  fetchData() async {
    String userAPIURL = dotenv.env['USER_API_URL']!;

    final url = Uri.parse("$userAPIURL/get-match?mbti=$_mbti");

    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 응답 성공
      final data = response.body;
      // 데이터 처리 로직
      return parseData(data);
    } else {
      // 응답 실패
      throw Exception('매치 데이터를 가져오지 못했습니다.');
    }
  }

  Future<void> loadMatchingCharacters() async {
    _matches = await fetchData(); // 데이터 로드

    // 데이터가 업데이트되었음을 Provider에 알림
    notifyListeners();
  }

  Future<Character> fetchTargetCharacter(int targetId) async {
    String userAPIURL = dotenv.env['USER_API_URL']!;

    final url = Uri.parse("$userAPIURL/character/$targetId");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // 응답 성공
      final data = response.body;
      return Character.fromJson(json.decode(data));
      // 데이터 처리 로직
    } else {
      // 응답 실패
      throw Exception('매칭 인물을 등록하지 못했습니다.');
    }
    // 데이터가 업데이트되었음을 Provider에 알림
  }

  Future<void> updateTarget(int targetId) async {
    String userAPIURL = dotenv.env['USER_API_URL']!;

    final url = Uri.parse("$userAPIURL/update-target");
    print(targetId.toString());
    final response = await http.post(url,
        headers: {
          "Authorization": "Bearer $_accessToken",
          "Content-Type": "application/json; charset=UTF-8"
        },
        body: json.encode({"character": targetId.toString()}));
    if (response.statusCode == 200 || response.statusCode == 201) {
      // 응답 성공
      final data = response.body;
      _target = targetId.toString();
      _targetCharacter = Character.fromJson(json.decode(data));
      // 데이터 처리 로직
    } else {
      // 응답 실패
      throw Exception('매칭 인물을 등록하지 못했습니다.');
    }
    // 데이터가 업데이트되었음을 Provider에 알림
    notifyListeners();
  }

  void signin(String accessToken) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    try {
      var data = parseJwt(accessToken);
      _mbti = data['user_mbti'] ?? '';
      _name = data['user_name'] ?? '';
      _uid = data['uid'] ?? '';
      _target = data['character_id'] ?? '';
      _accessToken = accessToken;
      _isSignIn = true;

      await prefs.setString('access_token', _accessToken);

      if (_target != '') {
        _targetCharacter =
            fetchTargetCharacter(int.parse(_target)) as Character;
      }
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
    _target = '';
    notifyListeners();
  }
}
