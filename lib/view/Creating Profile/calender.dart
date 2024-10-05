import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import '../../constants.dart';
import 'ProfileConditions.dart';

class CalendarProfile extends StatefulWidget {
  final String name;
  final String gender;

  // Constructor to accept name and gender from previous page
  CalendarProfile({required this.name, required this.gender});

  @override
  _CalendarProfileState createState() => _CalendarProfileState();
}

class _CalendarProfileState extends State<CalendarProfile> {
  int selectedDay = 30;
  int selectedMonth = 10;
  int selectedYear = 2024;

  final List<int> days = List.generate(31, (index) => index + 1); // Days 1-31
  final List<int> months = List.generate(12, (index) => index + 1); // Months 1-12
  final List<int> years = List.generate(100, (index) => 2024 - index); // Years 2024 and earlier

  @override
  void initState() {
    super.initState();
    // Print name and gender in the console
    print("Name: ${widget.name}");
    print("Gender: ${widget.gender}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
      ),
      floatingActionButton: Dronewidgets.mainButton(
        title: 'Next',
        onPressed: () {
          // Navigate to ProfileCondition and pass selected date
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileCondition(
                name: widget.name,
                gender: widget.gender,
                selectedDate: DateTime(selectedYear, selectedMonth, selectedDay),
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30),
              Text(
                "Hello, ${widget.name}",
                style: text50026primary,
              ),
              SizedBox(height: 8),
              Text(
                "Let's create your profile together",
                style: text50026primary,
              ),
              SizedBox(height: 32),
              Text(
                "When is your birthday?",
                style: text50030,
              ),
              SizedBox(height: 32),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios_new, color: Colors.deepPurple),
                    onPressed: () {
                      // Handle back arrow functionality here
                    },
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: days.indexOf(selectedDay)),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedDay = days[index];
                        });
                      },
                      children: days
                          .map((day) => Center(
                        child: Text(
                          day.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: months.indexOf(selectedMonth)),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedMonth = months[index];
                        });
                      },
                      children: months
                          .map((month) => Center(
                        child: Text(
                          month.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  Expanded(
                    child: CupertinoPicker(
                      scrollController: FixedExtentScrollController(
                          initialItem: years.indexOf(selectedYear)),
                      itemExtent: 40,
                      onSelectedItemChanged: (int index) {
                        setState(() {
                          selectedYear = years[index];
                        });
                      },
                      children: years
                          .map((year) => Center(
                        child: Text(
                          year.toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                      ))
                          .toList(),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                    onPressed: () {
                      // Handle forward arrow functionality here
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
