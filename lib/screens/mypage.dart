import 'package:chosungood/components/shared/cr_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/profile.dart';

class MyPage extends StatelessWidget {
  const MyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CrButton(
      'logout',
      onPressed: () {
        context.read<CPProfile>().signout();
      },
      text: '로그아웃',
    );
  }
}
