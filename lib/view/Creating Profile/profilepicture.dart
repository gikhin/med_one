import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../app_colors.dart';
import '../../widgets/CustomWidgets.dart';
import 'daily_routine.dart';

class AddingProfilePicture extends StatefulWidget {
  final String name;
  final String gender;
  final DateTime selectedDate;
  final String height;
  final String weight;
  final String details; // New field for details

  const AddingProfilePicture({
    Key? key,
    required this.name,
    required this.gender,
    required this.selectedDate,
    required this.height,
    required this.weight,
    required this.details, // Add details parameter
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
    print("Selected Date: ${widget.selectedDate.toLocal()}");
    print("Height: ${widget.height}");
    print("Weight: ${widget.weight}");
    print("Details: ${widget.details}"); // Print details

    return Scaffold(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => DailyRoutine(),));
              },
            ),
          ),
          Container(
            height: 61,
            width: 161,
            child: Dronewidgets.mainButton(
              title: 'Skip',
              onPressed: () {
                // Handle skip action
              },
              backgroundColor: AppColors.primaryColor3,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Colors.white,
      body: SafeArea(
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
    );
  }
}
