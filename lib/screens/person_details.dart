import 'package:flutter/material.dart';
import 'person.dart';

class PersonDetailsPage extends StatelessWidget {
  final Person person;

  PersonDetailsPage({required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('인물 상세 정보'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '이름: ${person.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('MBTI: ${person.mbti ?? "정보 없음"}'), // Handle null values
            SizedBox(height: 8),
            Text('출생일: ${person.birth_Date ?? "정보 없음"}'), // Handle null values
            SizedBox(height: 8),
            Text('사망일: ${person.death_Date ?? "정보 없음"}'), // Handle null values
            SizedBox(height: 8),
            Text('시대: ${person.era ?? "정보 없음"}'), // Handle null values
            SizedBox(height: 16),
            Text('자세한 정보:\n${person.description ?? "정보 없음"}'), // Handle null values
          ],
        ),
      ),
    );
  }
}
