import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/view/Home_pages/homepage.dart';

import '../../widgets/CustomWidgets.dart';
import '../bottomnavigation.dart';

class AddingMedicineTwo extends StatefulWidget {
  const AddingMedicineTwo({super.key});

  @override
  State<AddingMedicineTwo> createState() => _AddingMedicineTwoState();
}

class _AddingMedicineTwoState extends State<AddingMedicineTwo> {
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
      body: Column(
        children: [
          Text('AddingMedicineTwo')
        ],
      ),
    );
  }
}
