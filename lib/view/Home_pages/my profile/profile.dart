import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../app_colors.dart';
import '../../../widgets/CustomWidgets.dart';
import 'edit profile.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200], // For the background color at the bottom
      body: Column(
        children: [
          // Purple background with circular image
          Stack(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor2,// Purple color
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(60),
                  ),
                ),
              ),
              Positioned(
                left: 16,
                top: 40,
                child: Dronewidgets.backButton(context),
              ),
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
              Positioned(
                top: 100,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Icon(CupertinoIcons.person),

                      // You can also use Image.asset if you have a local image
                    ),
                    SizedBox(height: 10),
                    Text(
                      'Cris Joe',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'crisJoe@gmail.com',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          // Menu items
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16), // Add padding
              children: [
                ProfileMenuItem(
                  icon: Icons.person,
                  title: 'My Profile',
                  onTap: () {
                   Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage(),));
                  },
                ),

                ProfileMenuItem(
                  icon: Icons.medical_services,
                  title: 'Medication History',
                  onTap: () {
                    // Navigate to Medication history
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.settings,
                  title: 'Settings',
                  onTap: () {
                    // Navigate to Profile page
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.help_outline,
                  title: 'FAQ',
                  onTap: () {
                    // Navigate to FAQ
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.info_outline,
                  title: 'About App',
                  onTap: () {
                    // Navigate to About App
                  },
                ),
                ProfileMenuItem(
                  icon: Icons.logout,
                  title: 'Logout',
                  onTap: () {
                    // Show logout confirmation dialog
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure you want to logout?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle logout logic here
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Logout'),
            ),
          ],
        );
      },
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  ProfileMenuItem({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(backgroundColor: AppColors.containercolor,
          child: Icon(icon, color: Colors.black)),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: CircleAvatar(
          backgroundColor: AppColors.containercolor,
          child: Icon(Icons.arrow_forward_ios, color: Colors.grey)),
      onTap: onTap,
    );
  }
}
