import 'package:flutter/material.dart';
import '../app_colors.dart';

class Dronewidgets {
  // Main button widget with customizable onPressed functionality
  static Widget mainButton({
    required String title,
    required VoidCallback onPressed,
    Color? backgroundColor, // Optional parameter for button background color
    Color? textColor, // Optional parameter for text color
  }) {
    return Container(
      width: 350,
      child: ElevatedButton(
        onPressed: onPressed, // Use the passed onPressed function
        style: ElevatedButton.styleFrom(
          primary: backgroundColor ?? AppColors.primaryColor2, // Use passed background color or default
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(36), // Rounded corners
          ),
          textStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            title, // Use the passed title
            style: TextStyle(fontWeight: FontWeight.bold,
              color: textColor ?? Colors.white, // Use passed text color or default to white
            ),
          ),
        ),
      ),
    );
  }
  // Back button widget
  static Widget backButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: CircleAvatar(
        radius: 20,
        backgroundColor: AppColors.primaryColor,
        child: IconButton(
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  // Custom text form field widget with a controller
  static Widget customTextFormField({
    String? hintText,
    required TextEditingController controller, // Add controller parameter
    bool obscureText = false, // Add obscureText parameter with a default value
    Widget? suffixIcon, // Add suffixIcon parameter
    String? Function(String?)? validator, // Add validator parameter
  }) {
    return Container(
      width: 390,
      height: 55,
      child: TextFormField(
        controller: controller, // Use the passed controller
        obscureText: obscureText, // Use the passed obscureText value
        decoration: InputDecoration(
          hintText: hintText ?? '', // Set the placeholder text if provided
          filled: true,
          fillColor: AppColors.textfiedlColorDr1,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20), // Padding inside the field
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(36), // Rounded corners
            borderSide: BorderSide.none, // No border by default
          ),
          hintStyle: TextStyle(
            fontSize: 18,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.normal,
            color: Colors.grey, // Hint text color
          ),
          suffixIcon: suffixIcon, // Add the suffixIcon if provided
        ),
        style: TextStyle(
          fontSize: 18,
          fontFamily: 'Poppins',
          fontWeight: FontWeight.normal,
          color: Colors.black, // Text color
        ),
        validator: validator, // Use the validator if provided
      ),
    );
  }


}
