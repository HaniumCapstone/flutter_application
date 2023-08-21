import 'dart:convert';

import 'package:chosungood/providers/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const mbti = [
  "ENFP",
  "ENFJ",
  "ENTP",
  "ENTJ",
  "ESFP",
  "ESFJ",
  "ESTP",
  "ESTJ",
  "INFP",
  "INFJ",
  "INTP",
  "INTJ",
  "ISFP",
  "ISFJ",
  "ISTP",
  "ISTJ",
];

class MBTIInput extends StatelessWidget {
  const MBTIInput({super.key});

  @override
  Widget build(BuildContext context) {
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
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 2.5,
                    ),
                    itemCount: 16,
                    itemBuilder: (context, gridIndex) {
                      return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: GridItem(item: mbti[gridIndex]));
                    },
                  ),
                ],
              ));
        },
      ),
    );
  }
}

class GridItem extends StatelessWidget {
  final String item;

  const GridItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final token = Provider.of<CPProfile>(context).accessToken;
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
            padding: const EdgeInsets.all(16.0),
            textStyle:
                const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          onPressed: () async {
            try {
              String userAPIURL = dotenv.env['USER_API_URL']!;
              final url = Uri.parse("$userAPIURL/mbti");
              final response = await http.post(url,
                  headers: {
                    'Content-type': 'application/json',
                    'Accept': 'application/json',
                    "Authorization": "Bearer $token"
                  },
                  body: json.encode({'mbti': item}));

              // ignore: use_build_context_synchronously
              context
                  .read<CPProfile>()
                  .signin(json.decode(response.body)['accessToken']);
            } catch (error) {
              print("mbti수정 실패 $error");
            }
          },
          child: Text(item),
        ),
      ],
    );
  }
}
