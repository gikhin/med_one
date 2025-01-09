import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/widgets/CustomWidgets.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../Creating Profile/Adding medcine one.dart';
import '../Creating Profile/Pastorder.dart';
import '../Creating Profile/daily_routine.dart';
import '../Creating Profile/profile for name.dart';

class Timesplash extends StatefulWidget {
  final String name;
  final String gender;
  // final String dateOfBirth;
  final String healthCondition;
  final String height;
  final String weight;
  final String profileImage;

  // Constructor to receive user data
  const Timesplash({
    Key? key,
    required this.name,
    required this.gender,
    // required this.dateOfBirth,
    required this.healthCondition,
    required this.height,
    required this.weight,
    required this.profileImage,
  }) : super(key: key);

  @override
  State<Timesplash> createState() => _TimesplashState();
}


class _TimesplashState extends State<Timesplash> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
      Padding(
        padding: const EdgeInsets.only(right: 15.0,left: 15.0),
        child: Dronewidgets.mainButton(title: 'Start',textColor: AppColors.primaryColor2,
            onPressed: (){
              _showMedicationOptionsDialog(context);
          // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileName(
          //   name: widget.name,
          //   gender: widget.gender,
          //   // dateOfBirth: widget.dateOfBirth,
          //   healthCondition: widget.healthCondition
          //   , height: widget.height, weight: widget.weight,
          //   profileImage: widget.profileImage,
          // ),));
            },backgroundColor: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Stack(
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
                            height: 299,
                            width: 299,
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),

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
    );
  }
  void _showMedicationOptionsDialog(BuildContext context) {
    bool _backPressedOnce = false;

    showDialog(
      context: context,
      barrierDismissible: false, // Prevents closing when tapping outside the dialog
      builder: (BuildContext context) => WillPopScope(
        onWillPop: () async {
          if (_backPressedOnce) {
            // If back is pressed again, close the dialog
            return true;
          } else {
            // Show "Press back again to exit" message
            _backPressedOnce = true;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Press back again to exit'),
                duration: Duration(seconds: 2),
              ),
            );
            Future.delayed(Duration(seconds: 2), () {
              _backPressedOnce = false; // Reset after 2 seconds
            });
            return false; // Prevent dialog from closing on the first back press
          }
        },
        child: AlertDialog(
          backgroundColor: AppColors.containercolor,
          content: medicationOptionsContainer(context),
        ),
      ),
    );
  }



  // Your medicationOptionsContainer function
  static Widget medicationOptionsContainer(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you have any past orders or need to add it manually?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // "Past order" button
          Dronewidgets.mainButton(title: 'Past order', onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => MedicineListPastorder(),));



          }
          ),
          SizedBox(height: 12),
          // "Add Medication" button
          Dronewidgets.mainButton(title: 'Add Medication', onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));
            Navigator.push(context, MaterialPageRoute(builder: (context) => DailyRoutine(),));

          })

        ],
      ),
    );
  }
}
