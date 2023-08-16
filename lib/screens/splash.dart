import 'package:chosungood/screens/kakaologin.dart';
import 'package:flutter/material.dart';


class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 스플래시 화면 UI
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          'My App Splash',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }

  Future<void> loadInitialData(BuildContext context) async {
    // 초기화 작업을 여기에서 수행
    // 예: 데이터 로딩, 설정 로딩 등

    // 초기화 작업이 끝나면 원하는 화면으로 전환
    await Future.delayed(Duration(seconds: 1));
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

// 스플래시 화면이 보여질 때 초기화 작업을 시작하도록 initState()를 이용합니다.
// StatefulWidget를 사용해야 하므로 StatefulWidget을 만들어서 사용하세요.
}
