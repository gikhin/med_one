import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart'; // Import another_flushbar
import 'package:med_one/view/splash_screen/keeptrack_splash.dart';
import 'package:med_one/widgets/CustomWidgets.dart';
import '../constants.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController moboruserid = TextEditingController();
  final TextEditingController password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;

  // Custom email/phone validation
  String? validateEmailOrPhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email or phone number';
    }
    // Simple validation for email format
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey, // Assign the form key
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,
        
                  children: [
                    Text('Welcome Back', style: text60030),
                    Text('Enter your credentials to continue', style: text40018primary),
                    SizedBox(height: 30),
                    // Email input field
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Email / Phone number', style: text40012primary),
                          ),
                          SizedBox(height: 10,),
                          Dronewidgets.customTextFormField(
                            controller: moboruserid,
                          ),
                        ],
                      ),
                    ),
                    // Password input field with obscure text
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text('Password', style: text40012primary),
                          ),
                          SizedBox(height: 10,),
                          Dronewidgets.customTextFormField(
                            controller: password,
                            obscureText: !_isPasswordVisible,
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
                          // Forgot Password
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {},
                                child: Text('Forgot Password?', style: text40012primary),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
        
                    // Sign In button
                    Dronewidgets.mainButton(title: 'Sign In', onPressed: () {
                      String? emailError = validateEmailOrPhone(moboruserid.text);
                      String? passwordError = validatePassword(password.text);
        
                      if (emailError == null && passwordError == null) {
                        // Form is valid, proceed with login
                        Flushbar(
                          message: 'Logging in...',
                          duration: Duration(seconds: 2),
                          flushbarPosition: FlushbarPosition.TOP,
                          backgroundColor: Colors.green,
                        ).show(context);
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => MedicationTrackerScreen(),));
                      } else {
                        // Display validation errors in Flushbar
                        if (emailError != null) {
                          showErrorFlushbar(emailError);
                        }
                        if (passwordError != null) {
                          showErrorFlushbar(passwordError);
                        }
                      }
                    }),
                    SizedBox(height: 32),
                    // Social sign-in option
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 30.0),
                            child: Divider(
                              color: Colors.grey, // Line color
                              thickness: 1, // Line thickness
                              endIndent: 20, // Space between line and text
                            ),
                          ),
                        ),
                        Text('Or sign in with', style: text40014black),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30.0),
                            child: Divider(
                              color: Colors.grey, // Line color
                              thickness: 1, // Line thickness
                              indent: 20, // Space between line and text
                            ),
                          ),
                        ),
                      ],
                    ),
        
                    IconButton(onPressed: () {
        
                    }, icon: Image.asset('assets/icons/google.png',height: 40,width: 40,)),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
