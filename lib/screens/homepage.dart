import 'package:chosungood/components/homepage/homepage_header.dart';
import 'package:chosungood/components/shared/menu_nav.dart';
import 'package:chosungood/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cpProfile = Provider.of<CPProfile>(context);
    final perId = cpProfile.targetCharacter!.characterId;

    if (cpProfile.targetCharacter == null) {
      return const Text('로딩중..',
          style: TextStyle(decoration: TextDecoration.none));
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Expanded(
            child: Image.asset(
          'assets/per_images/img$perId.jpeg',
          fit: BoxFit.cover, // 이미지를 화면에 가득 채우도록 설정
          width: double.infinity, // 화면 가로 전체 너비 설정
          height: double.infinity, // 화면 세로 전체 높이 설정
        )),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: HomepageHeader(
                  cpProfile.targetCharacter!.name,
                  character: cpProfile.targetCharacter!,
                )),
            const Padding(
                padding: EdgeInsets.only(bottom: 20.0), child: MenuNav())
          ],
        )
      ],
    );
  }
}
