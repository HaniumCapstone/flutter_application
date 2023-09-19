import 'dart:convert';

import 'package:chosungood/screens/person.dart';
import 'package:chosungood/screens/persondict.dart';
import 'package:flutter/material.dart';
import 'package:chosungood/providers/profile.dart';
import 'package:http/http.dart' as http;

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  List<Person> people = [];
  List<String> personImageFileNames = List.generate(19, (index) => 'img${index + 1}.jpeg');
  bool _isLoading = true;

  Future<void> fetchPeopleFromDatabase() async {
    final response = await http.get(Uri.parse('http://18.188.95.144/person_data_return.php'));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Person> fetchedPeople = [];
      int index=0;
      for (var personData in jsonData) {
        final person = Person(
          c_id: personData['character_id'] ?? '',
          name: personData['name'] ?? '',
          mbti: personData['mbti'] ?? '',
          birth_Date: personData['birth_date'] ?? '',
          death_Date: personData['death_date'] ?? '',
          era: personData['era'] ?? '',
          description: personData['description'] ?? '',
          imageFileName: personImageFileNames[index % personImageFileNames.length],
        );
        fetchedPeople.add(person);
        index++;
      }

      setState(() {
        people = fetchedPeople;
        _isLoading = false;
      });
      print("Received data: $jsonData");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPeopleFromDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마이페이지'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Column(
        children: [
          Row(
            children: [
              SizedBox(height: 40),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: 20, left: 20), // 오른쪽 마진 추가
                  height: 50, // 왼쪽 회색 박스의 높이
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('INTJ'),
                        Text(
                          '세종대왕',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Icon(
                Icons.favorite, // 하트 모양 아이콘
                color: Colors.red, // 빨간색
                size: 50.0, // 아이콘 크기
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(left: 20, right: 20), // 왼쪽 마진 추가
                  height: 50, // 오른쪽 회색 박스의 높이
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.black, width: 2),
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('ENFJ'),
                        Text(
                          '최명헌 님',
                          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10), // 추가한 공간
          //HERE
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0), // 양 옆 마진을 조절하세요.
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                'assets/images/favorate_bar.png', // 이미지 경로를 수정하세요.
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20), // 큰 회색 박스의 마진 설정
            height: 200, // 큰 회색 박스의 높이 설정
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.black, width: 2),
              color: Color.fromRGBO(200, 200, 200, 1.0),
            ),
            child: Column(
              children: [
                // 상단 이미지와 텍스트
                Container(
                  width: double.infinity, // 리스트 너비를 상위 컨테이너의 너비와 같게 설정
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1, // 이미지의 비율을 1로 설정
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(200, 200, 200, 1.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/per_images/img1.jpeg', // 이미지 경로
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2, // 텍스트의 비율을 3으로 설정
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(200, 200, 200, 1.0),
                          ),
                          child: Text(
                            '“고기는 씹을수록 맛이 난다. 그리고 책도 읽을수록 맛이 난다.”\n\nMBTI: ${people[0].mbti} \n출생일: ${people[0].birth_Date} \n기일: ${people[0].death_Date} \n시대: ${people[0].era}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // 세로로 된 리스트 (예시)
          Expanded(
            child: ListView.builder(
              shrinkWrap: true, // 리스트 높이를 내용에 맞게 조절
              itemCount: 5, // 리스트 아이템 개수
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: double.infinity, // 리스트 아이템 너비를 상위 컨테이너의 너비와 같게 설정
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 2),
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1, // 이미지의 비율을 1로 설정
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(200, 200, 200, 1.0),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'assets/per_images/img${index+2}.jpeg', // 예시: 이미지 경로
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4, // 텍스트의 비율을 3으로 설정
                        child: Container(
                          margin: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromRGBO(200, 200, 200, 1.0),
                          ),
                          child: Text(
                            '${people[index+1].name}\n\n출생일: ${people[index+1].birth_Date} \n기일: ${people[index+1].death_Date} \n시대: ${people[index+1].era}',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                          ),

                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 20,),
          // 버튼
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: EdgeInsets.only(bottom: 80, right: 30), // 아래쪽과 오른쪽 여백 조절
              child: Container(
                width: 100, // 버튼의 너비 설정
                height: 40, // 버튼의 높이 설정
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DashBoard()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey, // 버튼 배경색
                  ),
                  child: Text(
                    '인물사전',
                    style: TextStyle(
                      color: Colors.black,fontWeight: FontWeight.bold // 텍스트 색상을 빨간색으로 변경
                    ),
                  ),
                ),
              ),
            ),
          ),



        ],
      ),
    );
  }
}
