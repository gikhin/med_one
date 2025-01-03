import 'dart:convert';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:med_one/app_colors.dart';
import 'package:med_one/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../res/appurl.dart';
import '../../widgets/CustomWidgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  Future<List<Map<String, dynamic>>>? futureNotifications;
  String userName = '';
  @override
  void initState() {
    super.initState();
    _loadUserName();
    futureNotifications = fetchNotifications(); // Initialize Future
  }

  Future<void> _loadUserName() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      userName = preferences.getString("userName") ?? 'No user name found';
    });
  }

  String _getFirstLetter() {
    if (userName.isNotEmpty && userName != 'No user name found') {
      return userName[0].toUpperCase();
    }
    return '?';
  }

  Future<List<Map<String, dynamic>>> fetchNotifications() async {
    final url = AppUrl.getNotification; // Your API URL
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userID = preferences.getString('userID');
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userId": int.parse(userID.toString())}),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          // Parse and sort notifications
          List<Map<String, dynamic>> notifications = List<Map<String, dynamic>>.from(data['data'].map((item) {
            return {
              'id': item['id'],
              'message': item['message'],
              'status': item['status'],
            };
          }));

          // Sort by status: "Not Seen" first, then "Seen"
          notifications.sort((a, b) {
            return (a['status'] == 'Not seen' ? 0 : 1).compareTo(b['status'] == 'Not seen' ? 0 : 1);
          });

          return notifications;
        } else {
          throw Exception(data['message']);
        }
      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }


  Future<void> changeNotificationStatus(int notificationId) async {
    final url = AppUrl.changingNotificationStatus; // Your API URL for changing status
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userID = preferences.getString('userID');
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "user_id": int.parse(userID.toString()),
          "notification_id": notificationId,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (!data['success']) {
          throw Exception(data['message']);
        } else {
          // Refresh notifications after changing status
          setState(() {
            futureNotifications = fetchNotifications();
          });
        }
      } else {
        throw Exception('Failed to change status');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageColor,
      appBar: AppBar(
        backgroundColor: AppColors.pageColor,
        title: Text('Notification', style: text40014black),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: futureNotifications,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No notifications available.'));
          } else {
            final notifications = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: ListView.builder(
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];

                  // Check if the status is "Seen" and disable swipe if true
                  final isSeen = notification['status'] == "Seen";

                  return Dismissible(
                    key: Key(notification['id'].toString()), // Unique key for each notification
                    direction: isSeen ? DismissDirection.none : DismissDirection.startToEnd,
                    onDismissed: (direction) async {
                      await changeNotificationStatus(notification['id']); // Change status
                      setState(() {
                        notifications.removeAt(index); // Remove notification from the list
                      });

                      // Use Flushbar instead of SnackBar
                      Flushbar(flushbarPosition: FlushbarPosition.TOP,
                        message: 'Notification status changed.',
                        duration: Duration(seconds: 3),
                        backgroundColor: Colors.green,
                      )..show(context);
                    },
                    background: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(

                        color: Colors.green,
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.check_circle_outline_outlined, color: Colors.white),
                      ),
                    ),
                    child: Container(
                      height: 150,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: AppColors.containercolor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(backgroundColor: AppColors.primaryColor2,
                                  child: TextButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                                      // );
                                    },
                                    child: Text( _getFirstLetter(),style: text40018,),
                                  ),
                                ),// Placeholder for the avatar
                                SizedBox(width: 20),
                                Text('Time to take Your medicine', style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(notification['message']),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text('${notification['status']}', style: TextStyle(color: Colors.grey)),
                                SizedBox(width: 10),
                                // Determine the color of the CircleAvatars based on the status
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: notification['status'] == "Seen" ? Colors.green : Colors.red,
                                ),
                                SizedBox(width: 3),
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: notification['status'] == "Seen" ? Colors.green : Colors.red,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
