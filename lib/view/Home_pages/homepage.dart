import 'package:flutter/material.dart';
import 'package:med_one/app_colors.dart';

import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';



class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello,,",
              style: text60022,
            ),
            SizedBox(height: 9),
            Text(
              "HEAVN JOE",
              style: text60022,
            ),
            SizedBox(height: 26),
            Text(
              "Today’s Medicine",
              style: text60031,
            ),
            Text(
              "Reminder",
              style: text60031,
            ),
            SizedBox(height: 50),

            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: BoxDecoration(
                    color: AppColors.homecardcolor1,
                    borderRadius: BorderRadius.circular(9)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Row(
                            children: [
                              Icon(Icons.access_alarm,size: 35,color: AppColors.whiteColor,),
                              Text('Everyday Medicine',style: TextStyle(color: AppColors.whiteColor),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 25.0),
                          child: Text('Insulin',style: TextStyle(fontSize: 28,color: AppColors.whiteColor),),
                        ),
                        SizedBox(height: 10,),

                        Text('Take your morning insulin',style: TextStyle(color: AppColors.whiteColor)),
                        Text('before 30 min of breakfast',style: TextStyle(color: AppColors.whiteColor),)

                      ]
                    ),
                  ),
                ),
                Positioned(
                  top: 10,right: 10,
                    child: Image.asset('assets/images/doctor.png',height: 150,)),
              ],
            )
          ],
        ),
      ),
    );
  }
}

