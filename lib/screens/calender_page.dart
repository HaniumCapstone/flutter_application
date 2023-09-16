import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalendarPage(),
    );
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime(DateTime.now().year, DateTime.now().month, 1);
  DateTime? _selectedDay;
  Map<DateTime, List<dynamic>> _events = {};
  String _eventDetails = '';
  List<DateTime> _sortedEventDates = [];

  @override
  void initState() {
    super.initState();
    _events = {
      DateTime(2023, 9, 13): ['이벤트 1'],
      DateTime(2023, 9, 19): ['now event'],
      DateTime(2023, 9, 20): ['이벤트 2'],
      DateTime(2023, 9, 18): ['now event'],
      DateTime(2023, 10, 13): ['이벤트 1'],
      DateTime(2023, 8, 19): ['now event'],
      DateTime(2023, 8, 20): ['이벤트 2'],
      DateTime(2023, 10, 18): ['now event'],
    };

    // 이벤트 날짜를 정렬
    _sortedEventDates = _events.keys.toList()..sort();
  }

  void _sortEventsByMonth(DateTime month) {
    _sortedEventDates = _events.keys.where((date) {
      return date.year == month.year && date.month == month.month;
    }).toList()..sort();
  }

  Future<void> _showDateDetailsDialog(DateTime selectedDay) async {
    final selectedDate = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
    final events = _events[selectedDate] ?? [];
    String eventDetails = events.isEmpty ? '이벤트 없음' : events.join('\n');

    setState(() {
      _selectedDay = selectedDate;
      _eventDetails = eventDetails;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('달력'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              firstDay: DateTime(2000),
              lastDay: DateTime(2050),
              focusedDay: _focusedDay,
              calendarFormat: _calendarFormat,
              eventLoader: (date) {
                final selectedDate = DateTime(date.year, date.month, date.day);
                return _events[selectedDate] ?? [];
              },
              calendarBuilders: CalendarBuilders(
                selectedBuilder: (context, date, _) {
                  return Container(
                    margin: const EdgeInsets.all(4.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.pink,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      date.day.toString(),
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
              onFormatChanged: (format) {
                setState(() {
                  _calendarFormat = format;
                });

                // 월 형식이 변경될 때 이벤트 정렬
                if (format == CalendarFormat.month) {
                  _sortEventsByMonth(_focusedDay);
                }
              },
              onPageChanged: (focusedDay) {
                // 페이지 변경 시 _focusedDay 업데이트
                setState(() {
                  _focusedDay = focusedDay;
                });

                // 페이지 변경 시 월 형식일 때 이벤트 정렬
                if (_calendarFormat == CalendarFormat.month) {
                  _sortEventsByMonth(focusedDay);
                }
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                });
                _showDateDetailsDialog(selectedDay);
              },
            ),
            if (_selectedDay != null)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _eventDetails,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            if (_calendarFormat == CalendarFormat.month)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sortedEventDates.map((date) {
                    return Text(
                      '${date.year}-${date.month}-${date.day}: ${_events[date]!.join(", ")}',
                      style: TextStyle(fontSize: 16),
                    );
                  }).toList(),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
