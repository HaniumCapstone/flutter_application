import 'package:chosungood/components/shared/cr_button.dart';
import 'package:chosungood/components/shared/friendship_bar.dart';
import 'package:chosungood/providers/profile.dart';
import 'package:chosungood/screens/mypage.dart';
import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomepageHeader extends StatelessWidget {
  final Character character;

  const HomepageHeader(String s, {super.key, required this.character});

  final double buttonSpacing = 8.0;
  final double buttonHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.end, // 주 축을 세로 방향으로 유지 (기본값)
          children: [
            Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      character.mbti,
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 16.0),
                    ),
                    Text(
                      character.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.none,
                          fontSize: 30.0),
                    ),
                    FriendshipBar("$character friendship", percent: 0.3)
                  ],
                )),
            CrButton('mypage button', text: 'MY', onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyPage()));
            })
          ],
        ));
  }
}
