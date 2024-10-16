
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart'; // Import another_flushbar

import 'package:med_one/res/appurl.dart';
import 'package:med_one/view/splash_screen/keeptrack_splash.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // For decoding JSON responses
import '../Utils.dart';
import '../constants.dart';
import 'Home_pages/homepage.dart';
import 'bottomnavigation.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController moboruserid = TextEditingController();
  final FocusNode moboruseridNode = FocusNode();
  final TextEditingController password = TextEditingController();
  final FocusNode passwordNode = FocusNode();
  final FocusNode LoginBtn = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // Custom email/phone validation
  String? validateEmailOrPhone(String? value) {
    if (value == null  || value.isEmpty) {
      return 'Please enter your email or phone number';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value) && value.length != 10) {
      return 'Please enter a valid email or 10-digit phone number';
    }
    return null;
  }

  // Custom password validation
  String? validatePassword(String? value) {
    if (value == null  || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  // Show Flushbar for error messages
  void showErrorFlushbar(String message) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: Colors.redAccent,
      icon: Icon(
        Icons.error_outline,
        color: Colors.white,
      ),
    ).show(context);
  }

  // API call to login


  // Future<void> login() async {
  //   final url = Uri.parse(AppUrl.login); // Replace with Appurl.login
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'email': moboruserid.text.trim(),
  //         'password': password.text.trim(),
  //       }),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['success']) {
  //         // Extract user data from the response
  //         final userData = data['userData'];
  //         final String name = userData['name'];
  //         final String gender = userData['gender'];
  //         final String dateOfBirth = userData['ageGroup']; // Assuming this is the date of birth
  //         final String healthCondition = userData['health_condition'];
  //         final String height = userData['height'];
  //         final String weight = userData['weight'];
  //         final String routine = data['routine']; // Get the routine field
  //
  //         // Login successful, navigate to the appropriate screen
  //         Flushbar(
  //           message: 'Login successful',
  //           duration: Duration(seconds: 2),
  //           flushbarPosition: FlushbarPosition.TOP,
  //           backgroundColor: Colors.green,
  //         ).show(context);
  //
  //
  //   if (routine == "false") {
  //   // Navigate to HomeScreen if routine is true
  //   Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(
  //   builder: (context) => BottomNavigation(),
  //   ),
  //   );
  //   } else {
  //   // Navigate to MedicationTrackerScreen if routine is not true
  //   Navigator.pushReplacement(
  //   context,
  //   MaterialPageRoute(
  //   builder: (context) => MedicationTrackerScreen(
  //   name: name,
  //   gender: gender,
  //   dateOfBirth: dateOfBirth,
  //   healthCondition: healthCondition,
  //   height: height,
  //   weight: weight,
  //   ),
  //   ),
  //   );
  //   }
  //   } else {
  //   showErrorFlushbar(data['message']);
  //   }
  //   } else {
  //   showErrorFlushbar('Login failed. Please try again.');
  //   }
  //   } catch (e) {
  //   showErrorFlushbar('An error occurred. Please try again.');
  //   }
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Text('Welcome Back', style: text60027),
              Text('Enter your credentials to continue', style: text40018black),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text('Email / Phone number', style: text40012black),
                    ),
                    SizedBox(height: 10),
                    Dronewidgets.customTextFormField(
                        controller: moboruserid,
                        fieldFocus:moboruseridNode,
                        onFieldSubmitted: (v){
                          Utils.fieldFocusChange(context, moboruseridNode, passwordNode);
                        }
                    ),
                  ],
                ),
              ),
              SizedBox(height: 2),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text('Password', style: text40012black),
              ),
              SizedBox(height: 10),
              Dronewidgets.customTextFormField(
                controller: password,
                fieldFocus: passwordNode,
                obscureText: !_isPasswordVisible,
                onFieldSubmitted: (v){
                  Utils.fieldFocusChange(context, passwordNode, LoginBtn);
                },
                suffixIcon: IconButton(
                  icon: Icon(
                    _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPasswordVisible = !_isPasswordVisible;
                    });
                  },
                ),
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.end,


                  children: [
                  TextButton(
                  onPressed: () {},
              child: Text('Forgot Password?', style: text40012black),
            ),
            ],
          ),
          ],
        ),
      ),
      Dronewidgets.mainButton(
        fieldFocus: LoginBtn,
        title: 'Sign In',
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MedicationTrackerScreen(
                name: '',
                gender: '',
                dateOfBirth: '',
                healthCondition: '',
                height: '',
                weight: '',
              ),
            ),
          );
          String? emailError = validateEmailOrPhone(moboruserid.text);
          String? passwordError = validatePassword(password.text);

          if (emailError == null && passwordError == null) {
            // login(); // Call login API if validation passes
          } else {
            if (emailError != null) {
              showErrorFlushbar(emailError);
            }
            if (passwordError != null) {
              showErrorFlushbar(passwordError);
            }
          }
        },
      ),
      SizedBox(height: 32),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                endIndent: 20,
              ),
            ),
          ),
          Text('Or sign in with', style: text40014black),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 30.0),
              child: Divider(
                color: Colors.grey,
                thickness: 1,
                indent: 20,
              ),
            ),
          ),
        ],
      ),
      IconButton(
        onPressed: () {},
        icon: Image.asset('assets/icons/google.png', height: 40, width: 40),
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