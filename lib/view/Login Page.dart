import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart'; // Import another_flushbar

import 'package:med_one/res/appurl.dart';
import 'package:med_one/view/splash_screen/keeptrack_splash.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
    if (value == null || value.isEmpty) {
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
    if (value == null || value.isEmpty) {
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




  // Future<void> login() async {
  //   final url = Uri.parse(AppUrl.login); // Replace with AppUrl.login
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'email': moboruserid.text,
  //         'password': password.text,
  //       }),
  //     );
  //
  //     print('Response status: ${response.statusCode}'); // Print status code
  //     print('Response body: ${response.body}');         // Print full response body
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['success'] == true) {
  //         // Extract user data from the response
  //         final userData = data['userData'] ?? '';
  //         final String name = userData['name'] ?? '';
  //         final String id = userData['id'] ?? '';
  //         final String gender = userData['gender'] ?? '';
  //         // final String dateOfBirth = userData['ageGroup']; // Assuming this is the date of birth
  //         final String healthCondition = userData['health_condition'] ?? '';
  //         final String height = userData['height'] ?? '';
  //         final String weight = userData['weight'] ?? '';
  //         final String routine = data['routine'] ?? ''; // Get the routine field
  //
  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         String userName = preferences.setString("userName",name).toString();
  //         String userID = preferences.setString('userID', id).toString();
  //         bool routineData = preferences.setBool('routineData', routine as bool) as bool;
  //
  //         print("heloooooooo:${routineData}");
  //
  //         // Login successful, navigate to the appropriate screen
  //         Flushbar(
  //           message: 'Login successful',
  //           duration: Duration(seconds: 2),
  //           flushbarPosition: FlushbarPosition.TOP,
  //           backgroundColor: Colors.green,
  //         ).show(context);
  //
  //         if (routine == "true") {
  //           // Navigate to BottomNavigation if routine is true
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => BottomNavigation(),
  //             ),
  //           );
  //         } else {
  //           // Navigate to MedicationTrackerScreen if routine is not true
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MedicationTrackerScreen(
  //                 name: name,
  //                 gender: gender,
  //                 // dateOfBirth: dateOfBirth,
  //                 healthCondition: healthCondition,
  //                 height: height,
  //                 weight: weight,
  //               ),
  //             ),
  //           );
  //         }
  //       } else {
  //         print('Login failed: ${data['message']}'); // Print error message from API
  //         showErrorFlushbar(data['message']);
  //       }
  //     } else {
  //       showErrorFlushbar('Login failed. Please try again.');
  //     }
  //   } catch (e) {
  //     showErrorFlushbar('An error occurred. Please try again.');
  //   }
  // }


  // Future<void> loginold() async {
  //   final url = Uri.parse(AppUrl.login);
  //
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'email': moboruserid.text,
  //         'password': password.text,
  //       }),
  //     );
  //
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');
  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       if (data['success'] == true) {
  //         final userData = data['userData'] ?? {};
  //         final String name = userData['name'] ?? '';
  //         final String id = userData['id']?.toString() ?? '';
  //         final String gender = userData['gender'] ?? '';
  //         final String image = userData['image'] ?? '';
  //         final String healthCondition = userData['health_condition'] ?? '';
  //         final String height = userData['height'] ?? '';
  //         final String weight = userData['weight'] ?? '';
  //         final String routine = data['routine'] ?? '';
  //
  //         // Uncomment if you want to store data locally
  //         SharedPreferences preferences = await SharedPreferences.getInstance();
  //         preferences.setString("userName", name);
  //         preferences.setString('userID', id);
  //         preferences.setBool('routineData', routine == "true");
  //
  //         Flushbar(
  //           message: 'Login successful',
  //           duration: Duration(seconds: 2),
  //           flushbarPosition: FlushbarPosition.TOP,
  //           backgroundColor: Colors.green,
  //         ).show(context);
  //
  //         if (routine == "true") {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(builder: (context) => BottomNavigation()),
  //           );
  //         } else {
  //           Navigator.pushReplacement(
  //             context,
  //             MaterialPageRoute(
  //               builder: (context) => MedicationTrackerScreen(
  //                 name: name,
  //                 gender: gender,
  //                 healthCondition: healthCondition,
  //                 height: height,
  //                 weight: weight,
  //                 profileImage: image,
  //               ),
  //             ),
  //           );
  //         }
  //       } else {
  //         print('Login failed: ${data['message']}');
  //         showErrorFlushbar(data['message']);
  //       }
  //     } else {
  //       showErrorFlushbar('Login failed. Please try again.');
  //     }
  //   } catch (e) {
  //     showErrorFlushbar('An error occurred. Please try again.');
  //   }
  // }


  Future<void> login() async {
    final url = Uri.parse(AppUrl.login);

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': moboruserid.text,
          'password': password.text,
        }),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success'] == true) {
          final userData = data['userData'] ?? {};
          final String name = userData['name'] ?? '';
          final String id = userData['id']?.toString() ?? '';
          final String gender = userData['gender'] ?? '';
          final String height = userData['height'] ?? '';
          final String weight = userData['weight'] ?? '';
          final String profileImage = userData['image'] ?? '';

          // Extract health conditions into a List
          List<String> healthConditions = [];
          if (userData['health_condition'] != null) {
            for (var condition in userData['health_condition']) {
              healthConditions.add(condition['healthCondition']);
            }
          }
          final String healthCondition = healthConditions.join(', '); // Join conditions into a string

          final String routine = data['routine'] ?? '';

          // Store tokens securely if needed
          SharedPreferences preferences = await SharedPreferences.getInstance();
          preferences.setString("userName", name);
          preferences.setString('userID', id);
          preferences.setBool('routineData', routine == "true");
          preferences.setString('accessToken', data['accessToken']);
          preferences.setString('refreshToken', data['refreshToken']);

          Flushbar(
            message: 'Login successful',
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: Colors.green,
          ).show(context);

          if (routine == "true") {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => BottomNavigation()),
                  (Route<dynamic> route) => false, // This condition removes all previous routes
            );
          } else {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => MedicationTrackerScreen(
            //       name: name,
            //       gender: gender,
            //       healthCondition: healthCondition,
            //       height: height,
            //       weight: weight,
            //     ),
            //   ),
            // );
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MedicationTrackerScreen(
                  name: name,
                  gender: gender,
                  healthCondition: healthCondition,
                  height: height,
                  weight: weight,
                  profileImage: profileImage,
                ),
              ),
                  (Route<dynamic> route) => false, // This removes all previous routes
            );

          }
        } else {
          print('Login failed: ${data['message']}');
          showErrorFlushbar(data['message']);
        }
      } else {
        showErrorFlushbar('Username or password is incorrect.');
      }
    } catch (e) {
      showErrorFlushbar('An error occurred. Please try again.');
    }
  }







  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Hide keyboard when tapping outside
          },
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: screenHeight),
              child: IntrinsicHeight(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
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
                                  child: Text('Email', style: text40012black),
                                ),
                                SizedBox(height: 10),
                                Dronewidgets.customTextFormField(
                                    controller: moboruserid,
                                    fieldFocus: moboruseridNode,
                                    onFieldSubmitted: (v) {
                                      Utils.fieldFocusChange(context, moboruseridNode, passwordNode);
                                    }),
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
                                  onFieldSubmitted: (v) {
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
                                    // TextButton(
                                    //   onPressed: () {},
                                    //   child: Text('Forgot Password?', style: text40012black),
                                    // ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20),
                          Dronewidgets.mainButton(
                            fieldFocus: LoginBtn,
                            title: 'Sign In',
                            onPressed: () {
                              String? emailError = validateEmailOrPhone(moboruserid.text);
                              String? passwordError = validatePassword(password.text);

                              if (emailError == null && passwordError == null) {
                                login(); // Call login API if validation passes
                                print(AppUrl.login);
                                print(moboruserid);
                                print(password);
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
            ),
          ),
        ),
      ),
    );
  }
}
