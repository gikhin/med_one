import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required for TextInputFormatter
import 'package:http/http.dart' as http; // Required for making API requests
import 'package:lottie/lottie.dart';
import 'package:med_one/view/Creating%20Profile/profilepicture.dart';
import 'dart:convert'; // Required for JSON encoding

import '../../constants.dart';
import '../../res/appurl.dart';
import '../../widgets/CustomWidgets.dart';
import 'daily_routine.dart';

class ProfileCondition extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth; // Added
  final String healthCondition; // Added
  final String height; // Added
  final String weight; // Added
  final int userId; // Added userId to identify the user

  const ProfileCondition({
    Key? key,
    required this.name,
    required this.gender,
    required this.dateOfBirth, // Added
    required this.healthCondition, // Added
    required this.height, // Added
    required this.weight, // Added
    required this.userId, // Added userId to identify the user
  }) : super(key: key);

  @override
  _ProfileConditionState createState() => _ProfileConditionState();
}

class _ProfileConditionState extends State<ProfileCondition> {
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // List of height units
  List<String> _heightUnits = ['cm', 'inch'];
  String? _selectedUnit = 'cm'; // Default unit selection

  @override
  void initState() {
    super.initState();
    // Initialize text controllers with existing data
    _heightController.text = widget.height;
    _weightController.text = widget.weight;
    _detailsController.text = widget.healthCondition;
  }

  // Future<void> _submitData() async {
  //   // Prepare the data for submission
  //   String newHeight = _heightController.text.trim();
  //   String newWeight = _weightController.text.trim();
  //   String newHealthCondition = _detailsController.text.trim();
  //
  //   // Create the API body
  //   Map<String, dynamic> requestBody = {
  //     "name": widget.name,
  //     "gender": widget.gender,
  //     "dob": widget.dateOfBirth,
  //     "health_condition": newHealthCondition,
  //     "height": newHeight,
  //     "weight": newWeight,
  //     "userid": widget.userId,
  //   };
  //
  //   try {
  //     // Send the API request
  //     final response = await http.post(
  //       Uri.parse(AppUrl.addingDetails),
  //       headers: {
  //         'Content-Type': 'application/json',
  //       },
  //       body: json.encode(requestBody),
  //     );
  //
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //
  //     if (response.statusCode == 200) {
  //       print('API call successful, showing success dialog');
  //       if (mounted) {
  //         _showSuccessDialog(); // Show success dialog if mounted
  //       }
  //     } else {
  //       print('API call failed with status code: ${response.statusCode}');
  //       _showErrorDialog('Failed to update data. Please try again.');
  //     }
  //   } catch (e) {
  //     print('Error occurred: $e');
  //     _showErrorDialog('An error occurred. Please check your network and try again.');
  //   }
  // }



  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        // Navigate to the next page after 3 seconds
        Future.delayed(Duration(seconds: 3), () {
          if (mounted) {
            Navigator.pop(context); // Close the dialog
            _navigateToNextPage();
          }
        });

        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/profiledone1.json', // Path to your Lottie animation file
                height: 183,
                width: 189,
              ),
              Text('Your profile has been created.', style: TextStyle(fontSize: 16)),
            ],
          ),
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToNextPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => DailyRoutine(),
      ),
    );
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
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Dronewidgets.mainButton(
          title: 'Finished',
          onPressed: () {
            // Validate form before submission
            if (_formKey.currentState!.validate()) {
              // _submitData(); // Call the submit function
              _showSuccessDialog();
            }
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Text("Hello, ${widget.name}", style: text50026black),
                  SizedBox(height: 8),
                  Text("Do you have any", style: text50030black),
                  Text("health conditions?", style: text50030),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _detailsController,
                      decoration: const InputDecoration(hintText: 'Enter your details here'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter health condition details';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _heightController,
                      decoration: InputDecoration(
                        hintText: 'Enter your height',
                        labelText: 'Height',
                        suffix: DropdownButton<String>(
                          value: _selectedUnit,
                          items: _heightUnits.map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedUnit = newValue;
                            });
                          },
                          underline: SizedBox(), // Remove the default underline
                        ),
                      ),
                      keyboardType: TextInputType.number, // Allows only number input
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Restricts input to digits only
                      ],
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
                      decoration: InputDecoration(
                        hintText: 'Enter your weight',
                        labelText: 'Weight',
                        suffixText: 'Kg', // Display "Kg" as suffix text
                      ),
                      keyboardType: TextInputType.number, // Allows only number input
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly, // Restricts input to digits only
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your weight';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 80), // Added some spacing to avoid covering by the keyboard
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
