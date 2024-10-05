import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:med_one/view/Home_pages/Notifications.dart';
import 'package:med_one/view/Home_pages/homepage.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';

import 'Creating Profile/Adding medcine one.dart';
import 'Creating Profile/Adding medicine two.dart';
import 'Home_pages/profile.dart';  // Ensure you import your second medicine adding page



class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    Homescreen(),
    AddingMedicineone(),
    NotificationsPage(),
    ProfilePage(),  // A placeholder for the settings page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_pageIndex],
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        height: 60,
        items: <Widget>[


          Image.asset(color: Colors.white,
            'assets/icons/homeicon.png', // Replace with your home icon image path
            height: 25, // Adjust the size as needed
            width: 25,
          ),
          Image.asset(color: Colors.white,
            'assets/icons/addmed.png', // Replace with your home icon image path
            height: 30, // Adjust the size as needed
            width: 30,
          ),
          Image.asset(color: Colors.white,
            'assets/icons/bellicon.png', // Replace with your home icon image path
            height: 25, // Adjust the size as needed
            width: 25,
          ),
          Icon(Icons.person, size: 30, color: Colors.white),

        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
        },
      ),
    );
  }
}
