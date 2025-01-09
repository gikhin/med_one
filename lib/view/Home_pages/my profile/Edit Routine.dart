// //
// // import 'package:another_flushbar/flushbar.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:med_one/app_colors.dart';
// // import 'package:med_one/res/appurl.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'dart:convert';
// //
// // import '../../../constants.dart';
// // import '../../../widgets/CustomWidgets.dart';
// // import '../../Creating Profile/Adding medcine one.dart';
// //
// //
// //
// // class EditDailyRoutine extends StatefulWidget {
// //   const EditDailyRoutine({super.key});
// //
// //   @override
// //   State<EditDailyRoutine> createState() => _EditDailyRoutineState();
// // }
// //
// // class _EditDailyRoutineState extends State<EditDailyRoutine> {
// //   List<dynamic> routineData = []; // To hold the routine data
// //   List<TimeOfDay> routineTimes = []; // To hold TimeOfDay values
// //   bool isLoading = true; // To handle loading state
// //
// //   List<TimeOfDay> selectedTimes = [
// //     TimeOfDay(hour: 8, minute: 0),
// //     TimeOfDay(hour: 10, minute: 0),
// //     TimeOfDay(hour: 12, minute: 0),
// //     TimeOfDay(hour: 18, minute: 0),
// //     TimeOfDay(hour: 22, minute: 0),
// //     TimeOfDay(hour: 22, minute: 0),
// //   ];
// //   String _timeOfDayToString(TimeOfDay time) {
// //     final hours = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
// //     final minutes = time.minute.toString().padLeft(2, '0');
// //     final amPm = time.hour >= 12 ? 'PM' : 'AM';
// //     return '$hours:$minutes $amPm';
// //   }
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     _fetchRoutine();
// //   }
// //
// //   Map<String, dynamic> _convertToRoutine(int userid) {
// //     return {
// //       'userId': userid,
// //       'routine': [
// //         {
// //           'wakeUp': _timeOfDayToString(selectedTimes[0]),
// //           'breakfast': _timeOfDayToString(selectedTimes[1]),
// //           'lunch': _timeOfDayToString(selectedTimes[2]),
// //           'dinner': _timeOfDayToString(selectedTimes[3]),
// //           'sleep': _timeOfDayToString(selectedTimes[4]),
// //         },
// //       ],
// //     };
// //   }
// //
// //   Future<void> _fetchRoutine() async {
// //     final url = Uri.parse(AppUrl.gettingRoutine);
// //     print(AppUrl.gettingRoutine);
// //     try {
// //       SharedPreferences preferences = await SharedPreferences.getInstance();
// //       String? userID = preferences.getString('userID');
// //       final response = await http.post(
// //         url,
// //         headers: {'Content-Type': 'application/json'},
// //         body: json.encode({'userId': int.parse(userID.toString())}),
// //       );
// //       if (response.statusCode == 200) {
// //         final responseData = json.decode(response.body);
// //         setState(() {
// //           routineData = responseData['data'];
// //           _parseRoutineTimes();
// //           isLoading = false;
// //         });
// //
// //       } else {
// //         // Handle error
// //         setState(() {
// //           isLoading = false;
// //         });
// //       }
// //     } catch (error) {
// //       setState(() {
// //         isLoading = false;
// //       });
// //       _showFlushbar("Error fetching routine: $error", Colors.red);
// //     }
// //   }
// //
// //
// //   Future<void> _sendRoutineToBackend() async {
// //     SharedPreferences preferences = await SharedPreferences.getInstance();
// //     String? userId = preferences.getString('userID');
// //     final routineData = _convertToRoutine(int.parse(userId.toString()));
// //     final url = Uri.parse(AppUrl.editRoutine);
// //     try {
// //       final response = await http.post(
// //         url,
// //         headers: {'Content-Type': 'application/json'},
// //         body: json.encode(routineData),
// //       );
// //       if (response.statusCode == 200) {
// //         _showFlushbar("Routine saved successfully!", Colors.green);
// //         print('Routine saved: ${response.body}');
// //
// //         _showMedicationOptionsDialog(context);
// //       } else {
// //         _showFlushbar("Failed to save routine. Error: ${response.statusCode}", Colors.red);
// //       }
// //     } catch (error) {
// //       _showFlushbar("Error sending data: $error", Colors.red);
// //     }
// //   }
// //   void _showMedicationOptionsDialog(BuildContext context) {
// //     showDialog(
// //       context: context,
// //       builder: (BuildContext context) => AlertDialog(
// //         backgroundColor: AppColors.containercolor,
// //
// //         content: medicationOptionsContainer(context),
// //
// //       ),
// //     );
// //   }
// //
// //   void _parseRoutineTimes() {
// //     if (routineData.isNotEmpty) {
// //       final routine = routineData[0]['routine'][0];
// //       routineTimes = [
// //         _stringToTimeOfDay(routine['wakeUp']),
// //         _stringToTimeOfDay(routine['breakfast']),
// //         _stringToTimeOfDay(routine['lunch']),
// //         _stringToTimeOfDay(routine['dinner']),
// //         _stringToTimeOfDay(routine['sleep']),
// //       ];
// //     }
// //   }
// //
// //
// //   TimeOfDay _stringToTimeOfDay(String timeString) {
// //     final parts = timeString.split(' ');
// //     final timeParts = parts[0].split(':');
// //     final hour = int.parse(timeParts[0]);
// //     final minute = int.parse(timeParts[1]);
// //
// //     // Adjust hour for AM/PM
// //     if (parts[1] == 'PM' && hour != 12) {
// //       return TimeOfDay(hour: hour + 12, minute: minute);
// //     } else if (parts[1] == 'AM' && hour == 12) {
// //       return TimeOfDay(hour: 0, minute: minute);
// //     }
// //     return TimeOfDay(hour: hour, minute: minute);
// //   }
// //
// //   void _showFlushbar(String message, Color color) {
// //     Flushbar(
// //       message: message,
// //       backgroundColor: color,
// //       duration: Duration(seconds: 3),
// //     )..show(context);
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       floatingActionButton: Padding(
// //         padding: const EdgeInsets.all(8.0),
// //         child: Dronewidgets.mainButton(
// //           title: 'Edit Routine',
// //           onPressed: () => showDialog(
// //             context: context,
// //             builder: (BuildContext context) => AlertDialog(
// //               title: Text('Are you sure?'),
// //               content: Text('Are you ready to save the data?'),
// //               actions: [
// //                 TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
// //                 TextButton(
// //                   onPressed: () {
// //                     // Add your save logic here if needed
// //                     _sendRoutineToBackend();
// //                   },
// //                   child: Text('OK'),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
// //       appBar: AppBar(
// //         // actions: [
// //         //   ElevatedButton(
// //         //     onPressed: () {
// //         //       Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));
// //         //     },
// //         //     child: Text('Skip', style: text40018primary),
// //         //   ),
// //         //   SizedBox(width: 10),
// //         // ],
// //         leading: Dronewidgets.backButton(context),
// //       ),
// //       body: SafeArea(
// //         child: Padding(
// //           padding: const EdgeInsets.all(10.0),
// //           child: SingleChildScrollView(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 SizedBox(height: 20),
// //                 Text.rich(
// //                   TextSpan(
// //                     children: [
// //                       TextSpan(text: 'How does your ', style: text60024),
// //                       TextSpan(text: 'day', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: AppColors.primaryColor2)),
// //                       TextSpan(text: ' look like?', style: text60024),
// //                     ],
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),
// //                 Container(
// //                   height: 500,
// //                   child: Stack(
// //                     children: [
// //                       Positioned(left: 80, child: _buildTimePickerContainer(0)),
// //                       Container(
// //                         child: SingleChildScrollView(
// //                           child: Column(
// //                             children: [
// //                               SizedBox(height: 20),
// //                               Center(
// //                                 child: Stack(
// //                                   children: [
// //                                     Padding(padding: const EdgeInsets.all(20.0), child: Image.asset('assets/images/s.png')),
// //                                     Positioned(left: 10, child: _buildTooltip('Wake up', 'assets/images/awaken.png')),
// //                                     Positioned(right: 110, top: 60, child: _buildTimePickerContainer(1)),
// //                                     Positioned(right: 50, child: _buildTooltip('Breakfast', 'assets/images/breakfast 1.png')),
// //                                     Positioned(right: 110, top: 150, child: _buildTimePickerContainer(2)),
// //                                     Positioned(right: 50, top: 180, child: _buildTooltip('Lunch', 'assets/images/lunch-box.png')),
// //
// //
// //                                     Positioned(left: 80, top: 240, child: _buildTimePickerContainer(3)),
// //                                     Positioned(left: 100, top: 360, child: _buildTooltip('Dinner', 'assets/images/roti 1.png')),
// //                                     Positioned(right: 30, top: 320, child: _buildTimePickerContainer(4)),
// //                                     Positioned(top: 360, right: 40, child: _buildTooltip('Sleep', 'assets/images/sleep.png')),
// //                                     SizedBox(height: 700),
// //                                   ],
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildTimePickerContainer(int index) {
// //     if (isLoading) {
// //       return CircularProgressIndicator(); // Show a loading indicator
// //     } else if (routineTimes.isNotEmpty) {
// //       return GestureDetector(
// //         onTap: () => _selectTime(index),
// //         child: Container(
// //           width: 100,
// //           decoration: BoxDecoration(
// //             color: Colors.grey.shade100,
// //             borderRadius: BorderRadius.circular(50),
// //           ),
// //           child: Padding(
// //             padding: const EdgeInsets.all(8.0),
// //             child: Center(child: Text('${routineTimes[index].format(context)}')),
// //           ),
// //         ),
// //       );
// //     }
// //
// //     return SizedBox.shrink(); // Return an empty box if no data
// //   }
// //
// //   Future<void> _selectTime(int index) async {
// //     final picked = await showTimePicker(context: context, initialTime: routineTimes[index]);
// //     if (picked != null) setState(() => routineTimes[index] = picked);
// //   }
// //
// //   Widget _buildTooltip(String message, String imagePath) {
// //     return Tooltip(
// //       message: message,
// //       child: CircleAvatar(
// //         radius: 35,
// //         backgroundColor: Color.fromRGBO(125, 210, 255, 1),
// //         child: Padding(
// //           padding: const EdgeInsets.all(15.0),
// //           child: Image.asset(imagePath),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   // Your medicationOptionsContainer function
// //   static Widget medicationOptionsContainer(BuildContext context) {
// //     return Container(
// //
// //       child: Column(
// //         mainAxisSize: MainAxisSize.min,
// //         children: [
// //           Text(
// //             'Do you have any past orders or need to add it manually?',
// //             style: TextStyle(
// //               fontSize: 18,
// //               fontWeight: FontWeight.normal,
// //               color: Colors.grey,
// //             ),
// //             textAlign: TextAlign.center,
// //           ),
// //           SizedBox(height: 20),
// //           // "Past order" button
// //           Dronewidgets.mainButton(title: 'Past order', onPressed: (){
// //             Navigator.pop(context);
// //
// //           }
// //           ),
// //           SizedBox(height: 12),
// //           // "Add Medication" button
// //           Dronewidgets.mainButton(title: 'Add Medication', onPressed: (){
// //             // Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));
// //             Navigator.pushAndRemoveUntil(
// //               context,
// //               MaterialPageRoute(builder: (context) => AddingMedicineone()),
// //                   (Route<dynamic> route) => false, // This removes all previous routes
// //             );
// //
// //           })
// //
// //         ],
// //       ),
// //     );
// //   }
// // }
//
//
//
//
// import 'package:another_flushbar/flushbar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// import 'package:med_one/app_colors.dart';
// import 'package:med_one/res/appurl.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:convert';
//
// import '../../../constants.dart';
// import '../../../widgets/CustomWidgets.dart';
// import '../../Creating Profile/Adding medcine one.dart';
// import '../../bottomnavigation.dart';
//
// class EditDailyRoutine extends StatefulWidget {
//   const EditDailyRoutine({super.key});
//
//   @override
//   State<EditDailyRoutine> createState() => _EditDailyRoutineState();
// }
//
// class _EditDailyRoutineState extends State<EditDailyRoutine> {
//
//
//   //   @override
//   // void initState() {
//   //   super.initState();
//   //   _fetchRoutine();
//   // }
//   //
//   // List<dynamic> routineData = []; // To hold the routine data
//   // List<TimeOfDay> routineTimes = []; // To hold TimeOfDay values
//   // bool isLoading = true; // To handle loading state
//   //
//   // DateTime currentDate = DateTime.now();
//   // List<TimeOfDay> selectedTimes = [
//   //   TimeOfDay(hour: 8, minute: 0),
//   //   TimeOfDay(hour: 10, minute: 0),
//   //   TimeOfDay(hour: 12, minute: 0),
//   //   TimeOfDay(hour: 18, minute: 0),
//   //   TimeOfDay(hour: 22, minute: 0),
//   //   TimeOfDay(hour: 22, minute: 0),
//   // ];
//   //
//   // String _timeOfDayToString(TimeOfDay time) {
//   //   final hours = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
//   //   final minutes = time.minute.toString().padLeft(2, '0');
//   //   final amPm = time.hour >= 12 ? 'PM' : 'AM';
//   //   return '$hours:$minutes $amPm';
//   // }
//   //
//   // Future<Map<String, dynamic>> _convertToRoutine() async {
//   //   SharedPreferences preferences = await SharedPreferences.getInstance();
//   //   String? userID = preferences.getString('userID');
//   //   return {
//   //     'userId': userID,
//   //     'routine': [
//   //       {
//   //         'wakeUp': _timeOfDayToString(selectedTimes[0]),
//   //         'breakfast': _timeOfDayToString(selectedTimes[1]),
//   //         'lunch': _timeOfDayToString(selectedTimes[2]),
//   //         'dinner': _timeOfDayToString(selectedTimes[3]),
//   //         'sleep': _timeOfDayToString(selectedTimes[4]),
//   //       },
//   //     ],
//   //   };
//   // }
//   //
//   // Future<void> _fetchRoutine() async {
//   //   final url = Uri.parse(AppUrl.gettingRoutine);
//   //   print(AppUrl.gettingRoutine);
//   //   try {
//   //     SharedPreferences preferences = await SharedPreferences.getInstance();
//   //     String? userID = preferences.getString('userID');
//   //     final response = await http.post(
//   //       url,
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: json.encode({'userId': int.parse(userID.toString())}),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       final responseData = json.decode(response.body);
//   //       setState(() {
//   //         routineData = responseData['data'];
//   //         _parseRoutineTimes();
//   //         isLoading = false;
//   //       });
//   //
//   //     } else {
//   //       // Handle error
//   //       setState(() {
//   //         isLoading = false;
//   //       });
//   //     }
//   //   } catch (error) {
//   //     setState(() {
//   //       isLoading = false;
//   //     });
//   //     _showFlushbar("Error fetching routine: $error", Colors.red);
//   //   }
//   // }
//   //     void _parseRoutineTimes() {
//   //   if (routineData.isNotEmpty) {
//   //     final routine = routineData[0]['routine'][0];
//   //     routineTimes = [
//   //       _stringToTimeOfDay(routine['wakeUp']),
//   //       _stringToTimeOfDay(routine['breakfast']),
//   //       _stringToTimeOfDay(routine['lunch']),
//   //       _stringToTimeOfDay(routine['dinner']),
//   //       _stringToTimeOfDay(routine['sleep']),
//   //     ];
//   //   }
//   // }
//   //
//   // TimeOfDay _stringToTimeOfDay(String timeString) {
//   //   final parts = timeString.split(' ');
//   //   final timeParts = parts[0].split(':');
//   //   final hour = int.parse(timeParts[0]);
//   //   final minute = int.parse(timeParts[1]);
//   //
//   //   // Adjust hour for AM/PM
//   //   if (parts[1] == 'PM' && hour != 12) {
//   //     return TimeOfDay(hour: hour + 12, minute: minute);
//   //   } else if (parts[1] == 'AM' && hour == 12) {
//   //     return TimeOfDay(hour: 0, minute: minute);
//   //   }
//   //   return TimeOfDay(hour: hour, minute: minute);
//   // }
//   //
//   //
//   // Future<void> _sendRoutineToBackend() async {
//   //   final routineData = _convertToRoutine();
//   //   final url = Uri.parse(AppUrl.editRoutine);
//   //   try {
//   //     final response = await http.post(
//   //       url,
//   //       headers: {'Content-Type': 'application/json'},
//   //       body: json.encode(routineData),
//   //     );
//   //     if (response.statusCode == 200) {
//   //       _showFlushbar("Routine saved successfully!", Colors.green);
//   //       print('Routine saved: ${response.body}');
//   //
//   //       _showMedicationOptionsDialog(context);
//   //     } else {
//   //       print("${response.statusCode}");
//   //       _showFlushbar("Failed to save routine. Error: ${response.statusCode}", Colors.red);
//   //     }
//   //   } catch (error) {
//   //     _showFlushbar("Error sending data: $error", Colors.red);
//   //   }
//   // }
//   //
//   // void _showFlushbar(String message, Color color) {
//   //   Flushbar(
//   //     message: message,
//   //     backgroundColor: color,
//   //     duration: Duration(seconds: 3),
//   //   )..show(context);
//   // }
//   //
//   // bool _validateRoutine() {
//   //   // Check if all selected times are provided (can add more checks if needed)
//   //   for (var time in selectedTimes) {
//   //     if (time == null) {
//   //       return false; // Invalid if any time is missing
//   //     }
//   //   }
//   //   return true; // Valid if all fields are filled
//   // }
//
//   List<dynamic> routineData = []; // To hold the routine data
//   List<TimeOfDay> routineTimes = []; // To hold TimeOfDay values
//   bool isLoading = true; // To handle loading state
//
//   List<TimeOfDay> selectedTimes = [
//     TimeOfDay(hour: 7, minute: 0),
//     TimeOfDay(hour: 8, minute: 0),
//     TimeOfDay(hour: 9, minute: 0),
//     TimeOfDay(hour: 13, minute: 0),
//     TimeOfDay(hour: 20, minute: 0),
//     TimeOfDay(hour: 22, minute: 0),
//   ];
//   String _timeOfDayToString(TimeOfDay time) {
//     final hours = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
//     final minutes = time.minute.toString().padLeft(2, '0');
//     final amPm = time.hour >= 12 ? 'PM' : 'AM';
//     return '$hours:$minutes $amPm';
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchRoutine();
//   }
//
//   Map<String, dynamic> _convertToRoutine(int userid) {
//     return {
//       'userId': int.parse(userid.toString()),
//       'routine': [
//         {
//           'wakeUp': _timeOfDayToString(selectedTimes[0]),
//           'exercise': _timeOfDayToString(selectedTimes[5]),
//           'breakfast': _timeOfDayToString(selectedTimes[1]),
//           'lunch': _timeOfDayToString(selectedTimes[2]),
//           'dinner': _timeOfDayToString(selectedTimes[3]),
//           'sleep': _timeOfDayToString(selectedTimes[4]),
//         },
//       ],
//     };
//   }
//
//   Future<void> _fetchRoutine() async {
//     final url = Uri.parse(AppUrl.gettingRoutine);
//     print(AppUrl.gettingRoutine);
//     try {
//       SharedPreferences preferences = await SharedPreferences.getInstance();
//       String? userID = preferences.getString('userID');
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode({'userId': int.parse(userID.toString())}),
//       );
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         setState(() {
//           routineData = responseData['data'];
//           _parseRoutineTimes();
//           isLoading = false;
//         });
//
//       } else {
//         // Handle error
//         setState(() {
//           isLoading = false;
//         });
//       }
//     } catch (error) {
//       setState(() {
//         isLoading = false;
//       });
//       _showFlushbar("Error fetching routine: $error", Colors.red);
//     }
//   }
//
//
//   Future<void> _sendeditRoutineToBackend() async {
//     SharedPreferences preferences = await SharedPreferences.getInstance();
//     String? userId = preferences.getString('userID');
//     final routineData = _convertToRoutine(int.parse(userId.toString()));
//     final url = Uri.parse(AppUrl.editRoutine);
//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(routineData),
//       );
//       if (response.statusCode == 200) {
//         _showFlushbar("Routine saved successfully!", Colors.green);
//         print('Routine saved: ${response.body}');
//         print('Routine datas: ${routineData}');
//
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => BottomNavigation()),
//               (Route<dynamic> route) => false, // This condition removes all previous routes
//         );
//       } else {
//         _showFlushbar("Failed to save routine. Error: ${response.statusCode}", Colors.red);
//       }
//     } catch (error) {
//       _showFlushbar("Error sending data: $error", Colors.red);
//     }
//   }
//
//   void _showMedicationOptionsDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         backgroundColor: AppColors.containercolor,
//
//         content: medicationOptionsContainer(context),
//
//       ),
//     );
//   }
//
//   void _parseRoutineTimes() {
//     if (routineData.isNotEmpty) {
//       final routine = routineData[0]['routine'][0];
//       routineTimes = [
//         _stringToTimeOfDay(routine['wakeUp']),
//         _stringToTimeOfDay(routine['exercise']),
//         _stringToTimeOfDay(routine['breakfast']),
//         _stringToTimeOfDay(routine['lunch']),
//         _stringToTimeOfDay(routine['dinner']),
//         _stringToTimeOfDay(routine['sleep']),
//       ];
//     }
//   }
//
//
//   TimeOfDay _stringToTimeOfDay(String timeString) {
//     final parts = timeString.split(' ');
//     final timeParts = parts[0].split(':');
//     final hour = int.parse(timeParts[0]);
//     final minute = int.parse(timeParts[1]);
//
//     // Adjust hour for AM/PM
//     if (parts[1] == 'PM' && hour != 12) {
//       return TimeOfDay(hour: hour + 12, minute: minute);
//     } else if (parts[1] == 'AM' && hour == 12) {
//       return TimeOfDay(hour: 0, minute: minute);
//     }
//     return TimeOfDay(hour: hour, minute: minute);
//   }
//
//   void _showFlushbar(String message, Color color) {
//     Flushbar(
//       message: message,
//       backgroundColor: color,
//       duration: Duration(seconds: 3),
//     )..show(context);
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Dronewidgets.mainButton(
//           title: 'Edit Routine',
//           onPressed: () =>
//               showDialog(
//                 context: context,
//                 builder: (BuildContext context) => AlertDialog(
//                   title: Text('Are you sure?'),
//                   content: Text('Are you ready to save the data?'),
//                   actions: [
//                     TextButton(onPressed: () => Navigator.pop(context), child: Text('Cancel')),
//                     TextButton(
//                       onPressed: () {
//
//                           _sendeditRoutineToBackend();
//                           // _showMedicationOptionsDialog(context);
//
//                       },
//                       child: Text('OK'),
//                     ),
//                   ],
//                 ),
//               ),
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//       appBar: AppBar(
//           actions: [
//             // ElevatedButton(onPressed: () {
//             //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
//             //       AddingMedicineone(
//             //         // name: '',
//             //         // gender: '',
//             //         // dateOfBirth:'',
//             //         // healthCondition:'', // Pass the new field
//             //         // height: '', // Pass the new field
//             //         // weight: '', userId: 45, // Pass the new field
//             //       )));
//             //
//             // }, child: Text('Skip', style: text40018primary)),
//             SizedBox(width: 10),
//           ],
//           leading: Dronewidgets.backButton(context)),
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SingleChildScrollView(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(height: 20,),
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(text: 'How does your ', style: text60024),
//                       TextSpan(text: 'day', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: AppColors.primaryColor2)),
//                       TextSpan(text: ' look like?', style: text60024),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 Container(
//                   decoration: BoxDecoration(
//                   ),
//                   height: 500,
//                   child: Stack(
//                     children: [
//                       Container(
//                         decoration: BoxDecoration(),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             children: [
//                               Center(
//                                 child: Stack(
//                                   children: [
//                                     // Adjust the position of the first time picker (Wake up) and add some space above the asset
//                                     Positioned(left: 80, top: 10, child: _buildTimePickerContainer(0)),  // Moved top to 10 to make it more visible
//                                     Padding(
//                                       padding: const EdgeInsets.only(top: 50.0), // Added more space above the image
//                                       child: Image.asset('assets/images/s.png'),
//                                     ),
//                                     Positioned(left: 5,top: 22, child: _buildTooltip('Wake up', 'assets/images/awaken.png')),
//
//                                     // Other time pickers remain the same, but we can tweak them as needed for spacing and visibility
//                                     Positioned(right: 110, top: 90, child: _buildTimePickerContainer(1)),
//                                     Positioned(right: 50,top: 25, child: _buildTooltip('Exercise', 'assets/images/exercising.png')),
//
//                                     Positioned(right: 115, top: 190, child: _buildTimePickerContainer(2)),
//                                     Positioned(right: 50, top: 210, child: _buildTooltip('Breakfast', 'assets/images/breakfast 1.png')),
//
//                                     Positioned(left: 80, top: 270, child: _buildTimePickerContainer(3)),
//                                     Positioned(top: 240, left: 10, child: _buildTooltip('Lunch', 'assets/images/lunch-box.png')),
//
//                                     Positioned(left: 80, top: 360, child: _buildTimePickerContainer(4)),
//                                     Positioned(left: 80, top: 400, child: _buildTooltip('Dinner', 'assets/images/roti 1.png')),
//
//                                     Positioned(top: 400, right: 20, child: _buildTooltip('Sleep', 'assets/images/sleep.png')),
//                                     Positioned(right: 20, top: 360, child: _buildTimePickerContainer(5)),
//
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(height: 150,)
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTimePickerContainer(int index) {
//     if (isLoading) {
//       return CircularProgressIndicator(); // Show a loading indicator
//     } else if (routineTimes.isNotEmpty) {
//       return GestureDetector(
//         onTap: () => _selectTime(index),
//         child: Container(
//           width: 100,
//           decoration: BoxDecoration(
//             color: Colors.grey.shade100,
//             borderRadius: BorderRadius.circular(50),
//           ),
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Center(child: Text('${routineTimes[index].format(context)}')),
//           ),
//         ),
//       );
//     }
//
//     return SizedBox.shrink(); // Return an empty box if no data
//   }
//
//   Future<void> _selectTime(int index) async {
//     final picked = await showTimePicker(context: context, initialTime: routineTimes[index]);
//     if (picked != null) setState(() => routineTimes[index] = picked);
//   }
//
//   Widget _buildTooltip(String message, String imagePath) {
//     return Tooltip(
//       message: message,
//       child: CircleAvatar(
//         radius: 35,
//         backgroundColor: Color.fromRGBO(125, 210, 255, 1),
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: Image.asset(imagePath),
//         ),
//       ),
//     );
//   }
//
//   // Your medicationOptionsContainer function
//   static Widget medicationOptionsContainer(BuildContext context) {
//     return Container(
//
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             'Do you have any past orders or need to add it manually?',
//             style: TextStyle(
//               fontSize: 18,
//               fontWeight: FontWeight.normal,
//               color: Colors.grey,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 20),
//           // "Past order" button
//           Dronewidgets.mainButton(title: 'Past order', onPressed: (){
//             Navigator.pop(context);
//
//           }
//           ),
//           SizedBox(height: 12),
//
//           // "Add Medication" button
//           Dronewidgets.mainButton(title: 'Add Medication', onPressed: (){
//             // Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));
//             Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(builder: (context) => AddingMedicineone()),
//                   (Route<dynamic> route) => false, // This removes all previous routes
//             );
//
//           })
//
//         ],
//       ),
//     );
//   }
// }



import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class EditDailyRoutine extends StatefulWidget {
  const EditDailyRoutine({super.key});

  @override
  State<EditDailyRoutine> createState() => _EditDailyRoutineState();
}

class _EditDailyRoutineState extends State<EditDailyRoutine> {

  static var getRoutine = 'http://13.232.117.141:3003/medone/getUserRoutine';
  static var editRoutine = 'http://13.232.117.141:3003/medone/editroutine';

  List<dynamic> routineData = []; // To hold the routine data
  List<TimeOfDay> routineTimes = List.generate(6, (index) => TimeOfDay.now());
  bool isLoading = true; // To handle loading state

  List<TimeOfDay> selectedTimes = [
    TimeOfDay(hour: 7, minute: 0),
    TimeOfDay(hour: 8, minute: 0),
    TimeOfDay(hour: 9, minute: 0),
    TimeOfDay(hour: 13, minute: 0),
    TimeOfDay(hour: 20, minute: 0),
    TimeOfDay(hour: 22, minute: 0),
  ];
  String _timeOfDayToString(TimeOfDay time) {
    final hours = time.hour == 0 ? 12 : (time.hour > 12 ? time.hour - 12 : time.hour);
    final minutes = time.minute.toString().padLeft(2, '0');
    final amPm = time.hour >= 12 ? 'PM' : 'AM';
    return '$hours:$minutes $amPm';
  }

  @override
  void initState() {
    super.initState();
    _fetchRoutine();
  }

  Map<String, dynamic> _convertToRoutine(int userid) {
    return {
      'userId': int.parse(userid.toString()),
      'routine': [
        {
          'wakeUp': _timeOfDayToString(selectedTimes[0]),
          'exercise': _timeOfDayToString(selectedTimes[5]),
          'breakfast': _timeOfDayToString(selectedTimes[1]),
          'lunch': _timeOfDayToString(selectedTimes[2]),
          'dinner': _timeOfDayToString(selectedTimes[3]),
          'sleep': _timeOfDayToString(selectedTimes[4]),
        },
      ],
    };
  }

  Future<void> _fetchRoutine() async {
    final url = Uri.parse(getRoutine);
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      String? userID = preferences.getString('userID');
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'userId': int.parse(userID.toString())}),
      );
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        print('fetched...:${responseData}');
        setState(() {
          routineData = responseData['data'];
          _parseRoutineTimes();
          isLoading = false;
        });

      } else {
        // Handle error
        setState(() {
          isLoading = false;
        });
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      _showFlushbar("Error fetching routine: $error", Colors.red);
    }
  }

  Future<void> _sendeditRoutineToBackend() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userId = preferences.getString('userID');
    final routineData = _convertToRoutine(int.parse(userId.toString()));
    print('my rt data$routineData');
    final url = Uri.parse(editRoutine);
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(routineData),
      );
      if (response.statusCode == 200) {
        _showFlushbar("Routine saved successfully!", Colors.green);
        print('Routine saved: ${response.body}');
        print('Routine datas: ${routineData}');

        // Navigator.pushAndRemoveUntil(
        //   context,
        //   MaterialPageRoute(builder: (context) => BottomNavigation()),
        //       (Route<dynamic> route) => false, // This condition removes all previous routes
        // );
      } else {
        _showFlushbar("Failed to save routine. Error: ${response.statusCode}", Colors.red);
      }
    } catch (error) {
      _showFlushbar("Error sending data: $error", Colors.red);
    }
  }

  void _showMedicationOptionsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: Colors.blue,

        content: medicationOptionsContainer(context),

      ),
    );
  }

  void _parseRoutineTimes() {
    if (routineData.isNotEmpty) {
      final routine = routineData[0]['routine'][0];
      routineTimes = [
        _stringToTimeOfDay(routine['wakeUp']),
        _stringToTimeOfDay(routine['exercise']),
        _stringToTimeOfDay(routine['breakfast']),
        _stringToTimeOfDay(routine['lunch']),
        _stringToTimeOfDay(routine['dinner']),
        _stringToTimeOfDay(routine['sleep']),
      ];
    }
  }


  TimeOfDay _stringToTimeOfDay(String timeString) {
    final parts = timeString.split(' ');
    final timeParts = parts[0].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    // Adjust hour for AM/PM
    if (parts[1] == 'PM' && hour != 12) {
      return TimeOfDay(hour: hour + 12, minute: minute);
    } else if (parts[1] == 'AM' && hour == 12) {
      return TimeOfDay(hour: 0, minute: minute);
    }
    return TimeOfDay(hour: hour, minute: minute);
  }

  void _showFlushbar(String message, Color color) {
    Flushbar(
      message: message,
      backgroundColor: color,
      duration: Duration(seconds: 3),
    )..show(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Dronewidgetss.mainButton(
          title: 'Edit Routine',
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


                        _sendeditRoutineToBackend();
                        // _showMedicationOptionsDialog(context);
                      },
                      child: Text('OK'),
                    ),
                  ],
                ),
              ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
          actions: [
            // ElevatedButton(onPressed: () {
            //   Navigator.push(context, MaterialPageRoute(builder: (context) =>
            //       AddingMedicineone(
            //         // name: '',
            //         // gender: '',
            //         // dateOfBirth:'',
            //         // healthCondition:'', // Pass the new field
            //         // height: '', // Pass the new field
            //         // weight: '', userId: 45, // Pass the new field
            //       )));
            //
            // }, child: Text('Skip', style: text40018primary)),
            SizedBox(width: 10),
          ],
          leading: Dronewidgetss.backButton(context)),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'How does your '),
                        TextSpan(text: 'day', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24, color: Colors.blue)),
                        TextSpan(text: ' look like?'),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      SizedBox(height:540,child: Image.asset('assets/images/s.png',)),
                      Positioned(left: 65, top: 45, child: _buildTimePickerContainer(0)),
                      Positioned(top: 60,left: 10, child: _buildTooltip('Wake up', 'assets/images/exercising.png')),

                      Positioned(right: 100, top: 115, child: _buildTimePickerContainer(1)),
                      Positioned(top: 60,right: 50, child: _buildTooltip('Exercise', 'assets/images/breakfast 1.png')),

                      Positioned(right: 110, top: 200, child: _buildTimePickerContainer(2)),
                      Positioned(right: 50, top: 230, child: _buildTooltip('Breakfast', 'assets/images/lunch-box.png')),

                      Positioned(left: 80, top: 290, child: _buildTimePickerContainer(3)),
                      Positioned(top: 260, left: 10, child: _buildTooltip('Lunch', 'assets/images/lunch-box.png')),

                      Positioned(left: 120, top: 390, child: _buildTimePickerContainer(4)),
                      Positioned(left: 40, top: 400, child: _buildTooltip('Dinner', 'assets/images/lunch-box.png')),

                      Positioned(top: 400, right: 20, child: _buildTooltip('Sleep', 'assets/images/lunch-box.png')),
                      Positioned(right: 80, top: 460, child: _buildTimePickerContainer(5)),
                    ],
                  ),
                  SizedBox(height: 30,)

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTimePickerContainer(int index) {
    if (isLoading) {
      return CircularProgressIndicator(); // Show a loading indicator
    } else if (routineTimes.isNotEmpty) {
      return GestureDetector(
        onTap: () => _selectTime(index),
        child: Container(
          width: 100,
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(child: Text('${routineTimes[index].format(context)}')),
          ),
        ),
      );
    }


    return SizedBox.shrink(); // Return an empty box if no data
  }

  Future<void> _selectTime(int index) async {
    final picked = await showTimePicker(context: context, initialTime: routineTimes[index]);
    if (picked != null) setState(() => routineTimes[index] = picked);
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
          Dronewidgetss.mainButton(title: 'Past order', onPressed: (){
            Navigator.pop(context);

          }
          ),
          SizedBox(height: 12),

          // "Add Medication" button
          Dronewidgetss.mainButton(title: 'Add Medication', onPressed: (){
            // Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone()));
            // Navigator.pushAndRemoveUntil(
            //   context,
            //   MaterialPageRoute(builder: (context) => AddingMedicineone()),
            //       (Route<dynamic> route) => false, // This removes all previous routes
            // );

          })

        ],
      ),
    );
  }
}

