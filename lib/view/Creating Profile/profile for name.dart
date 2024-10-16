import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import 'calender.dart'; // Import CalendarProfile

class ProfileName extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String healthCondition;
  final String height;
  final String weight;

  // Constructor to receive user data
  const ProfileName({
    Key? key,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.healthCondition,
    required this.height,
    required this.weight,
  }) : super(key: key);

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    // Initialize the controller and selected gender with existing data
    _nameController.text = widget.name;
    _selectedGender = widget.gender;
  }

  void _selectGender(String gender) {
    setState(() {
      _selectedGender = gender;
    });
  }

  // Validation function
  bool _validateInput() {
    if (_nameController.text.isEmpty) {
      _showFlushbar("Please enter your name");
      return false;
    }
    if (_selectedGender == null) {
      _showFlushbar("Please select your gender");
      return false;
    }
    return true;
  }

  // Function to display Flushbar
  void _showFlushbar(String message) {
    Flushbar(
      message: message,
      duration: const Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.red,
      icon: const Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
    ).show(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dronewidgets.mainButton(
          title: 'Next',
          onPressed: () {
            if (_validateInput()) {
              // Pass name and gender to the next page, using new values if changed
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CalendarProfile(
                    name: _nameController.text,
                    gender: _selectedGender!,
                    dateOfBirth: widget.dateOfBirth, // Pass the existing date of birth
                    healthCondition: widget.healthCondition, // Pass the existing health condition
                    height: widget.height, // Pass the existing height
                    weight: widget.weight, // Pass the existing weight
                  ),
                ),
              );
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        // leading: Dronewidgets.backButton(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello", style: text50026black),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Text("Let's ", style: text50026black),
                    Text("create your profile", style: text50026primary),
                  ],
                ),
                Text("Together", style: text50026black),
                const SizedBox(height: 8),
                Text('Your name please', style: text50030),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    style: TextStyle(fontSize: 18),
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your name here',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('What is your', style: text50026black),
                    Text(' gender', style: text50026primary),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () => _selectGender('Male'),
                      child: _genderContainer('Male', 'assets/images/man.png'),
                    ),
                    GestureDetector(
                      onTap: () => _selectGender('Female'),
                      child: _genderContainer('Female', 'assets/images/woman.png'),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => _selectGender('Prefer not to disclose'),
                  child: _preferNotToDiscloseContainer(),
                ),
                const SizedBox(height: 132),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _genderContainer(String gender, String? imagePath) {
    bool isSelected = _selectedGender == gender;
    return Center(
      child: Container(
        width: 164,
        height: 154,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor2 : Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Image.asset(
                imagePath,
                height: 100,
                width: 100,
                errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 100), // Error handling
              ),
            Text(
              gender,
              style: isSelected ? text40018black : text40018primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _preferNotToDiscloseContainer() {
    bool isSelected = _selectedGender == 'Prefer not to disclose';
    return Center(
      child: Container(
        width: 364,
        height: 95,
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor2 : Colors.grey[300],
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Center(
          child: Text(
            'Prefer not to disclose',
            style: isSelected ? text40018black : text40018primary,
          ),
        ),
      ),
    );
  }
}
