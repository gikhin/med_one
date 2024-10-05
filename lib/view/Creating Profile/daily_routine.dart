import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../widgets/CustomWidgets.dart';
import 'Adding medcine one.dart';

class DailyRoutine extends StatefulWidget {
  const DailyRoutine({super.key});

  @override
  State<DailyRoutine> createState() => _DailyRoutineState();
}

class _DailyRoutineState extends State<DailyRoutine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white,
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
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            height: 61,
            width: 161,
            child: Dronewidgets.mainButton(
              title: 'Next',
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineone(),));
              },
            ),
          ),
          Container(
            height: 61,
            width: 161,
            child: Dronewidgets.mainButton(
              title: 'Skip',
              onPressed: () {
                // Handle skip action
              },
              backgroundColor: AppColors.primaryColor3,
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Column(
        children: [
          Text('daily routine')
        ],
      ),

    );
  }
}
