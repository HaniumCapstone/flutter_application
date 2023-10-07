import 'package:chosungood/components/shared/cr_button.dart';
import 'package:chosungood/screens/calender_page.dart';
import 'package:chosungood/screens/kakaomap.dart';
import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/material.dart';

class MenuNav extends StatelessWidget {
  const MenuNav({super.key});
  final double buttonSpacing = 8.0;
  final double buttonHeight = 60.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 30.0, right: 20.0, left: 20.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Expanded(
          child: CrButton(
            'mapBtn',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => KakaoMapPage()));
            },
            text: '지도',
          ),
        ),
        SizedBox(width: buttonSpacing),
        Expanded(
          child: CrButton(
            'charBtn',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => DashBoard()));
            },
            text: '인물도감',
          ),
        ),
        SizedBox(width: buttonSpacing),
        Expanded(
          child: CrButton(
            'calBtn',
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => CalendarPage()));
            },
            text: '캘린더',
          ),
        ),
      ]),
    );
  }
}
