import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import for date formatting
import 'package:med_one/app_colors.dart';
import 'package:med_one/view/Creating%20Profile/profilepicture.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import 'ProfileConditions.dart';

class CalendarProfile extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth; // Added
  final String healthCondition; // Added
  final String height; // Added
  final String weight; // Added

  CalendarProfile({
    required this.name,
    required this.gender,
    required this.dateOfBirth, // Added
    required this.healthCondition, // Added
    required this.height, // Added
    required this.weight, // Added
  });

  @override
  _CalendarProfileState createState() => _CalendarProfileState();
}

class _CalendarProfileState extends State<CalendarProfile> {
  DateTime selectedDate = DateTime.now();
  int age = 0;
  String previousDateOfBirth = ""; // To track the previous date of birth

  @override
  void initState() {
    super.initState();
    // Parse dateOfBirth and set selectedDate if it's not empty
    if (widget.dateOfBirth.isNotEmpty) {
      // Use DateFormat to parse the date from the string
      DateFormat dateFormat = DateFormat('dd/MM/yyyy'); // Adjust to match your input format
      selectedDate = dateFormat.parse(widget.dateOfBirth);
      previousDateOfBirth = widget.dateOfBirth; // Store the original date of birth
      age = calculateAge(selectedDate);
    }
  }

  int calculateAge(DateTime birthDate) {
    DateTime currentDate = DateTime.now();
    int calculatedAge = currentDate.year - birthDate.year;
    if (currentDate.month < birthDate.month ||
        (currentDate.month == birthDate.month && currentDate.day < birthDate.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        age = calculateAge(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Dronewidgets.mainButton(
        title: 'Next',
        onPressed: () {
          String newDateOfBirth = DateFormat('dd/MM/yyyy').format(selectedDate); // Change the format to dd/MM/yyyy

          // Check if the date of birth has changed
          String dateOfBirthToPass = (newDateOfBirth != previousDateOfBirth) ? newDateOfBirth : widget.dateOfBirth;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddingProfilePicture(
                name: widget.name,
                gender: widget.gender,
                dateOfBirth: dateOfBirthToPass, // Pass the new or old date of birth
                healthCondition: widget.healthCondition, // Pass health condition
                height: widget.height, // Pass height
                weight: widget.weight, // Pass weight
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: Dronewidgets.backButton(context),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'Your ',
                  style: text50026black,
                  children: <TextSpan>[
                    TextSpan(
                      text: 'date of birth',
                      style: text50026primary,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor2,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: Text(
                    '$age', // Display the calculated age
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd/MM/yyyy').format(selectedDate), // Use dd/MM/yyyy format for displayed date
                        style: TextStyle(fontSize: 18),
                      ),
                      Icon(Icons.calendar_today, color: Colors.black),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
