import 'package:flutter/material.dart';
import 'package:med_one/Utils.dart';
import 'package:med_one/app_colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import '../Login Page.dart';
import '../bottomnavigation.dart';
import 'keeptrack_splash.dart';

class MainSplashScreen extends StatefulWidget {
  const MainSplashScreen({Key? key}) : super(key: key);

  @override
  State<MainSplashScreen> createState() => _MainSplashScreenState();
}

class _MainSplashScreenState extends State<MainSplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer for 2 seconds before navigating to the login page
    Timer(Duration(seconds: 2), ()async {
      // Navigate to the login page
      SharedPreferences preferences = await SharedPreferences.getInstance();
      bool? checkroutine = preferences.getBool('routineData');
      String? userID = preferences.getString('userID');

      if(userID != null){
        if(checkroutine == true){
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => BottomNavigation(),
            ),
          );
        }
        else{
          Utils.flushBarErrorMessage('some work pending..', context);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
                (Route<dynamic> route) => false,
          );

          // Navigator.pushReplacement(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => MedicationTrackerScreen(
          //       name: name,
          //       gender: gender,
          //       // dateOfBirth: dateOfBirth,
          //       healthCondition: healthCondition,
          //       height: height,
          //       weight: weight,
          //     ),
          //   ),
          // );
        }
      }else{
        Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
      }


    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor2,
      body: Center(
        child: IconButton(
          onPressed: () {},
          icon: Image.asset('assets/icons/medoneicon.png', height: 100, width: 100),
        ),
      ),
    );
  }
}


