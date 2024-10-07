import 'package:flutter/material.dart';
import 'package:med_one/app_colors.dart';

import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import '../bottomnavigation.dart';

class AddingMedicineTwo extends StatefulWidget {
  const AddingMedicineTwo({Key? key}) : super(key: key);

  @override
  State<AddingMedicineTwo> createState() => _AddingMedicineTwoState();
}

class _AddingMedicineTwoState extends State<AddingMedicineTwo> {
  bool isBeforeFood = true;
  bool isMorning = true;
  bool isAfternoon = false;
  bool isNight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: Dronewidgets.backButton(context),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Paracetamol',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
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
            const SizedBox(height: 31),
            Text(
              "Quantity",
              style: text50018primary,
            ),
            SizedBox(height: 15),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Enter the quantity'),
            ),
            const SizedBox(height: 54),
            Row(
              children:  [
                Text(
                  "Start date",
                  style: text50018primary,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(

                        fillColor: AppColors.primaryColor2,
                        hintText: 'type here'),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "No.of days",
                  style: text50018primary,
                ),
                SizedBox(width: 10),
                Expanded(
                  child: TextFormField(
                    decoration: const InputDecoration(hintText: 'type here'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 54),
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
                    isMorning = true;
                    isAfternoon = false;
                    isNight = false;
                  });
                }),
                _buildTimingButton('Afternoon', isAfternoon, () {
                  setState(() {
                    isMorning = false;
                    isAfternoon = true;
                    isNight = false;
                  });
                }),
                _buildTimingButton('Night', isNight, () {
                  setState(() {
                    isMorning = false;
                    isAfternoon = false;
                    isNight = true;
                  });
                }),
              ],
            ),
            SizedBox(height: 43,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0),
                    child: Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      endIndent: 20, // Space between line and text
                    ),
                  ),
                ),
                Text('Or', style: text40024black),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Divider(
                      color: Colors.grey, // Line color
                      thickness: 1, // Line thickness
                      indent: 20, // Space between line and text
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 58),
            Row(
              children: [
                Text(
                  "Every",
                  style: text50018primary,
                ),
                SizedBox(width: 10),
                SizedBox(
                  height: 50,width: 95,
                  child: Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(hintText: 'Enter hours'),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  "hours",
                  style: text50018primary,
                )
              ],
            ),


          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(

            child: Dronewidgets.mainButton(
              title: 'Next',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => BottomNavigation(),));
              },
            ),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildToggleButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isSelected ? AppColors.primaryColor2 : AppColors.textfiedlColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,
          color: isSelected ? Colors.white : AppColors.textColor1,
        ),
      ),
    );
  }

  Widget _buildTimingButton(String text, bool isSelected, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: isSelected ? AppColors.primaryColor2 : AppColors.textfiedlColor,

        padding: const EdgeInsets.all(24),
      ),
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,
          color: isSelected ? Colors.white : AppColors.textColor1,
        ),
      ),
    );
  }
}