class Dronewidgetss {
  // Main button widget with customizable onPressed functionality
  static Widget mainButton({
    required String title,
    required VoidCallback onPressed,
    Color? backgroundColor, // Optional parameter for button background color
    Color? textColor, // Optional parameter for text color
    FocusNode? fieldFocus,
  }) {
    return Container(
      width: 350,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed, // Use the passed onPressed function
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? Colors.blue,
          // Use passed background color or default
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
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: textColor ??
                  Colors.white, // Use passed text color or default to white
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
        backgroundColor: Colors.blue,
        child: IconButton(
          padding: EdgeInsets.zero, // Remove the default padding
          constraints: BoxConstraints(), // Remove any size constraints
          onPressed: () {
            Navigator.pop(context); // Navigate back
          },
          icon: Icon(
            Icons.arrow_back_ios_rounded,
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
    FocusNode? fieldFocus,
    bool obscureText = false, // Add obscureText parameter with a default value
    Widget? suffixIcon, // Add suffixIcon parameter
    String? Function(String?)? validator, // Add validator parameter
    String? Function(String?)? onFieldSubmitted,
  }) {
    return Container(
      width: 390,
      height: 55,
      child: TextFormField(
        controller: controller,
        // Use the passed controller
        focusNode: fieldFocus,
        obscureText: obscureText,
        // Use the passed obscureText value
        decoration: InputDecoration(
          hintText: hintText ?? '',
          // Set the placeholder text if provided
          filled: true,
          fillColor: Colors.green,
          contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
          // Padding inside the field
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
        validator: validator,
        // Use the validator if provided
        onFieldSubmitted: onFieldSubmitted,
      ),
    );
  }
}