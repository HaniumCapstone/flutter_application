import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import 'calendar_bottom_sheet.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  void _showDayInfoBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.5, // Set height to 80% of screen height
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
            color: Colors.white,
          ),
          child: DayInfoBottomSheet(_selectedDay),
        );
      },
    );
  }



  /*
  void _showDayInfoBottomSheet(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return DayInfoBottomSheet(_selectedDay); // Use the bottom sheet widget
      },
    );
  }
   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('캘린더 페이지'),
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2021, 1, 1),
            lastDay: DateTime.utc(2023, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
              _showDayInfoBottomSheet(context); // 바텀시트 표시 함수 호출
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
          ),
          SizedBox(height: 16),
          Center(
            child: Text(
              '선택된 날짜: ${_selectedDay.toLocal()}',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
