import 'package:flutter/material.dart';
import 'package:chosungood/screens/kakaologin.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 초기화 작업을 여기에서 수행
    // 예: 데이터 로딩, 설정 로딩 등

    // 초기화 작업이 끝나면 원하는 화면으로 전환
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    });

    // Splash 화면 UI
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Center(
        child: Text(
          '조선제일검',
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
