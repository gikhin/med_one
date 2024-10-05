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
            Container(
              height: 235,
              width: 391,
              decoration: BoxDecoration(color: AppColors.homecardcolor1
              ,borderRadius: BorderRadius.all(Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/icons/alaramclock.png',height: 40,width: 40,),
                    SizedBox(width: 10,),
                    Column(mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Everyday Medicine',style: text50022white,),
                        SizedBox(width: 14,),
                        Text('Insulin',style: text50022white,),
                        SizedBox(width: 8,),
                        Text('Take your morning insulin',style: text40014,),
                        Text('before 30 min of breakfast',style: text40014,),

                      ],
                    ),
                    Image.asset('assets/images/doctor.png',height: 40,width: 40,),


                  ],
                ),
              ),
            )


          ],

        ),
      ),



    );
  }
}

