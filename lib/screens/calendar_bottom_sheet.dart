import 'package:flutter/material.dart';

class DayInfoBottomSheet extends StatelessWidget {
  final DateTime selectedDay;

  DayInfoBottomSheet(this.selectedDay);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Container(
              height: 4.0,
              width: 140.0,
              margin: EdgeInsets.only(bottom: 8.0),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(2.0),
              ),
            ),
            SizedBox(height: 15.0), // 원하는 공백 추가
            Text(
              '선택된 날짜: ${selectedDay.toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
