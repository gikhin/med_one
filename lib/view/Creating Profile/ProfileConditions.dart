import 'package:flutter/material.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import 'profilepicture.dart';

class ProfileCondition extends StatefulWidget {
  final String name;
  final String gender;
  final DateTime selectedDate;

  ProfileCondition({
    required this.name,
    required this.gender,
    required this.selectedDate,
  });

  @override
  _ProfileConditionState createState() => _ProfileConditionState();
}

class _ProfileConditionState extends State<ProfileCondition> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController(); // Added controller
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 61,
            width: 161,
            child: Dronewidgets.mainButton(
              title: 'Next',
              onPressed: () {
                if (_formKey.currentState?.validate() == true) {
                  // Navigate to AddingProfilePicture with the new details parameter
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddingProfilePicture(
                        name: widget.name,
                        gender: widget.gender,
                        selectedDate: widget.selectedDate,
                        height: _heightController.text,
                        weight: _weightController.text,
                        details: _detailsController.text, // Pass the details
                      ),
                    ),
                  );
                }
              },
            ),
          ),
          Container(
            height: 61,
            width: 161,
            child: Dronewidgets.mainButton(
              title: 'Skip',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddingProfilePicture(
                      name: widget.name,
                      gender: widget.gender,
                      selectedDate: widget.selectedDate,
                      height: '',
                      weight: '',
                      details: '', // Skip value for details
                    ),
                  ),
                );
              },
              backgroundColor: AppColors.primaryColor3,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text("Hello, ${widget.name}", style: text50026primary),
                  SizedBox(height: 8),
                  Text("Let's create your profile together", style: text50026primary),
                  Text("Do you have any chronic health conditions?", style: text50030),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _detailsController, // Use the new controller
                      decoration: const InputDecoration(hintText: 'Enter your details here'),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _heightController,
                      decoration: const InputDecoration(hintText: 'cm/feet', labelText: 'Enter your height'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your height';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _weightController,
                      decoration: const InputDecoration(hintText: 'kg', labelText: 'Enter your weight'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
