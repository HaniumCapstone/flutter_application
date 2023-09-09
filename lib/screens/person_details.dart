import 'dart:convert';
import 'package:chosungood/screens/site_detail.dart';
import 'package:chosungood/screens/sites.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'person.dart';


class PersonDetailsPage extends StatelessWidget {
  final Person person;

  PersonDetailsPage({required this.person});

  Future<List<HistoricSite>> fetchData() async {
    final cId = person.c_id; // Person 객체에서 c_id 가져오기
    final url = Uri.parse('http://18.188.95.144/historic_site_load.php?c_id=$cId'); // PHP 서버의 URL 설정

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // 데이터를 정상적으로 가져온 경우
        final jsonData = json.decode(response.body);
        final List<HistoricSite> sites = [];

        // JSON 데이터를 HistoricSite 객체로 변환하여 저장
        for (var item in jsonData) {
          final site = HistoricSite(
            siteId: int.tryParse(item['site_id'] ?? ''),
            characterId: int.tryParse(item['character_id'] ?? ''),
            siteName: item['site_name'],
            siteLink: item['site_link'],
            imageLink: item['image_link'],
            siteDescription: item['site_description'],
            longitude: double.tryParse(item['longitude'] ?? ''),
            latitude: double.tryParse(item['latitude'] ?? ''),
          );
          sites.add(site);
        }
        print("Received data: $jsonData");

        return sites;
      } else {
        // HTTP 요청이 실패한 경우
        throw Exception('HTTP 요청 실패: ${response.statusCode}');
      }
    } catch (e) {
      // 오류 처리
      print('오류 발생: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인물 상세 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // 데이터를 가져오는 중인 경우 로딩 화면 표시
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // 오류가 발생한 경우 오류 메시지 표시
              return Center(child: Text('데이터를 불러올 수 없습니다.'));
            } else {
              final List<HistoricSite> sites = snapshot.data as List<HistoricSite>;

              // 데이터를 정상적으로 가져온 경우 화면 표시
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '이름: ${person.name}',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    height: 200,
                    child: Image.asset(
                      'assets/per_images/${person.imageFileName}',
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('MBTI: ${person.mbti ?? "정보 없음"}'),
                  SizedBox(height: 8),
                  Text('출생일: ${person.birth_Date ?? "정보 없음"}'),
                  SizedBox(height: 8),
                  Text('사망일: ${person.death_Date ?? "정보 없음"}'),
                  SizedBox(height: 8),
                  Text('시대: ${person.era ?? "정보 없음"}'),
                  SizedBox(height: 16),
                  Text('자세한 정보:\n${person.description ?? "정보 없음"}'),
                  SizedBox(height: 8),
                  Container(
                    color: Color.fromRGBO(200, 200, 200, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${person.name} 관련 유적지',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    color: Color.fromRGBO(200, 200, 200, 1.0), // 회색 박스 배경색
                    padding: EdgeInsets.all(16.0), // 패딩 설정
                    height: 200, // 높이 조절
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal, // 이미지들을 가로로 나열
                      itemCount: sites.length, // 이미지 개수를 JSON 데이터의 길이로 설정
                      itemBuilder: (BuildContext context, int index) {
                        final site = sites[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 8.0), // 이미지 사이 간격
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return SiteDetailPage(site: site); // SiteDetailPage는 팝업 페이지입니다.
                                    },
                                  );
                                },
                                child: Container(
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black, width: 1.0),
                                  ),
                                  child: Image.network(
                                    site.siteLink ?? '',
                                    width: 150,
                                    height: 150,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),

                              SizedBox(height: 8), // 텍스트와 이미지 사이 간격 조절
                              Text(
                                site.siteName ?? '', // HistoricSite 객체에서 siteName 가져오기
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),

                ],
              );
            }
          },
        ),
      ),
    );
  }
}
