import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:lottie/lottie.dart';
import 'package:med_one/app_colors.dart'; // Adjust the import according to your project structure
import 'package:med_one/widgets/CustomWidgets.dart';
import '../../constants.dart';
import '../Creating Profile/Adding medcine one.dart'; // Adjust as necessary for your text styles

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  // List of medicines with colors from AppColors
  final List<Map<String, dynamic>> medicines = [
    {
      'name': 'Insulin',
      'instruction': 'Scheduled for 8:00AM',
      'pillCount': 'Take 1 (s)',
      'color': AppColors.homecardcolor1, // Use AppColors
    },
    {
      'name': 'Vitamin D',
      'instruction': 'Scheduled for 1:00PM',
      'pillCount': 'Take 1 pill(s)',
      'color': AppColors.homecardcolor2, // Use AppColors
    },
    {
      'name': 'Aspirin',
      'instruction': 'Scheduled for 8:00PM',
      'pillCount': 'Take 1 pill(s)',
      'color': AppColors.homecardcolor3, // Use AppColors
    },
    {
      'name': 'Loratadine',
      'instruction': 'Scheduled for 8:00AM',
      'pillCount': 'Take 1 pill(s)',
      'color': AppColors.homecardcolor4, // Use AppColors
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pageColor,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Hi,", style: text60022bla),
              SizedBox(height: 9),
              Text("HEAVN JOE", style: text60022bla),
              SizedBox(height: 15),
              Text("Today’s Medicine", style: text60022bla),
              Text("Reminder", style: text60022bla),
              SizedBox(height: 10,),
        
              SizedBox(
                height: 250,
                child: Stack(
                  children: List.generate(medicines.length, (index) {
                    final medicine = medicines[index];
                    return Positioned(
        
                      bottom: index * 20.0, // Adjust the position based on index
                      left: 0,
                      right: 0,
                      child: buildDismissibleCard(
                        color: medicine['color'], // Use the color from the list
                        medicineName: medicine['name'],
                        instruction: medicine['instruction'],
                        pillcount: medicine['pillCount'],
                      ),
                    );
                  }),
                ),
              ),

            
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDismissibleCard({
    required Color color,
    required String medicineName,
    required String instruction,
    required String pillcount,
  }) {
    return Dismissible(
      key: UniqueKey(),
      background: Container(
        color: Colors.green,
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.only(left: 20),
        child: Text(
          'Taken',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      secondaryBackground: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 20),
        child: Text(
          'Skipped',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          // Swiped right (Taken)
          showFlushbar(context, '$medicineName marked as taken', Colors.green);
        } else {
          // Swiped left (Skipped)
          showFlushbar(context, '$medicineName marked as skipped', Colors.red);
        }
      },
      child: Stack(
        children: [
          Container(
            height: 180,
            margin: EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/images/medicine.png'),
                    ],
                  ),
                  Text(medicineName, style: text60022),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Image.asset('assets/icons/calendar-day.png', height: 15, width: 15),
                      SizedBox(width: 10),
                      Text(instruction, style: text40014),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Image.asset('assets/icons/info (2).png', height: 15, width: 15),
                      SizedBox(width: 10),
                      Text(pillcount, style: text40014),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Image.asset(
              'assets/images/doctor.png',
              height: 130.06,
              width: 130.63,
            ),
          ),
        ],
      ),
    );
  }

  void showFlushbar(BuildContext context, String message, Color backgroundColor) {
    Flushbar(
      message: message,
      duration: Duration(seconds: 3),
      backgroundColor: backgroundColor,
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      margin: EdgeInsets.all(8),
    )..show(context);
  }







}
