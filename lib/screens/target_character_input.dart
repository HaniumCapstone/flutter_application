import 'package:chosungood/components/shared/cr_button.dart';
import 'package:chosungood/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class TargetCharacterInput extends StatefulWidget {
  const TargetCharacterInput({super.key});

  @override
  State<TargetCharacterInput> createState() => _TargetCharacterInputState();
}

class _TargetCharacterInputState extends State<TargetCharacterInput> {
  List<String> dataList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<CPProfile>(context);
    final String userMbti = profile.mbti;

    // 초기화 작업을 여기에서 수행
    // 예: 데이터 로딩, 설정 로딩 등
    if (profile.matches.isNotEmpty) {
      return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.only(top: 50),
          itemCount: 1,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '매칭 위인 선택',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    const Text(
                      '매칭 위인이 없을 경우 전체 위인 중 선택',
                      style: TextStyle(
                          fontSize: 16, fontWeight: FontWeight.normal),
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 2.5,
                      ),
                      itemCount: profile.matches.length,
                      itemBuilder: (context, gridIndex) {
                        final data = profile.matches[gridIndex];

                        return Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: GridItem(item: data));
                      },
                    ),
                  ],
                ));
          },
        ),
      );
    }

    return Scaffold(
      body: ListView.builder(
        padding: const EdgeInsets.only(top: 50),
        itemCount: 1,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MBTI 선택',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 600,
                    child: CrButton(
                      "request match",
                      text: "$userMbti 매치 찾기",
                      onPressed: () {
                        print('매치 찾기 ');
                        profile.loadMatchingCharacters();
                      },
                    ),
                  )
                ],
              ));
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final Character item;

  const GridItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<CPProfile>(context);

    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey.shade400),
                borderRadius: const BorderRadius.all(Radius.circular(5))),
          ),
        ),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
            profile.updateTarget(item.characterId);
          },
          child: Column(children: [
            Text(item.name),
            Text(
              item.mbti,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            )
          ]),
        ),
      ],
    );
  }
}
