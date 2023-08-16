

import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  final Function(BuildContext) handleKakaoLogin;

  LoginPage({required this.handleKakaoLogin});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love Korean History'),
      ),
      body: Column(
        children: [
          Flexible(
            flex: 3,
            child: Align(
              alignment: Alignment.topCenter,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
                itemCount: 4,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.grey,
                    child: Center(
                      child: Image.asset('assets/images/tiger.png'),
                    ),
                  );
                },
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // 양 옆 여백 설정
                child: InkWell(
                  onTap: () {
                    handleKakaoLogin(context);
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


