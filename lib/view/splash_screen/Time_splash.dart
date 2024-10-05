import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/widgets/CustomWidgets.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../Creating Profile/profile for name.dart';

class Timesplash extends StatefulWidget {
  const Timesplash({super.key});

  @override
  State<Timesplash> createState() => _TimesplashState();
}

class _TimesplashState extends State<Timesplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      Dronewidgets.mainButton(title: 'Start',textColor: AppColors.primaryColor2,
          onPressed: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileName(),));
          },backgroundColor: Colors.white),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SafeArea(
        child: Stack(
          children: [
            // Background Container with the circular element
            Container(
              width: double.infinity,
              height: double.infinity,
              color: AppColors.primaryColor, // Background teal color
              child: Stack(
                children: [
                  // Top left circular design
                  Positioned(
                    top: -100, // Adjust the position as needed
                    left: -100, // Adjust the position as needed
                    child: Container(
                      width: 300,
                      height: 300,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor2, // Darker shade of teal
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  // Main content
                  Align(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Stack for medicine images (replace with your own assets)
                        Stack(
                          alignment: Alignment.center,
                          children: [
                            Image.asset(
                              'assets/images/clock.png', // Replace with your image
                              height: 250,
                              width: 250,
                            ),
                          ],
                        ),

                        // Dotted separator
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 80,
                              height: 11,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            SizedBox(width: 5),
                            CircleAvatar(radius: 5, backgroundColor: Colors.white),
                            SizedBox(width: 5),
                            CircleAvatar(radius: 5, backgroundColor: Colors.white),
                          ],
                        ),
                        SizedBox(height: 10),
                        // Text "Keep Track"
                        Text(
                          'Set Reminders',
                          style: text60045,
                        ),
                        // Text "Of All Medications You Take"
                        Text(
                          'so you wont forget to take pills',
                          style: text40023,
                        ),


                      ],
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
