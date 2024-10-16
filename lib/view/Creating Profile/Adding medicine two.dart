
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart'; // Required for date formatting
import 'package:lottie/lottie.dart';

import 'package:med_one/app_colors.dart';
import 'package:med_one/res/appurl.dart';

import '../../Utils.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import '../bottomnavigation.dart';
import 'package:http/http.dart' as http;

import 'Adding medcine one.dart';
class AddingMedicineTwo extends StatefulWidget {
  final Map<String, dynamic> selectedMedicine;
  final String medicineName;
  final String medicineType;

  const AddingMedicineTwo(
      {Key? key, required this.medicineName, required this.medicineType,required this.selectedMedicine})
      : super(key: key);

  @override
  State<AddingMedicineTwo> createState() => _AddingMedicineTwoState();
}

class _AddingMedicineTwoState extends State<AddingMedicineTwo> {
  bool isBeforeFood = true;
  bool isMorning = false;
  bool isAfternoon = false;
  bool isNight = false;

  DateTime? _selectedStartDate; // To store the selected date

  TextEditingController totalQuantityController = TextEditingController();
  TextEditingController takingQuantityController = TextEditingController();
  TextEditingController startDateController = TextEditingController();
  TextEditingController numofDaysController = TextEditingController();
  TextEditingController timeIntervalController = TextEditingController();
  TextEditingController dateIntervalController = TextEditingController();

  FocusNode totalQuantityNode = FocusNode();
  FocusNode takingQuantityNode = FocusNode();
  FocusNode startDateNode = FocusNode();
  FocusNode numofDaysNode = FocusNode();
  FocusNode timeIntervalNode = FocusNode();
  FocusNode dateIntervalNode = FocusNode();

  final String apiUrl = AppUrl.addMedcineSchedule; // Replace with your actual API URL
  List<String> selectedTimings = [];

  // Function to toggle the selection of timings
  void _toggleTiming(String timing, bool isSelected) {
    setState(() {
      if (isSelected) {
        selectedTimings.add(timing); // Add timing to the list if selected
      } else {
        selectedTimings.remove(timing); // Remove timing from the list if deselected
      }
    });
  }

