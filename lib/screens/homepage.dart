import 'package:chosungood/components/homepage/homepage_header.dart';
import 'package:chosungood/components/shared/menu_nav.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Expanded(
            child: Image.asset(
          'assets/images/tiger.png',
          fit: BoxFit.cover, // 이미지를 화면에 가득 채우도록 설정
          width: double.infinity, // 화면 가로 전체 너비 설정
          height: double.infinity, // 화면 세로 전체 높이 설정
        )),
        const Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: EdgeInsets.only(top: 60.0),
                child: HomepageHeader(
                  "세종대왕",
                  character: '세종대왕',
                )),
            Padding(padding: EdgeInsets.only(bottom: 20.0), child: MenuNav())
          ],
        )
      ],
    );
  }
}
