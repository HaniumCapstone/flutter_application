import 'package:chosungood/screens/mbti_input.dart';
import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chosungood/screens/kakaologin.dart';
import '../utiles/handle_kakao_login.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    String withoutLogin = dotenv.env['WITHOUT_LOGIN']!;
    String? appName = dotenv.env['APP_NAME'];

    if (_showSplash) {
      // Splash 화면 UI
      return Scaffold(
        backgroundColor: Colors.blue,
        body: Center(
          child: Text(
            appName ?? '두근두근 조선',
            style: const TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      );
    }

    final cpProfile = Provider.of<CPProfile>(context);
    if (kDebugMode) {
      print(cpProfile.isSingIn);
      print(cpProfile.mbti);
    }

    // 초기화 작업이 끝나면 원하는 화면으로 전환

    if (withoutLogin == 'true') {
      cpProfile.dummySignin();
      // ignore: use_build_context_synchronously
      // Provider.of<CPProfile>(context).dummySignin();
      // return const DashBoard();
    }

    if (cpProfile.isSingIn && cpProfile.mbti != '') {
      return DashBoard();
    } else if (cpProfile.isSingIn && cpProfile.mbti == '') {
      return const MBTIInput();
    } else {
      return const LoginPage(handleKakaoLogin: handleKakaoLogin);
    }
  }
}
