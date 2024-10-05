import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import 'calender.dart'; // Import CalendarProfile

class ProfileName extends StatefulWidget {
  const ProfileName({Key? key}) : super(key: key);

  @override
  State<ProfileName> createState() => _ProfileNameState();
}

class _ProfileNameState extends State<ProfileName> {
  final TextEditingController _nameController = TextEditingController();
  String? _selectedGender;

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
      floatingActionButton: Dronewidgets.mainButton(
        title: 'Next',
        onPressed: () {
          if (_validateInput()) {
            // Pass name and gender to the next page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CalendarProfile(
                  name: _nameController.text,
                  gender: _selectedGender!,
                ),
              ),
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Hello", style: text50026primary),
                const SizedBox(height: 8),
                Text("Let's create your profile", style: text50026primary),
                Text("together", style: text50026primary),
                const SizedBox(height: 8),
                Text('Your name please', style: text50030),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(hintText: 'Enter your name here'),
                  ),
                ),
                const SizedBox(height: 10),
                Text('Please select your', style: text50030),
                Text('gender', style: text50030),
                const SizedBox(height: 10),
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
    return Container(
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
            ),
          Text(gender, style: text40018),
        ],
      ),
    );
  }

  Widget _preferNotToDiscloseContainer() {
    bool isSelected = _selectedGender == 'Prefer not to disclose';
    return Container(
      width: 364,
      height: 95,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor2 : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          'Prefer not to disclose',
          style: text40018,
        ),
      ),
    );
  }
}
