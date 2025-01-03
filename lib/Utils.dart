import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';
import 'package:med_one/res/appurl.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
class Utils{
  // next field focused in textField
  static fieldFocusChange(
      BuildContext context,
      FocusNode current,
      FocusNode nextFocus,){
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static flushBarSuccessMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar:
      Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.verified ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.lightGreen,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}

  static flushBarErrorMessage(String message , BuildContext context){
    showFlushbar(context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        reverseAnimationCurve: Curves.easeOut,
        positionOffset: 20,
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(20),
        icon: const Icon(Icons.error ,size: 28,color: Colors.white,),
        margin: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        backgroundColor: Colors.red,
        messageColor: Colors.white,
        duration: const Duration(seconds: 3),
      )..show(context),
    );}

  //send fcm tokne to backend
  static Future<void> sendfcmtoken(String fcmtoken) async {
    try {
      // Retrieve the user ID from SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userID = preferences.getString('userID');

      if (userID == null) {
        print('User ID not found');
        return;
      }

      // Define the API URL
      final String apiUrl = AppUrl.addtoken;

      // Create the JSON payload
      Map<String, dynamic> payload = {
        "id": int.parse(userID),
        "token": fcmtoken
      };

      // Make the POST request
      final response = await http.post(
        Uri.parse(apiUrl), // Parse the URL
        headers: {
          "Content-Type": "application/json", // Set the request headers
        },
        body: jsonEncode(payload), // Encode the payload as JSON
      );

      print('fcm token passing to backend...');
      print('check1:${response.body}');
      print('check2:${response.statusCode}');

      // Check the response status
      if (response.statusCode == 200) {
        print('Response: ${response.body}');
      } else {
        print('Failed to send data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      // Catch any exceptions and print the error
      print('An error occurred: $e');
    }
  }

  static Future<void> launchAsInAppWebViewWithCustomHeaders(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(
          headers: <String, String>{'my_header_key': 'my_header_value'}),
    )) {
      throw Exception('Could not launch $url');
    }
  }

}