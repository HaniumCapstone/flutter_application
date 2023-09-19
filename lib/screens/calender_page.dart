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
      DateTime(2023, 5, 15): ['세종대왕 생일'],
      DateTime(2023, 3, 30): ['세종대왕 기일'],
      DateTime(2023, 8, 5): ['다산 정약용 생일'],
      DateTime(2023, 4, 7): ['다산 정약용 기일'],
      DateTime(2023, 10, 28): ['정조 생일'],
      DateTime(2023, 8, 18): ['정조 기일'],
      DateTime(2023, 2, 27): ['율곡이이 기일'],
      DateTime(2023, 10, 26): ['율곡이이 생일'],
      DateTime(2023, 11,3 ): ['허균 생일'],
      DateTime(2023, 8,24 ): ['허균 기일'],
      DateTime(2023, 11,23 ): ['연산군 생일'],
      DateTime(2023, 11,20 ): ['연산군 기일'],
      DateTime(2023, 4,28 ): ['이순신 생일'],
      DateTime(2023, 12,16 ): ['이순신 기일'],
      DateTime(2023, 10,31 ): ['영조 생일'],
      DateTime(2023, 4,22 ): ['영조 기일'],
      DateTime(2023, 6,13 ): ['태종 이방원 생일'],
      DateTime(2023, 5,30 ): ['태종 이방원 기일'],
      DateTime(2023, 12,5 ): ['신사임당 생일'],
      DateTime(2023, 5,17 ): ['신사임당 기일'],
      DateTime(2023, 6,4 ): ['광해군 생일'],
      DateTime(2023, 8,7 ): ['광해군 기일'],
      DateTime(2023, 7,3 ): ['효종 생일'],
      DateTime(2023, 6,23 ): ['효종 기일'],
      DateTime(2023, 8,19 ): ['성종 생일'],
      DateTime(2023, 1,19 ): ['성종 기일'],
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

            if(_selectedDay != null)
              Padding(padding: const EdgeInsets.all(8.0),
                child: Text(
                  '▶ ${_focusedDay.month}월의 이벤트',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
            if (_calendarFormat == CalendarFormat.month)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _sortedEventDates.map((date) {
                    return Text(
                      ' ▾ ${date.year}-${date.month}-${date.day}: ${_events[date]!.join(", ")}',
                      style: TextStyle(fontSize: 18),
                    );
                  }).toList(),
                ),
              ),
            SizedBox(height: 16),
            if(_selectedDay != null)
              Padding(padding: const EdgeInsets.all(8.0),
              child: Text(
                '▶ ${_selectedDay?.year}-${_selectedDay?.month}-${_selectedDay?.day}일 이벤트',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              ),
            if (_selectedDay != null)
              Padding(
                padding: const EdgeInsets.all(8.0),

                child: Text(
                  ' ▾ ${_eventDetails}',
                  style: TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
