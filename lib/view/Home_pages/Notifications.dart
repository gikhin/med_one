import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/app_colors.dart';
import 'package:med_one/constants.dart';

import '../../widgets/CustomWidgets.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.pageColor,
      appBar: AppBar(backgroundColor: AppColors.pageColor,
        leading: Dronewidgets.backButton(context),
        title: Text('Notification',style: text40014black,),centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(color: AppColors.containercolor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(),SizedBox(width: 20,),
                        Text('Time to take Your pill')
                      ],
                    ),
                    SizedBox(height: 20,),
                    Text('It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.')
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
