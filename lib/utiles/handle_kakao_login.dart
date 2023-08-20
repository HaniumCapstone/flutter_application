import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

onKakaoLoginFail(Object? error) {
  if (kDebugMode) {
    print('카카오톡으로 로그인 실패 $error');
  }

  return null;
}

String onKakaoLoginSuccess(OAuthToken token) {
  if (kDebugMode) {
    print('카카오톡으로 로그인 성공');
  }

  return token.accessToken;
}

Future<String?> handleKakaoLogin(BuildContext context) async {
  try {
    // KakaoTalk 설치 여부 확인

    if (await isKakaoTalkInstalled()) {
      try {
        // 카카오톡으로 로그인 시도

        return onKakaoLoginSuccess(await UserApi.instance.loginWithKakaoTalk());
      } catch (error) {
        onKakaoLoginFail(error);
        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return null;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인 시도
        try {
          return onKakaoLoginSuccess(
              await UserApi.instance.loginWithKakaoTalk());
        } catch (error) {
          return onKakaoLoginFail(error);
        }
      }
    } else {
      try {
        // 카카오계정으로 로그인 시도
        return onKakaoLoginSuccess(
            await UserApi.instance.loginWithKakaoAccount());
      } catch (error) {
        return onKakaoLoginFail(error);
      }
    }
  } catch (error) {
    // 로그인 실패
    return onKakaoLoginFail(error);
  }
}
