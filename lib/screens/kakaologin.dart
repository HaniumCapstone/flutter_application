import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:chosungood/providers/profile.dart';

import 'package:http/http.dart' as http;

class LoginPage extends StatelessWidget {
  const LoginPage({super.key, required this.handleKakaoLogin});

  final Function(BuildContext) handleKakaoLogin;

  @override
  Widget build(BuildContext context) {
    // 유효한 토큰이 있을 경우 자동 로그인
    final cpProfile = Provider.of<CPProfile>(context);
    cpProfile.singinWithToken();

    return Scaffold(
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: Container(
                color: Colors.white,
                child: Center(
                  child: Image.asset('assets/images/duguncho.png'),
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0), // 양 옆 여백 설정
                child: InkWell(
                  onTap: () async {
                    try {
                      String token = await handleKakaoLogin(context);
                      String userAPIURL = dotenv.env['USER_API_URL']!;
                      final url = Uri.parse("$userAPIURL/join");

                      final response = await http.post(url, body: {
                        'kAccessToken': token,
                      });
                      // ignore: use_build_context_synchronously
                      context
                          .read<CPProfile>()
                          .signin(json.decode(response.body)['accessToken']);

                      if (kDebugMode) {
                        print('유저 가입/로그인 성공');
                        print(response.body);
                        print(json.decode(response.body));
                      }
                    } catch (error) {
                      if (kDebugMode) {
                        print('유저 로그인 실패 ');
                      }
                    }
                  },
                  child: Image.asset(
                      'assets/K_login_images/ko/kakao_login_large_wide.png'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
