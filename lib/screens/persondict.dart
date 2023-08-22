import 'package:chosungood/screens/person.dart';
import 'package:chosungood/screens/person_details.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<Person> people = [];
  bool _isLoading = true; // Add this line

  Future<void> fetchPeopleFromDatabase() async {
    final response = await http.get(Uri.parse('http://18.188.95.144/person_data_return.php')); // Replace with your API endpoint
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Person> fetchedPeople = [];

      for (var personData in jsonData) {
        final person = Person(
          name: personData['name'] ?? '',
          mbti: personData['mbti'] ?? '',
          birth_Date: personData['birth_date'] ?? '', // Already a String
          death_Date: personData['death_date'] ?? '', // Already a String
          era: personData['era'] ?? '',
          description: personData['description'] ?? '',
        );
        fetchedPeople.add(person);
      }


      setState(() {
        people = fetchedPeople;
        _isLoading = false; // Set _isLoading to false when data is fetched
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
        title: Text('Home Page'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(), // Show loading indicator while fetching data
      )
        : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 2개의 아이템을 가로로 나열
          mainAxisSpacing: 15, // 아이템들의 수직 간격
          crossAxisSpacing: 15, // 아이템들의 수평 간격
        ),
        padding: EdgeInsets.all(15), // Add padding around the GridView
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PersonDetailsPage(person: person),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/creeper.png',
                    width: 80, // Set the desired width
                    height: 80, // Set the desired height
                  ),
                  SizedBox(height: 1),
                  Text(
                    person.name ?? '',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          );
        },
      )


    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashBoard(),
  ));
}
