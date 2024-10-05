import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../app_colors.dart';
import '../../constants.dart';
import '../../widgets/CustomWidgets.dart';
import 'Adding medicine two.dart';

class AddingMedicineone extends StatefulWidget {
  const AddingMedicineone({super.key});

  @override
  State<AddingMedicineone> createState() => _AddingMedicineoneState();
}

class _AddingMedicineoneState extends State<AddingMedicineone> {
  String? _selectedMedicine;
  String? fileName;

  Future<void> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddingMedicineTwo(),));
              },
            ),
          ),

        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Now,",
                style: text50026primary,
              ),
              SizedBox(height: 8),
              Text(
                "Let’s Add Medicine",
                style: text50026primary,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Enter your medicine here'),
              ),
              SizedBox(height: 30),
              Text(
                "Select medicine type",
                style: text50018primary,
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => _selectMedicine('Medicine'),
                    child: _MedicineContainer('Medicine', 'assets/images/medicine.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Syringe'),
                    child: _MedicineContainer('Syringe', 'assets/images/syringe.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Syrup'),
                    child: _MedicineContainer('Syrup', 'assets/images/syrup.png'),
                  ),
                  GestureDetector(
                    onTap: () => _selectMedicine('Ointment'),
                    child: _MedicineContainer('Ointment', 'assets/images/ointment.png'),
                  ),
                ],
              ),

              SizedBox(height: 50,),

              InkWell(
                onTap: (){
                  pickFile();

                },
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Image.asset(
                        //   'assets/images/gallery.png',
                        //   height: 36, // Adjusted size
                        //   width: 36,  // Adjusted size
                        // ),
                        fileName != null ? Icon(Icons.photo,color: AppColors.primaryColor2,) : Icon(Icons.photo,color: Colors.grey,),
                        SizedBox(width: 10,),
                        Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Take photo of medicine',style: text50012primary,),
                            Text(' to identify',style: text50012primary,),
                          ],
                        ),



                      ],
                    ),

                    width: 280,
                    height: 108,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _selectMedicine(String medicineType) {
    setState(() {
      _selectedMedicine = medicineType;
    });
  }

  Widget _MedicineContainer(String medicineType, String imagePath) {
    bool isSelected = _selectedMedicine == medicineType;
    return Container(
      width: 68,
      height: 67,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primaryColor2 : Colors.grey[300],
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            height: 40, // Adjusted size
            width: 40,  // Adjusted size
          ),

        ],
      ),
    );
  }
}
