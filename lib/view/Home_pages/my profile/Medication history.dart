import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:med_one/constants.dart';
import '../../../app_colors.dart';
import '../../../widgets/CustomWidgets.dart';

class MedicationHistories extends StatefulWidget {
  const MedicationHistories({super.key});

  @override
  State<MedicationHistories> createState() => _MedicationHistoriesState();
}

class _MedicationHistoriesState extends State<MedicationHistories> {
  // Sample list of medication data
  final List<Map<String, dynamic>> medications = [
    {
      'name': 'Insulin',
      'status': 'Taken',
      'date': '06-10-2024',
      'time': 'Monday Morning 8:00 AM',
      'color': AppColors.containercolorgreen,
    },
    {
      'name': 'Paracetamol',
      'status': 'Skipped',
      'date': '06-10-2024',
      'time': 'Monday Morning 8:00 AM',
      'color': AppColors.containercolorRed,
    },
    // Add more entries here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppColors.pageColor,
        leading: Dronewidgets.backButton(context),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(),
          )
        ],
        title: const Text(
          'Medication history',
          style: text40016black,
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: medications.length,
        padding: const EdgeInsets.symmetric(vertical: 16),
        itemBuilder: (context, index) {
          final medication = medications[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
            child: Container(
              height: 115,
              width: 390,
              decoration: BoxDecoration(
                color: medication['color'],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(medication['name'], style: text40018black),
                        Text(medication['status'], style: text60014black),
                      ],
                    ),
                    Text('Taken on ${medication['date']}', style: text40012black),
                    Text(medication['time'], style: text40012black),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
