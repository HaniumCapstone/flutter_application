import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Love chosun kakao login page'),
      ),
      body: Align(
        alignment: Alignment(0, 0.5), // 화면의 1/4 위치로 설정 (-1.0 ~ 1.0 사이의 값을 사용)
        child: InkWell(
          onTap: () {
            // 여기서 로그인 버튼을 클릭했을 때 처리할 로직을 구현합니다.
            _handleKakaoLogin();
          },
          child: Image.asset('assets/K_login_images/ko/kakao_login_large_wide.png'), // 이미지 버튼을 위한 이미지 설정
        ),
      ),
    );
  }


  // Kakao 로그인 처리를 담당하는 메소드
  void _handleKakaoLogin() async {
    try {
      // KakaoTalk 설치 여부 확인

      if (await isKakaoTalkInstalled()) {
        try {
          // 카카오톡으로 로그인 시도

          await UserApi.instance.loginWithKakaoTalk();
          print('카카오톡으로 로그인 성공');
        } catch (error) {
          print('카카오톡으로 로그인 실패 $error');

          // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
          // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
          if (error is PlatformException && error.code == 'CANCELED') {
            return;
          }
          // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인 시도
          try {
            await UserApi.instance.loginWithKakaoAccount();
            print('카카오계정으로 로그인 성공');
          } catch (error) {
            print('카카오계정으로 로그인 실패 $error');
          }
        }
      } else {
        try {
          // 카카오계정으로 로그인 시도
          await UserApi.instance.loginWithKakaoAccount();
          print('카카오계정으로 로그인 성공');
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
        }
      }
    } catch (e) {
      // 로그인 실패
      print('Kakao 로그인 실패 - 에러메시지: $e');
    }
  }
}
