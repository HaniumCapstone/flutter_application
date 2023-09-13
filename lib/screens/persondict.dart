import 'package:flutter/material.dart';
import 'person.dart';
import 'person_details.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
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
        title: Text('인물사전'),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 15,
          crossAxisSpacing: 15,
        ),
        padding: EdgeInsets.all(15),
        itemCount: people.length,
        itemBuilder: (context, index) {
          final person = people[index];
          final personImageFileName = personImageFileNames[index % personImageFileNames.length];
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
                    'assets/per_images/${personImageFileNames[index % personImageFileNames.length]}',
                    width: 80,
                    height: 80,
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
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: DashBoard(),
  ));
}
