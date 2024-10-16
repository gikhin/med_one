import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:med_one/app_colors.dart';
import 'package:med_one/res/appurl.dart';
import 'dart:convert';

import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import 'Adding medcine one.dart';

class DailyRoutine extends StatefulWidget {
  const DailyRoutine({super.key});

  @override
  State<DailyRoutine> createState() => _DailyRoutineState();
}

class _DailyRoutineState extends State<DailyRoutine> {
  DateTime currentDate = DateTime.now();
  List<TimeOfDay> selectedTimes = [
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 10, minute: 0),
    TimeOfDay(hour: 12, minute: 0),
    TimeOfDay(hour: 18, minute: 0),
    TimeOfDay(hour: 22, minute: 0),
    TimeOfDay(hour: 22, minute: 0),
  ];

  String _timeOfDayToString(TimeOfDay time) {
    final hours = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minutes = time.minute.toString().padLeft(2, '0');
    final amPm = time.hour >= 12 ? 'PM' : 'AM';
    return '$hours:$minutes $amPm';
  }

  Map<String, dynamic> _convertToRoutine() {
    return {
      'userId': 45,
      'routine': [
        {
          'wakeUp': _timeOfDayToString(selectedTimes[0]),
          'breakfast': _timeOfDayToString(selectedTimes[1]),
          'lunch': _timeOfDayToString(selectedTimes[2]),
          'dinner': _timeOfDayToString(selectedTimes[3]),
          'sleep': _timeOfDayToString(selectedTimes[4]),
        },
      ],
    };
  }

  // Future<void> _sendRoutineToBackend() async {
  //   final routineData = _convertToRoutine();
  //   final url = Uri.parse(AppUrl.addingRoutine);
  //   try {
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //       body: json.encode(routineData),
  //     );
  //     if (response.statusCode == 200) {
  //       _showFlushbar("Routine saved successfully!", Colors.green);
  //       print('Routine saved: ${response.body}');
  //
  //       _showMedicationOptionsDialog(context);
  //     } else {
  //       _showFlushbar("Failed to save routine. Error: ${response.statusCode}", Colors.red);
  //     }
  //   } catch (error) {
  //     _showFlushbar("Error sending data: $error", Colors.red);
  //   }
  // }

  void _showFlushbar(String message, Color color) {
    Flushbar(
      message: message,
      backgroundColor: color,
      duration: Duration(seconds: 3),
    )..show(context);
  }

  bool _validateRoutine() {
    // Check if all selected times are provided (can add more checks if needed)
    for (var time in selectedTimes) {
      if (time == null) {
        return false; // Invalid if any time is missing
      }
    }
    return true; // Valid if all fields are filled
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dronewidgets.mainButton(
          title: 'Next',
          onPressed: () =>
              showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text('Are you sure?'),
              content: Text('Are you ready to save the data?'),
              actions: [
                TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
                TextButton(
                  onPressed: () {
                    if (_validateRoutine()) {
                      // _sendRoutineToBackend();
                      _showMedicationOptionsDialog(context);
                    } else {
                      _showFlushbar("Please complete all fields before submitting.", Colors.red);
                    }
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(leading: Dronewidgets.backButton(context)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(text: 'How does your ', style: text60024),
                      TextSpan(text: 'day', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: AppColors.primaryColor2)),
                      TextSpan(text: ' look like?', style: text60024),
                    ],
                  ),
                ),
                SizedBox(height: 30),
                Stack(
                  children: [
                    Positioned(left: 80, child: _buildTimePickerContainer(0)),
                    Container(
                      child: Column(
                        children: [
                          SizedBox(height: 20),
                          Stack(
                            children: [
                              Padding(padding: const EdgeInsets.all(20.0), child: Image.asset('assets/images/s.png')),
                              Positioned(left: 10, child: _buildTooltip('Wake up', 'assets/images/awaken.png')),
                              Positioned(right: 110, top: 60, child: _buildTimePickerContainer(1)),
                              Positioned(right: 50, child: _buildTooltip('Exercise', 'assets/images/exercising.png')),
                              Positioned(right: 110, top: 150, child: _buildTimePickerContainer(2)),
                              Positioned(right: 50, top: 180, child: _buildTooltip('Breakfast', 'assets/images/breakfast 1.png')),
                              Positioned(left: 80, top: 240, child: _buildTimePickerContainer(3)),
                              Positioned(top: 240, left: 10, child: _buildTooltip('Lunch', 'assets/images/lunch-box.png')),
                              Positioned(left: 80, top: 320, child: _buildTimePickerContainer(4)),
                              Positioned(left: 100, top: 360, child: _buildTooltip('Dinner', 'assets/images/roti 1.png')),
                              Positioned(top: 360, right: 40, child: _buildTooltip('Sleep', 'assets/images/sleep.png')),
                              Positioned(right: 30, top: 320, child: _buildTimePickerContainer(5)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerContainer(int index) {
    return GestureDetector(
      onTap: () => _selectTime(index),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(child: Text('${selectedTimes[index].format(context)}')),
        ),
      ),
    );
  }

  Future<void> _selectTime(int index) async {
    final picked = await showTimePicker(context: context, initialTime: selectedTimes[index]);
    if (picked != null) setState(() => selectedTimes[index] = picked);
  }

  Widget _buildTooltip(String message, String imagePath) {
    return Tooltip(
      message: message,
      child: CircleAvatar(
        radius: 35,
        backgroundColor: Color.fromRGBO(125, 210, 255, 1),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Image.asset(imagePath),
        ),
      ),
    );
  }


  void _showMedicationOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: AppColors.containercolor,

        content: medicationOptionsContainer(context),

      ),
    );
  }

  // Your medicationOptionsContainer function
  static Widget medicationOptionsContainer(BuildContext context) {
    return Container(

      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Do you have any past orders or need to add it manually?',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.normal,
              color: Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // "Past order" button
          Dronewidgets.mainButton(title: 'Past order', onPressed: (){
            Navigator.pop(context);

          }
          ),
          SizedBox(height: 12),
          // "Add Medication" button
          Dronewidgets.mainButton(title: 'Add Medication', onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));

          })

        ],
      ),
    );
  }
}