  Future<void> addMedicineData(dynamic postData) async {
    final url = Uri.parse(apiUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(postData), // Convert the map to JSON
      );
      print('respppp:${jsonDecode(response.body)}');
      if (response.statusCode == 200) {
        // If the server returns a 200 OK response
        final jsonResponse = jsonDecode(response.body);
        print('Response data: $jsonResponse');
       _showSuccessDialogOnmedication();
        // Utils.flushBarSuccessMessage('${jsonResponse['message']}', context);
        // Handle the response data here, for example, show a success message
      } else {
        final jsonResponse = jsonDecode(response.body);
        Utils.flushBarErrorMessage('${jsonResponse['message']}', context);
        print('Failed to send data. Status code: ${response.statusCode}');
        // Handle the error here, for example, show an error message
      }
    } catch (e) {
      print('Error sending data: $e');
      // Handle network or parsing error
    }
  }

  @override
  void initState() {
    print('sshshshsh::${widget.selectedMedicine}');
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pageColor,
        leading: Dronewidgets.backButton(context),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(widget.medicineName, style: text60024),
          const SizedBox(height: 27),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildToggleButton('Before food', isBeforeFood, () {
                setState(() {
                  isBeforeFood = true;
                });
              }),
              _buildToggleButton('After food', !isBeforeFood, () {
                setState(() {
                  isBeforeFood = false;
                });
              }),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            "Total Quantity",
            style: text50018primary,
          ),
          TextFormField(
            controller:totalQuantityController ,
            keyboardType: TextInputType.number, // Allows number input
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(fontSize: 18),
            decoration:
            const InputDecoration(hintText: 'Enter the quantity'),
          ),
          const SizedBox(height: 20),
          Text(
            "Taking quantity at a time",
            style: text50018primary,
          ),
          TextFormField(
            controller: takingQuantityController,
            keyboardType: TextInputType.number, // Allows number input
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            style: const TextStyle(fontSize: 18),
            decoration:
            const InputDecoration(hintText: 'Enter the quantity'),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Column(
                children: [
                  SizedBox(height: 30,),
                  Text(
                    "Start date",
                    style: text50018primary,
                  ),
                ],
              ),
              const SizedBox(width: 10),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    _selectStartDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextFormField(
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(bottom: -50),
                        hintText: _selectedStartDate == null
                            ? 'Select date'
                            : DateFormat('yyyy-MM-dd').format(
                            _selectedStartDate!), // Display selected date
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Column(
                  children: [
                    SizedBox(height: 30,),
                    Text(
                      "No.of days",
                      style: text50018primary,
                    ),
                  ],


              ),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: numofDaysController,
                  keyboardType: TextInputType.number, // Allows number input
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(bottom: -20),
                      hintText: 'Type here'),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Timing',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 11),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildTimingButton('Morning', isMorning, () {
                setState(() {
                  isMorning = !isMorning;
                  _toggleTiming('Morning', isMorning);
                });
              }),
              _buildTimingButton('Afternoon', isAfternoon, () {
                setState(() {
                  isAfternoon = !isAfternoon;
                  _toggleTiming('Afternoon', isAfternoon);
                });
              }),
              _buildTimingButton('Night', isNight, () {
                setState(() {
                  isNight = !isNight;
                  _toggleTiming('Night', isNight);
                });
              }),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 50.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    endIndent: 20,
                  ),
                ),
              ),
              Text('Or', style: text40024black),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 50.0),
                  child: Divider(
                    color: Colors.grey,
                    thickness: 1,
                    indent: 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                "Every",
                style: text50018primary,
              ),
              const SizedBox(width: 10),
              SizedBox(
                width: 95,
                child: TextFormField(
                  controller: timeIntervalController,
                  decoration:
                  const InputDecoration(hintText: 'Enter hours'),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                "hours",
                style: text50018primary,
              ),
            ],
          ),
          Row(
            children: [
            Text(
            "Every",
            style: text50018primary,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: 95,
            child: TextFormField(
                controller: dateIntervalController,
                keyboardType: TextInputType.number, // Allows number input
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],


                style: const TextStyle(fontSize: 18),
            decoration: const InputDecoration(hintText: 'Enter days'),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          "days",
          style: text50018primary,
        )
        ],
      ),
      const SizedBox(height: 100),
      ],
    ),
    ),
    ),
    floatingActionButton: Dronewidgets.mainButton(
    title: 'Next',
    onPressed: () {
    var data = {
    "userId": 45,
    "medicine":'${[widget.selectedMedicine]}',
    "medicine_type": widget.medicineType,
    "startDate": DateFormat('d-MM-yyyy').format(_selectedStartDate!),
    "no_of_days": numofDaysController.text,
    "afterFd_beforeFd": isBeforeFood == false ? 'After food':'Before food',
    "totalQuantity": totalQuantityController.text,
    "timing": selectedTimings,
    "takingQuantity": takingQuantityController.text,

    //or
    // "timeInterval":timeIntervalController,
    // "daysInterval":dateIntervalController,
    };
    addMedicineData(data);
    },
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  // Method to show the date picker and store selected date
  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedStartDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedStartDate) {
      setState(() {
        _selectedStartDate = picked;
      });
    }
  }

  Widget _buildToggleButton(
      String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        isSelected ? AppColors.primaryColor2 : AppColors.textfiedlColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: isSelected ? Colors.white : AppColors.textColor1,
        ),
      ),
    );
  }

  Widget _buildTimingButton(
      String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor:
        isSelected ? AppColors.primaryColor2 : AppColors.textfiedlColor,
        padding: const EdgeInsets.all(24),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 14,
          color: isSelected ? Colors.white : AppColors.textColor1,
        ),
      ),
    );
  }
  void _showSuccessDialogOnmedication() {
    showDialog(
      context: context,
      barrierDismissible: false, // Prevent closing by tapping outside the dialog
      builder: (BuildContext context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Lottie.asset(
                'assets/lottie/profiledone1.json', // Path to your Lottie animation file
                height: 183,
                width: 189,
              ),
              Text(
                'You have successfully added',
                style: TextStyle(fontSize: 16),
              ),
              Center(
                child: Text(
                  'medicne name',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10,),
              Dronewidgets.mainButton(title: 'Add Medication', onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AddingMedicineone(),));
              }),
              SizedBox(height: 10,),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNavigation()),
                  );

                },
                child: Text('I’m done'),
              ),
            ],
          ),

        );
      },
    );
  }
}