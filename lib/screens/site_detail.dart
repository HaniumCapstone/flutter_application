import 'dart:ui';

import 'package:chosungood/screens/calender_page.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'sites.dart'; // HistoricSite 클래스를 import

class SiteDetailPage extends StatelessWidget {
  final HistoricSite site;

  SiteDetailPage({required this.site});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        constraints: BoxConstraints(
          minWidth: 400, // 최소 너비 지정
          minHeight: 500,
          maxHeight: 600,
        ),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
          children: [
            SizedBox(height: 16), // 버튼 사이에 추가 여백
            Text(
              site.siteName ?? '', // HistoricSite 객체에서 siteName 가져오기
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // 왼쪽 정렬
              children: [
                Align(
                  alignment: Alignment.center, // 이미지 가운데 정렬
                  child: Image.network(
                    site.siteLink ?? '', // 이미지 URL
                    width: 250, // 이미지 너비
                    height: 150, // 이미지 높이
                    fit: BoxFit.cover, // 이미지를 비율 유지하면서 채우도록 설정
                  ),
                ),
                SizedBox(height: 16),
                Text(
                  '유적지 설명:',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  site.siteDescription ?? '정보 없음',
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
            SizedBox(height: 16), // 버튼 위에 추가 여백
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround, // 가운데 정렬
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        // 두 번째 버튼 눌렀을 때 웹 페이지 열기
                        final url = Uri.parse(site.imageLink ?? 'naver.com');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(url);
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 15, // 버튼 세로 크기 조절
                          horizontal: 30, // 버튼 가로 크기 조절
                        ),
                      ),
                      child: Text('🔍 자세히 ',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 두 번째 버튼 눌렀을 때 수행할 동작 추가
                        // 두 번째 버튼 눌렀을 때 KakaoMapPage로 이동하는 코드
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => CalendarPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                          vertical: 15, // 버튼 세로 크기 조절
                          horizontal: 30, // 버튼 가로 크기 조절
                        ),
                      ),
                      child: Text('🌐 지도에서 보기 ',style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
