import 'package:flutter/material.dart';
import 'package:med_one/constants.dart';

import '../../../app_colors.dart';
import '../../../widgets/CustomWidgets.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 250, // Set a specific height for the Stack
              child: Stack(
                children: [
                  Positioned(
                    left: 16,
                    top: 40,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      onPressed: () {
                        // Go back
                        Navigator.pop(context); // Use this to navigate back
                      },
                      color: Colors.blue,
                    ),
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

                            ),
                            Positioned(
                              bottom: 0,
                              right: 4,
                              child: CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 15,
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 18,
                                  color: Colors.grey,
                                ),
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
                  Text(
                    "Basic details",
                    style:text40016black

                  ),
                  SizedBox(height: 16),
                  Text("Full name",style: text40014bordercolor,),
                  SizedBox(height: 11),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 11),
                  Text("Date of birth",style: text40014bordercolor,),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Gender",
                    style: text40014bordercolor,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                                border: Border.all()
                            ),
                            child: ListTile(
                              title: const Text('Male'),
                              leading: Radio(
                                value: 'Male',
                                groupValue: 'gender', // Change based on state
                                onChanged: (value) {
                                  // Handle change
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)),
                              border: Border.all()
                            ),
                            child: ListTile(
                              title: const Text('Female'),
                              leading: Radio(
                                value: 'Female',
                                groupValue: 'gender',
                                onChanged: (value) {
                                  // Handle change
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Contact details",
                    style:text40016black
                  ),
                  SizedBox(height: 16),
                  Text("Mobile number",style: text40014bordercolor,),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                  "Email",style: text40014bordercolor,),
                  SizedBox(height: 11),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 16),

                  Text(
                    "Contact details",
                    style: text40016black
                  ),
                  Text(
                    "Height (Cm)",style: text40014bordercolor,

                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Weight (kg)",
                    style: text40014bordercolor,

                  ),
                  SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 59,
                    width: 150,
                    child: Dronewidgets.mainButton(
                      title: 'Cancel',
                      onPressed: () {
                        print('dde');
                       Dronewidgets.medicationOptions(context);
                      },
                      backgroundColor: AppColors.primaryColor3,
                    ),
                  ),
                  Container(
                    height: 59,
                    width: 150,
                    child: Dronewidgets.mainButton(
                      title: 'Save',
                      onPressed: () {
                      },
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
}
