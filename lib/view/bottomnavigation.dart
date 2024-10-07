import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:med_one/view/Home_pages/Notifications.dart';
import 'package:med_one/view/Home_pages/homepage.dart';
import 'package:med_one/view/Creating%20Profile/Adding%20medcine%20one.dart';

import 'Home_pages/my profile/profile.dart';


class BottomNavigation extends StatefulWidget {
  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _pageIndex = 0;
  final PageController _pageController = PageController();

  final List<Widget> _pages = [
    Homescreen(),
    AddingMedicineone(), // Make sure this widget is implemented correctly
    NotificationsPage(),
    ProfilePage(), // Profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _pageIndex = index; // This updates the selected icon when you swipe between pages
          });
        },
        children: _pages,
        physics: const BouncingScrollPhysics(), // Smooth swipe with bounce effect
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: Colors.teal,
        height: 60,
        index: _pageIndex, // Set the current index to match the page view
        items: <Widget>[
          _buildIcon(_pageIndex == 0
              ? 'assets/icons/homeicon.png'
              : 'assets/icons/homeiconnotselected.png',
              25
          ),
          _buildIcon(_pageIndex == 1
              ? 'assets/icons/addmed.png'
              : 'assets/icons/addmednotselected.png',
              30
          ),
          _buildIcon(_pageIndex == 2
              ? 'assets/icons/bellicon.png'
              : 'assets/icons/belliconnotselected.png',
              25
          ),
          Icon(
            Icons.person,
            size: 30,
            color: _pageIndex == 3 ? Colors.white : Colors.grey,
          ),
        ],
        onTap: (index) {
          setState(() {
            _pageIndex = index;
          });
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300), // Adjust animation duration
            curve: Curves.easeInOut, // Smooth animation
          );
        },
      ),
    );
  }

  Widget _buildIcon(String assetPath, double size) {
    return Image.asset(
      assetPath,
      height: size,
      width: size,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
