import 'package:chosungood/screens/mbti_input.dart';
import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/material.dart';
import 'package:chosungood/screens/kakaologin.dart';
import '../utiles/handle_kakao_login.dart';

import 'package:provider/provider.dart';
import 'package:chosungood/providers/profile.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      setState(() {
        _showSplash = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 초기화 작업을 여기에서 수행
    // 예: 데이터 로딩, 설정 로딩 등

    if (_showSplash) {
      // Splash 화면 UI
      return const Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Text(
            '조선제일검',
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
    }

    final cpProfile = Provider.of<CPProfile>(context);

    // 초기화 작업이 끝나면 원하는 화면으로 전환
    print(cpProfile.isSingIn);
    print(cpProfile.mbti);

    if (cpProfile.isSingIn && cpProfile.mbti != '') {
      return const DashBoard();
    } else if (cpProfile.isSingIn && cpProfile.mbti == '') {
      return const MBTIInput();
    } else {
      return const LoginPage(handleKakaoLogin: handleKakaoLogin);
    }
  }
}
