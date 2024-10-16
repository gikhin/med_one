import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:med_one/constants.dart';
import '../../app_colors.dart';
import '../../widgets/CustomWidgets.dart';
import 'ProfileConditions.dart';
import 'daily_routine.dart';

class AddingProfilePicture extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth; // Added
  final String healthCondition; // Added
  final String height; // Added
  final String weight; // Added

  const AddingProfilePicture({
    Key? key,
    required this.name,
    required this.gender,
    required this.dateOfBirth, // Added
    required this.healthCondition, // Added
    required this.height, // Added
    required this.weight, // Added
  }) : super(key: key);

  @override
  State<AddingProfilePicture> createState() => _AddingProfilePictureState();
}

class _AddingProfilePictureState extends State<AddingProfilePicture> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
      }
    } catch (e) {
      // Handle any errors that may occur during image picking
      print('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Name: ${widget.name}");
    print("Gender: ${widget.gender}");
    print("Date of Birth: ${widget.dateOfBirth}"); // Displaying the new field
    print("Health Condition: ${widget.healthCondition}"); // Displaying the new field
    print("Height: ${widget.height}"); // Displaying the new field
    print("Weight: ${widget.weight}"); // Displaying the new field

    return Scaffold(
      appBar: AppBar(
        actions: [
          // ElevatedButton(onPressed: () {
          //   // Handle skip action
          // }, child: Text('Skip', style: text40018primary)),
          // SizedBox(width: 10),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dronewidgets.mainButton(
          title: 'Next',
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ProfileCondition(
                  name: widget.name,
                  gender: widget.gender,
                  dateOfBirth: widget.dateOfBirth,
                  healthCondition: widget.healthCondition, // Pass the new field
                  height: widget.height, // Pass the new field
                  weight: widget.weight, userId: 45, // Pass the new field
                )));
          },
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    CircleAvatar(
                      radius: 90,
                      backgroundColor: Colors.grey[300],
                      backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                      child: _profileImage == null
                          ? Icon(Icons.person, size: 120, color: Colors.white)
                          : null,
                    ),
                    Positioned(
                      bottom: 10,
                      child: GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          child: Icon(Icons.camera_alt, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Text(
                  'Add Image',
                  style: TextStyle(
                    fontSize: 18,
                    color: AppColors.primaryColor2,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
