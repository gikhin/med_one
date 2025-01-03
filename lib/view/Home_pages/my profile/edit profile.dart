import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:med_one/constants.dart';
import 'package:med_one/res/appurl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../app_colors.dart';
import '../../../widgets/CustomWidgets.dart';
import 'package:http/http.dart' as http;

import '../../bottomnavigation.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String? _selectedGender = "Male"; // Initial gender
  bool _isEditing = false; // Controls whether fields are editable

  // Text editing controllers with fake details
  TextEditingController _nameController = TextEditingController();
  TextEditingController _dobController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();
  String? _profileImageUrl; // Holds the image URL or base64 string



  Future<void> _fetchUserProfile() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString('userID');
      final response = await http.post(
        Uri.parse(AppUrl.fetchProfile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"userId": int.parse(userId.toString())}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          setState(() {
            _nameController.text = responseData['data']['name'];
            _dobController.text = responseData['data']['ageGroup'];
            _heightController.text = responseData['data']['height'];
            _weightController.text = responseData['data']['weight'];
            _selectedGender = responseData['data']['gender'];
            // Assuming 'image' contains the URL or base64 string
            String? profileImageUrl = responseData['data']['image'];
            _profileImageUrl = profileImageUrl;  // Save the image URL or base64
          });
        } else {
          print('Failed to load user data');
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  // Function to update user profile
  Future<void> _updateUserProfile() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userId = preferences.getString('userID');

      final response = await http.post(
        Uri.parse(AppUrl.editProfile),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "userId": int.parse(userId.toString()),
          "name": _nameController.text,
          "dob": _dobController.text,
          "gender": _selectedGender,
          "health_condition": [{"healthCondition": "hyper tension"}], // Add health conditions as required
          "height": _heightController.text,
          "weight": _weightController.text
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        if (responseData['success']) {
          Flushbar(
            message: 'Profile updated successfully',
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
          ).show(context);

          print('Profile updated successfully');
          setState(() {
            _isEditing = false;
          });
        } else {
          print('Failed to update profile');
        }
      }
    } catch (error) {
      print('Error: $error');
    }
  }


  @override
  void initState() {
    super.initState();
    _fetchUserProfile();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250,
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 40,
                    child: Dronewidgets.backButton(context),
                  ),
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundImage: _profileImageUrl != null && _profileImageUrl!.isNotEmpty
                                  ? NetworkImage(_profileImageUrl!)  // Load image from URL if available
                                  : null, // No image, fallback to icon
                              child: _profileImageUrl == null || _profileImageUrl!.isEmpty
                                  ? Icon(Icons.person, size: 50)  // Fallback icon
                                  : null,  // No child if image is present
                            ),


                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Icon(Icons.camera_alt, size: 18, color: Colors.grey),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Basic details", style: text40016black),
                      IconButton(
                        icon: Icon(_isEditing ? Icons.edit : Icons.edit, color: Colors.black),
                        onPressed: () {
                          setState(() {
                            _isEditing = !_isEditing;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  _buildEditableRow(label: "Full name", controller: _nameController, isEditing: _isEditing),
                  SizedBox(height: 11),
                  // _buildEditableRow(label: "Date of birth", controller: _dobController, isEditing: _isEditing),
                  _buildEditableRow(
                    label: "Date of birth",
                    controller: _dobController,
                    isEditing: _isEditing,
                    isDateField: true,
                  ),
                  SizedBox(height: 16),
                  Text("Gender", style: text40014bordercolor),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(),
                          ),
                          child: ListTile(
                            title: const Text('Male'),
                            leading: Radio<String>(
                              value: 'Male',
                              groupValue: _selectedGender,
                              onChanged: _isEditing ? (String? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              } : null,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 2),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            border: Border.all(),
                          ),
                          child: ListTile(
                            title: const Text('Female'),
                            leading: Radio<String>(
                              value: 'Female',
                              groupValue: _selectedGender,
                              onChanged: _isEditing ? (String? value) {
                                setState(() {
                                  _selectedGender = value;
                                });
                              } : null,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text("Contact details", style: text40016black),
                  SizedBox(height: 16),
                  _buildEditableRow(label: "Height (Cm)", controller: _heightController, isEditing: _isEditing),
                  SizedBox(height: 16),
                  _buildEditableRow(label: "Weight (kg)", controller: _weightController, isEditing: _isEditing),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: text40018black),
                  ),
                  Container(
                    height: 59,
                    width: 150,
                    child: Dronewidgets.mainButton(
                      title: 'Save',
                      onPressed: _updateUserProfile


                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create an editable text field

  // Widget _buildEditableRow({
  //   required String label,
  //   required TextEditingController controller,
  //   required bool isEditing,
  // }) {
  //   return Column(
  //     crossAxisAlignment: CrossAxisAlignment.start,
  //     children: [
  //       Text(label, style: text40014bordercolor),
  //       SizedBox(height: 11),
  //       TextField(
  //         controller: controller,
  //         enabled: isEditing,
  //         decoration: InputDecoration(
  //           border: OutlineInputBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(20)),
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget _buildEditableRow({
    required String label,
    required TextEditingController controller,
    required bool isEditing,
    bool isDateField = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: text40014bordercolor),
        SizedBox(height: 11),
        GestureDetector(
          onTap: isDateField && isEditing ? () => _selectDate(context) : null,
          child: AbsorbPointer(
            absorbing: isDateField,
            child: TextField(
              controller: controller,
              enabled: !isDateField ? isEditing : false,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                suffixIcon: isDateField
                    ? Icon(Icons.calendar_today, color: Colors.grey)
                    : null,
              ),
            ),
          ),
        ),
      ],
    );
  }
  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobController.text = DateFormat('MM/dd/yyyy').format(pickedDate);
      });
    }
  }
}
