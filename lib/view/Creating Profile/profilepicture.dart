import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import '../../app_colors.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import 'ProfileConditions.dart';

class AddingProfilePicture extends StatefulWidget {
  final String name;
  final String gender;
  final String dateOfBirth;
  final String healthCondition;
  final String height;
  final String weight;
  final String profileImage;

  const AddingProfilePicture({
    Key? key,
    required this.name,
    required this.gender,
    required this.dateOfBirth,
    required this.healthCondition,
    required this.height,
    required this.weight,
    required this.profileImage,
  }) : super(key: key);

  @override
  State<AddingProfilePicture> createState() => _AddingProfilePictureState();
}

class _AddingProfilePictureState extends State<AddingProfilePicture> {
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Method to download profile image from URL
  Future<File?> _downloadFile(String url) async {
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final documentDirectory = await getApplicationDocumentsDirectory();
        final filePath = '${documentDirectory.path}/profile_image.png';
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        return file;
      }
    } catch (e) {
      print('Error downloading profile image: $e');
    }
    return null;
  }

  Future<void> _pickImage() async {
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          _profileImage = File(pickedFile.path);
        });
        print('hey:${_profileImage}');
        print('Picked image path: ${pickedFile.path}'); // Debug print to confirm path
      } else {
        print('No image selected.');
      }
    } catch (e) {
      print('Error picking image: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    print("Name: ${widget.name}");
    print("Gender: ${widget.gender}");
    print("Date of Birth: ${widget.dateOfBirth}");
    print("Health Condition: ${widget.healthCondition}");
    print("Height: ${widget.height}");
    print("Weight: ${widget.weight}");
    print("Image: ${widget.profileImage}");
    print("Image path for display: ${_profileImage?.path ?? 'No image selected'}"); // Debug print

    return Scaffold(
      appBar: AppBar(
        actions: [
          ElevatedButton(
            onPressed: () async {
              SharedPreferences preferences = await SharedPreferences.getInstance();
              String? userId = preferences.getString('userID');

              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  ProfileCondition(
                    name: widget.name,
                    gender: widget.gender,
                    dateOfBirth: widget.dateOfBirth,
                    healthCondition: widget.healthCondition,
                    height: widget.height,
                    weight: widget.weight,
                    userId: int.parse(userId.toString()),
                    profileImage: widget.profileImage,
                  )));

              print('profile pic userId $userId');
            },
            child: Text('Skip', style: text40018primary),
          ),
          SizedBox(width: 10),
        ],
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dronewidgets.mainButton(
          title: 'Next',
          onPressed: () async {
            SharedPreferences preferences = await SharedPreferences.getInstance();
            String? userId = preferences.getString('userID');

            File? finalImage;
            // Use picked image or download from URL
            if (_profileImage != null) {
              finalImage = _profileImage;
            } else if (widget.profileImage.isNotEmpty) {
              finalImage = await _downloadFile(widget.profileImage);
            }

            Navigator.push(context, MaterialPageRoute(builder: (context) =>
                ProfileCondition(
                  profileImage: _profileImage?.path ?? widget.profileImage,  // Pass actual image path
                  name: widget.name,
                  gender: widget.gender,
                  dateOfBirth: widget.dateOfBirth,
                  healthCondition: widget.healthCondition,
                  height: widget.height,
                  weight: widget.weight,
                  userId: int.parse(userId ?? '0'),
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
